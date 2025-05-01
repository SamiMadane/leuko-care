import 'package:cloud_firestore/cloud_firestore.dart';
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
        .map((snapshot) =>
            snapshot.docs.map((doc) => ChatModel.fromJson(doc.data())).toList());
  }

  // إرسال رسالة
  Future<void> sendMessage(ChatModel message) async {
    final chatId = _getChatId(message.senderId, message.receiverId);

    try {
      await _firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .add(message.toJson());
    } catch (e) {
      print('Error sending message: $e');
      throw Exception('Failed to send message');
    }
  }

  // توليد ID للمحادثة بين المرسل والمستقبل
  String _getChatId(String uid1, String uid2) {
    return uid1.hashCode <= uid2.hashCode ? '${uid1}_$uid2' : '${uid2}_$uid1';
  }
}
