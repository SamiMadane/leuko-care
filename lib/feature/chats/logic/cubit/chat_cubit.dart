import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/feature/chats/data/repository/chat_repo.dart';
import '../../data/models/chat_model.dart';
import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepository _chatRepository;

  ChatCubit(this._chatRepository) : super(const ChatState.chatInitial());

  void getMessages({required String senderId, required String receiverId}) {
    emit(ChatLoading());

    try {
      _chatRepository
          .getMessages(senderId: senderId, receiverId: receiverId)
          .listen((messages) {
            emit(ChatSuccess(messages));
          });
    } catch (e) {
      emit(ChatError('Failed to load messages'));
    }
  }

  Future<void> sendMessageWithOptionalImageAndText({
    required String senderId,
    required String receiverId,
    String? text,
    String? imagePath,
  }) async {
    try {
      emit(ChatLoading());

      String imageUrl = '';
      if (imagePath != null && imagePath.isNotEmpty) {
        imageUrl = await _chatRepository.uploadImageToCloudinary(imagePath);
      }

      final message = ChatModel(
        id: '',
        senderId: senderId,
        receiverId: receiverId,
        text: text?.trim() ?? '',
        timestamp: Timestamp.now(),
        attachmentUrl: imageUrl,
      );

      await _chatRepository.sendMessage(message);
      getMessages(senderId: senderId, receiverId: receiverId);
      emit(ChatMessageSentSuccessfully());
    } catch (e) {
      emit(ChatError('Failed to send message'));
    }
  }

  // دالة لحذف الرسالة
  Future<void> deleteMessage({
    required String senderId,
    required String receiverId,
    required String messageId,
  }) async {
    emit(ChatLoading());

    try {
      await _chatRepository.deleteMessage(
        senderId,
        receiverId,
        messageId,
      ); // حذف الرسالة من الريبو
      getMessages(senderId: senderId, receiverId: receiverId);

      emit(ChatMessageDeleteSuccessfully()); // حالة تفيد بحذف الرسالة
    } catch (e) {
      emit(ChatError(e.toString())); // في حالة حدوث خطأ
    }
  }
}
