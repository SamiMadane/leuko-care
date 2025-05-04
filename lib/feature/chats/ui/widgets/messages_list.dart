import 'package:flutter/material.dart';
import '../../data/models/chat_model.dart';
import 'message_bubble/message_bubble.dart';

class MessagesList extends StatelessWidget {
  final List<ChatModel> messages;
  final String currentUserId;

  const MessagesList({
    super.key,
    required this.messages,
    required this.currentUserId,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      padding: const EdgeInsets.all(12),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[messages.length - 1 - index]; // reverse
        final isMe = message.senderId == currentUserId;

        return MessageBubble(message: message, isMe: isMe);
      },
    );
  }
}
