import 'package:easy_localization/easy_localization.dart';

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:leuko_care/core/helpers/localization_helper.dart';
import 'package:leuko_care/core/helpers/shared_pref_helper.dart';
import 'package:leuko_care/core/networking/send_notification_services.dart';
import '../models/chat_model.dart';

class ChatRepository {
  final FirebaseFirestore _firestore;

  ChatRepository(this._firestore);

  Stream<List<ChatModel>> getMessages({
    required String senderId,
    required String receiverId,
  }) {
    final chatId = _getChatId(senderId, receiverId);

    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final msg = ChatModel.fromJson(doc.data());
              return msg.copyWith(status: MessageStatus.sent);
            }).toList());
  }

  Future<void> sendMessage(ChatModel message) async {
    try {
      final chatId = _getChatId(message.senderId, message.receiverId);
      final userType = await SharedPrefHelper.getString('userType');
      final senderName = await getSenderName(message.senderId, userType);
      final isImageMessage = message.text.isEmpty;
      final receiverType = userType == 'doctor' ? 'patient' : 'doctor';
      final language = await getReceiverLanguage(message.receiverId, receiverType);

      final title = await _buildNotificationTitle(userType, senderName, language);
      final body = isImageMessage
          ? await getLocalizedText(key: 'image_message', languageCode: language)
          : message.text;

      final docRef = await _addMessageToFirestore(chatId, message);

      final updatedMessage = message.copyWith(id: docRef.id);
      await docRef.update(updatedMessage.toJson());

      await _updateOrCreateConversation(updatedMessage);
      await _sendFcmNotifications(updatedMessage, chatId, title, body);

      print("Message sent with id: ${docRef.id}");
    } catch (e) {
      print('Error sending message: $e');
      throw Exception('Failed to send message'.tr());
    }
  }

  Future<DocumentReference<Map<String, dynamic>>> _addMessageToFirestore(String chatId, ChatModel message) async {
    final data = message.toJson();
    data.remove('id');
    return await _firestore.collection('chats').doc(chatId).collection('messages').add(data);
  }

  Future<void> _sendFcmNotifications(ChatModel message, String chatId, String title, String body) async {
    final tokenDoc = await _firestore.collection('fcmTokens').doc(message.receiverId).get();

    if (!tokenDoc.exists) {
      print("No FCM tokens found for user ${message.receiverId}");
      return;
    }

    final tokens = List<String>.from(tokenDoc.data()?['tokens'] ?? []);
    for (final token in tokens) {
      if (token.isNotEmpty) {
        print('Sending notification to token: $token');
        await sendNotification(
          token: token,
          title: title,
          body: body,
          data: {
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'senderId': message.senderId,
            'receiverId': message.receiverId,
            'type': 'chat',
            'chatId': chatId,
          },
        );
      }
    }
  }

  Future<String> _buildNotificationTitle(String userType, String senderName, String language) async {
    final name = userType == 'doctor' ? "Dr. $senderName" : senderName;
    return await getLocalizedText(
      key: 'new_message_from',
      languageCode: language,
      namedArgs: {'name': name},
    );
  }

  Future<void> _updateOrCreateConversation(ChatModel message) async {
    final conversationId = _getChatId(message.senderId, message.receiverId);
    final conversationRef = _firestore.collection('conversations').doc(conversationId);
    final isImageMessage = message.text.trim().isEmpty;
    final lastMessageContent = isImageMessage ? message.attachmentUrl : message.text;
    final conversationSnapshot = await conversationRef.get();

    final updateData = {
      'lastMessage': lastMessageContent,
      'lastMessageTime': message.timestamp,
      'lastMessageSenderId': message.senderId,
      'hasUnreadMessagesByParticipant.${message.senderId}': false,
      'hasUnreadMessagesByParticipant.${message.receiverId}': true,
    };

    if (conversationSnapshot.exists) {
      await conversationRef.update(updateData);
    } else {
      await conversationRef.set({
        'id': conversationId,
        'participantAId': message.senderId,
        'participantBId': message.receiverId,
        ...updateData,
        'hasUnreadMessagesByParticipant': {
          message.senderId: false,
          message.receiverId: true,
        },
      });
    }
  }

  Future<String> getSenderName(String senderId, String userType) async {
    try {
      final collection = userType == 'doctor' ? 'doctors' : 'patients';
      final doc = await _firestore.collection(collection).doc(senderId).get();
      return doc.exists ? (doc.data()?['name'] ?? '') : '';
    } catch (e) {
      print('Error getting sender name: $e');
      return '';
    }
  }

  Future<String> getReceiverLanguage(String receiverId, String userType, {String defaultLang = 'en'}) async {
    try {
      final collection = userType == 'doctor' ? 'doctors' : 'patients';
      final documentSnapshot = await _firestore.collection(collection).doc(receiverId).get();
      return documentSnapshot.exists ? (documentSnapshot.data()?['language'] ?? defaultLang) : defaultLang;
    } catch (e) {
      print('Error getting receiver language: $e');
      return defaultLang;
    }
  }

  Future<void> markMessagesAsReadByDoctor(String doctorId, String patientId) async {
    final chatId = _getChatId(doctorId, patientId);
    final conversationRef = _firestore.collection('conversations').doc(chatId);
    final snapshot = await conversationRef.get();
    if (snapshot.exists) {
      await conversationRef.update({ 'hasUnreadMessagesByParticipant.$doctorId': false });
    }
  }

  Future<void> markMessagesAsReadByPatient(String patientId, String doctorId) async {
    final chatId = _getChatId(doctorId, patientId);
    final conversationRef = _firestore.collection('conversations').doc(chatId);
    final snapshot = await conversationRef.get();
    if (snapshot.exists) {
      await conversationRef.update({ 'hasUnreadMessagesByParticipant.$patientId': false });
    }
  }

  Future<String> uploadImageToCloudinary({String? imagePath, Uint8List? imageBytes}) async {
    final url = Uri.parse('https://api.cloudinary.com/v1_1/dmhmhyigi/image/upload');
    final uploadRequest = http.MultipartRequest('POST', url)..fields['upload_preset'] = 'leuko_care';

    http.MultipartFile? imageFile;
    if (imagePath != null && imagePath.isNotEmpty) {
      final bytes = await File(imagePath).readAsBytes();
      imageFile = http.MultipartFile.fromBytes('file', bytes, filename: 'chat_image.jpg');
    } else if (imageBytes != null) {
      imageFile = http.MultipartFile.fromBytes('file', imageBytes, filename: 'chat_image.jpg');
    }

    if (imageFile != null) {
      uploadRequest.files.add(imageFile);
      final response = await uploadRequest.send();
      final responseData = await response.stream.toBytes();
      final result = json.decode(String.fromCharCodes(responseData));
      if (response.statusCode == 200) {
        return result['secure_url'];
      } else {
        throw Exception('Error uploading image: ${result['error']}'.tr());
      }
    } else {
      throw Exception('No valid image data provided'.tr());
    }
  }

  Future<void> deleteMessage(String senderId, String receiverId, String messageId) async {
    final chatId = _getChatId(senderId, receiverId);
    final messagesRef = _firestore.collection('chats').doc(chatId).collection('messages');

    try {
      await messagesRef.doc(messageId).delete();
      final remainingMessages = await messagesRef.limit(1).get();

      if (remainingMessages.docs.isEmpty) {
        await _firestore.collection('conversations').doc(chatId).delete();
        print('Conversation deleted because it became empty');
      } else {
        final lastMessageSnapshot = await messagesRef.orderBy('timestamp', descending: true).limit(1).get();
        final lastMessage = lastMessageSnapshot.docs.first.data();
        final isImage = (lastMessage['text'] ?? '').toString().trim().isEmpty;

        await _firestore.collection('conversations').doc(chatId).update({
          'lastMessage': isImage ? lastMessage['attachmentUrl'] : lastMessage['text'],
          'lastMessageTime': lastMessage['timestamp'],
        });
      }
    } catch (e) {
      print('Error deleting message: $e');
      rethrow;
    }
  }

  String _getChatId(String uid1, String uid2) {
    return uid1.hashCode <= uid2.hashCode ? '${uid1}_$uid2' : '${uid2}_$uid1';
  }
}
