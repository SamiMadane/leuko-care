import 'package:easy_localization/easy_localization.dart';

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:leuko_care/core/helpers/shared_pref_helper.dart';
import 'package:leuko_care/core/networking/send_notification_services.dart';
import '../models/chat_model.dart';

class ChatRepository {
  final FirebaseFirestore _firestore;

  ChatRepository(this._firestore);

  // جلب الرسائل
  Stream<List<ChatModel>> getMessages({
    required String senderId,
    required String receiverId,
    String? chatIdFromNotification,
  }) {
    final chatId = chatIdFromNotification ?? _getChatId(senderId, receiverId);

    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp')
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs
                  .map((doc) => ChatModel.fromJson(doc.data()))
                  .toList(),
        );
  }

  Future<void> _updateOrCreateConversation(ChatModel message) async {
    final conversationId = _getChatId(message.senderId, message.receiverId);
    final conversationRef = _firestore
        .collection('conversations')
        .doc(conversationId);

    final isImageMessage = message.text.trim().isEmpty;

    final lastMessageContent =
        isImageMessage ? message.attachmentUrl : message.text;
    final conversationSnapshot = await conversationRef.get();

    if (conversationSnapshot.exists) {
      await conversationRef.update({
        'lastMessage': lastMessageContent,
        'lastMessageTime': message.timestamp,
        'lastMessageSenderId': message.senderId,
        'hasUnreadMessagesByParticipant.${message.senderId}': false,
        'hasUnreadMessagesByParticipant.${message.receiverId}': true,
      });
    } else {
      await conversationRef.set({
        'id': conversationId,
        'participantAId': message.senderId,
        'participantBId': message.receiverId,
        'lastMessage': lastMessageContent,
        'lastMessageTime': message.timestamp,
        'lastMessageSenderId': message.senderId,
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

      final doc =
          await FirebaseFirestore.instance
              .collection(collection)
              .doc(senderId)
              .get();

      if (doc.exists) {
        final data = doc.data();
        final name = data?['name'];
        return name;
      } else {
        return '';
      }
    } catch (e) {
      print('Error getting sender name: $e');
      return '';
    }
  }

  Future<void> sendMessage(ChatModel message) async {
    final chatId = _getChatId(message.senderId, message.receiverId);
    final userType = await SharedPrefHelper.getString('userType');
    final senderName = await getSenderName(message.senderId, userType);
    final isImageMessage = message.text.isEmpty;
    final title = "new_message_from".tr(
      args: [userType == 'doctor' ? "Dr. $senderName :" : '${senderName} :'],
    );
    final body = isImageMessage ? "image_message".tr() : message.text;

    try {
      final docRef = await _firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .add(message.toJson());

      // بعد إضافة الرسالة، يتم تحديث الـ id في الرسالة
      final updatedMessage = message.copyWith(id: docRef.id);

      // تحديث الرسالة بـ id الجديد
      await docRef.update(updatedMessage.toJson());

      await _updateOrCreateConversation(updatedMessage);
      final tokenDoc =
          await _firestore
              .collection('fcmTokens')
              .doc(message.receiverId)
              .get();

      if (tokenDoc.exists) {
        final tokens = List<String>.from(tokenDoc.data()?['tokens'] ?? []);

        for (final token in tokens) {
          if (token.isNotEmpty) {
            print('token i need to send him is $token');
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
      } else {
        print("No FCM tokens found for user ${message.receiverId}");
      }

      print("Message sent with id: ${docRef.id}");
    } catch (e) {
      print('Error sending message: $e');
      throw Exception('Failed to send message'.tr());
    }
  }

  Future<void> markMessagesAsReadByDoctor(
    String doctorId,
    String patientId,
  ) async {
    final chatId = _getChatId(doctorId, patientId);

    try {
      final conversationRef = _firestore
          .collection('conversations')
          .doc(chatId);

      // تحقق من وجود المحادثة أولاً
      final conversationSnapshot = await conversationRef.get();
      if (!conversationSnapshot.exists) return;

      await conversationRef.update({
        'hasUnreadMessagesByParticipant.$doctorId': false,
      });

      print(
        'Marked messages as read for doctor $doctorId in conversation $chatId',
      );
    } catch (e) {
      print('Error marking messages as read: $e');
      throw Exception('Failed to mark messages as read'.tr());
    }
  }

  Future<void> markMessagesAsReadByPatient(
    String patientId,
    String doctorId,
  ) async {
    final chatId = _getChatId(doctorId, patientId);

    try {
      final conversationRef = _firestore
          .collection('conversations')
          .doc(chatId);

      final conversationSnapshot = await conversationRef.get();
      if (!conversationSnapshot.exists) return;

      await conversationRef.update({
        'hasUnreadMessagesByParticipant.$patientId': false,
      });

      print(
        'Marked messages as read for patient $patientId in conversation $chatId',
      );
    } catch (e) {
      print('Error marking messages as read: $e');
      throw Exception('Failed to mark messages as read'.tr());
    }
  }

  // توليد ID للمحادثة بين المرسل والمستقبل
  String _getChatId(String uid1, String uid2) {
    return uid1.hashCode <= uid2.hashCode ? '${uid1}_$uid2' : '${uid2}_$uid1';
  }

  Future<String> uploadImageToCloudinary({
    String? imagePath,
    Uint8List? imageBytes,
  }) async {
    final url = Uri.parse(
      'https://api.cloudinary.com/v1_1/dmhmhyigi/image/upload',
    );

    final uploadRequest = http.MultipartRequest('POST', url);

    // إعدادات Cloudinary
    uploadRequest.fields['upload_preset'] = 'leuko_care';

    http.MultipartFile? imageFile;

    // إذا كانت الصورة من مسار الملف
    if (imagePath != null && imagePath.isNotEmpty) {
      final bytes = await File(imagePath).readAsBytes();
      imageFile = http.MultipartFile.fromBytes(
        'file',
        bytes,
        filename: 'chat_image.jpg', // يمكنك تخصيص الاسم حسب الحاجة
      );
    }
    // إذا كانت الصورة من نوع Uint8List
    else if (imageBytes != null) {
      imageFile = http.MultipartFile.fromBytes(
        'file',
        imageBytes,
        filename: 'chat_image.jpg', // يمكنك تخصيص الاسم حسب الحاجة
      );
    }

    if (imageFile != null) {
      uploadRequest.files.add(imageFile);

      // إرسال الطلب إلى Cloudinary
      final response = await uploadRequest.send();
      final responseData = await response.stream.toBytes();
      final result = json.decode(String.fromCharCodes(responseData));

      if (response.statusCode == 200) {
        return result['secure_url']; // رابط الصورة المرفوعة
      } else {
        throw Exception('Error uploading image: ${result['error']}'.tr());
      }
    } else {
      throw Exception('No valid image data provided'.tr());
    }
  }

  Future<void> deleteMessage(
    String senderId,
    String receiverId,
    String messageId,
  ) async {
    final chatId = _getChatId(senderId, receiverId);
    final messagesRef = _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages');

    try {
      // حذف الرسالة
      await messagesRef.doc(messageId).delete();

      // التحقق إن كان لا توجد أي رسائل بعد الحذف
      final remainingMessages = await messagesRef.limit(1).get();

      if (remainingMessages.docs.isEmpty) {
        // حذف المحادثة من conversations
        await _firestore.collection('conversations').doc(chatId).delete();
        print('Conversation deleted because it became empty');
      } else {
        // تحديث آخر رسالة في المحادثة
        final lastMessageSnapshot =
            await messagesRef
                .orderBy('timestamp', descending: true)
                .limit(1)
                .get();

        final lastMessage = lastMessageSnapshot.docs.first.data();
        final isImage = (lastMessage['text'] ?? '').toString().trim().isEmpty;

        await _firestore.collection('conversations').doc(chatId).update({
          'lastMessage':
              isImage ? lastMessage['attachmentUrl'] : lastMessage['text'],
          'lastMessageTime': lastMessage['timestamp'],
        });
      }
    } catch (e) {
      print('Error deleting message: $e');
      rethrow;
    }
  }
  
}
