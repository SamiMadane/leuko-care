import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/chat_model.dart';

part 'chat_state.freezed.dart';

@freezed
class ChatState with _$ChatState {
  const factory ChatState.chatInitial() = _ChatInitial;
  const factory ChatState.chatLoading() = ChatLoading;
  const factory ChatState.chatSuccess(List<ChatModel> messages) = ChatSuccess;
  const factory ChatState.chatError(String message) = ChatError;
  const factory ChatState.chatMessageSentSuccessfully() = ChatMessageSentSuccessfully;
  const factory ChatState.chatMessageDeleteSuccessfully() = ChatMessageDeleteSuccessfully;
  const factory ChatState.messagesMarkedAsReadSuccessfully() = MessagesMarkedAsReadSuccessfully;
  const factory ChatState.chatConversationUpdated(Map<String, dynamic> data) = ChatConversationUpdated;
}
