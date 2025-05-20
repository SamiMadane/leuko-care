import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import '../models/chat_model.dart';

class ChatRepository {
  final FirebaseFirestore _firestore;

  ChatRepository(this._firestore);

  // جلب الرسائل
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
        .map(
          (snapshot) =>
              snapshot.docs
                  .map((doc) => ChatModel.fromJson(doc.data()))
                  .toList(),
        );
  }

  Future<void> _updateOrCreateConversation(ChatModel message) async {
    final senderRef =
        await _firestore.collection('patients').doc(message.senderId).get();

    if (!senderRef.exists) return; // المرسل ليس مريضًا، لا داعي للتحديث

    final conversationId = _getChatId(message.senderId, message.receiverId);
    final conversationRef = _firestore
        .collection('conversations')
        .doc(conversationId);

    final conversationSnapshot = await conversationRef.get();

    if (conversationSnapshot.exists) {
      await conversationRef.update({
        'lastMessage': message.text,
        'lastMessageTime': message.timestamp,
        'hasUnreadMessagesByParticipant.${message.receiverId}': true,
      });
    } else {
      await conversationRef.set({
        'id': conversationId,
        'participantAId': message.senderId,
        'participantBId': message.receiverId,
        'lastMessage': message.text,
        'lastMessageTime': message.timestamp,
        'hasUnreadMessagesByParticipant': {
          message.senderId: false,
          message.receiverId: true,
        },
      });
    }
  }

  Future<void> sendMessage(ChatModel message) async {
    final chatId = _getChatId(message.senderId, message.receiverId);

    try {
      final docRef = await _firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .add(message.toJson());

      // تحديث بيانات المريض فقط إذا كان المستقبل فعلاً مريض
      final receiverSnapshot =
          await _firestore.collection('patients').doc(message.receiverId).get();

      if (receiverSnapshot.exists) {
        await _firestore.collection('patients').doc(message.receiverId).update({
          'hasUnreadMessages': true,
          'lastMessageTime': message.timestamp,
        });
      }

      await _updateOrCreateConversation(message);

      print("Message sent with id: ${docRef.id}");
    } catch (e) {
      print('Error sending message: $e');
      throw Exception('Failed to send message');
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
      throw Exception('Failed to mark messages as read');
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
        throw Exception('Error uploading image: ${result['error']}');
      }
    } else {
      throw Exception('No valid image data provided');
    }
  }

  Future<void> deleteMessage(
    String senderId,
    String receiverId,
    String messageId,
  ) async {
    final chatId = _getChatId(senderId, receiverId);

    try {
      await _firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .doc(messageId)
          .delete(); // حذف الرسالة بالكامل
    } catch (e) {
      rethrow; // إعادة الرمي في حالة حدوث خطأ
    }
  }
}
