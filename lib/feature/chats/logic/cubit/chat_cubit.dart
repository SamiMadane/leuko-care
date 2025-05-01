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
      _chatRepository.getMessages(senderId: senderId, receiverId: receiverId).listen((messages) {
        emit(ChatSuccess(messages));
      });
    } catch (e) {
      emit(ChatError('Failed to load messages'));
    }
  }

  Future<void> sendMessage(ChatModel message) async {
    try {
      await _chatRepository.sendMessage(message);
      emit(ChatMessageSentSuccessfully());
    } catch (e) {
      emit(ChatError('Failed to send message'));
    }
  }
}
