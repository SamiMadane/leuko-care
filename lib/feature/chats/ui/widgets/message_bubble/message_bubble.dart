import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';

import 'package:leuko_care/core/widgets/confirmation_dialog.dart';
import 'package:leuko_care/feature/chats/logic/cubit/chat_cubit.dart';
import 'package:leuko_care/feature/chats/ui/widgets/message_bubble/image_bubble.dart';
import 'package:leuko_care/feature/chats/ui/widgets/message_bubble/text_and_image_bubble.dart';
import 'package:leuko_care/feature/chats/ui/widgets/message_bubble/text_bubble.dart';
import '../../../data/models/chat_model.dart';

class MessageBubble extends StatelessWidget {
  final ChatModel message;
  final bool isMe;

  const MessageBubble({super.key, required this.message, required this.isMe});

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (_) => ConfirmationDialog(
            title: 'Delete Message',
            message:
                'Are you sure you want to delete this message for everyone?',
            confirmText: 'Delete',
            icon: Icons.delete,
            onConfirmed: () {
              context.read<ChatCubit>().deleteMessage(
                senderId: message.senderId,
                receiverId: message.receiverId,
                messageId: message.id,
              );
              Navigator.pop(context);
            },
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final alignment = isMe ? Alignment.centerRight : Alignment.centerLeft;

    return Align(
      alignment: alignment,
      child: GestureDetector(
        onLongPress: () {
          if (isMe) _showDeleteDialog(context);
        },
        child: Container(
          margin: EdgeInsets.symmetric(
            vertical: HeightManager.h6,
            horizontal: WidthManager.w8,
          ),
          child: Builder(
            builder: (_) {
              if (message.text.isNotEmpty && message.attachmentUrl.isNotEmpty) {
                return TextAndImageBubble(
                  message: message,
                  isMe: isMe,
                  onDelete: () => _showDeleteDialog(context),
                );
              } else if (message.text.isNotEmpty) {
                return TextBubble(message: message, isMe: isMe);
              } else if (message.attachmentUrl.isNotEmpty) {
                return ImageBubble(
                  message: message,
                  isMe: isMe,
                  onDelete: () => _showDeleteDialog(context),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }
}
