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

  // إرسال رسالة
  Future<void> sendMessage(ChatModel message) async {
    final chatId = _getChatId(message.senderId, message.receiverId);

    try {
      // إضافة الرسالة إلى Firestore
      final docRef = await _firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .add(message.toJson());

      // بعد إضافة الرسالة، يتم تحديث الـ id في الرسالة
      final updatedMessage = message.copyWith(id: docRef.id);

       // إذا كان المرسل هو = (الطرف الآخر)
    if (message.senderId != message.receiverId) {
      // تحديث بيانات المريض فقط إذا كان الطرف الاخر هو المرسل
      await _firestore.collection('patients').doc(message.receiverId).update({
        'hasUnreadMessages': true,
        'lastMessageTime': message.timestamp,
      });
    }

      print("Message sent with id: ${updatedMessage.id}");
    } catch (e) {
      print('Error sending message: $e');
      throw Exception('Failed to send message');
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
