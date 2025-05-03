import 'package:flutter/material.dart';
import 'package:leuko_care/core/helpers/extensions.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/routes/routes.dart';
import 'package:leuko_care/feature/chats/logic/cubit/chat_cubit.dart';
import '../../data/models/chat_model.dart';

class MessageBubble extends StatelessWidget {
  final ChatModel message;
  final bool isMe;

  const MessageBubble({super.key, required this.message, required this.isMe});

  void _showFullImage(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder:
          (_) => Dialog(
            backgroundColor: Colors.transparent,
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                InteractiveViewer(child: Image.network(imageUrl)),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text(
              'Delete Message',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: const Text(
              'Are you sure you want to delete this message for everyone?',
            ),
            actions: [
              TextButton.icon(
                icon: const Icon(Icons.delete_forever, color: Colors.red),
                label: const Text("Delete"),
                onPressed: () {
                  context.read<ChatCubit>().deleteMessage(
                    senderId: message.senderId,
                    receiverId: message.receiverId,
                    messageId: message.id,
                  );
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: const Text("Cancel"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final alignment = isMe ? Alignment.centerRight : Alignment.centerLeft;
    final color = isMe ? Colors.blueAccent : Colors.grey[300];
    final textColor = isMe ? Colors.white : Colors.black87;

    return Align(
      alignment: alignment,
      child: GestureDetector(
        onLongPress: () {
          if (isMe) _showDeleteDialog(context);
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              if (message.text.isNotEmpty && message.attachmentUrl.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(10),
                  constraints: const BoxConstraints(maxWidth: 300),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 6,
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.pushNamed(
                            Routes.imagePreviewScreen,
                            arguments: message.attachmentUrl,
                          );
                        },
                        onLongPress: () {
                          if (isMe) _showDeleteDialog(context);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Image.network(
                            message.attachmentUrl,
                            width: double.infinity,
                            height: HeightManager.h200,
                            fit: BoxFit.cover,
                            errorBuilder:
                                (context, error, stackTrace) =>
                                    const Icon(Icons.broken_image, size: 100),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        message.text,
                        style: getMediumTextStyle(
                          fontSize: FontSizeManager.s16,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                )
              else if (message.text.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  constraints: const BoxConstraints(maxWidth: 300),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 6,
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    message.text,
                    style: getMediumTextStyle(
                      fontSize: FontSizeManager.s16,
                      color: textColor,
                    ),
                  ),
                )
              else if (message.attachmentUrl.isNotEmpty)
                GestureDetector(
                  onTap: () {
                    context.pushNamed(
                      Routes.imagePreviewScreen,
                      arguments: message.attachmentUrl,
                    );
                  },
                  onLongPress: () {
                    if (isMe) _showDeleteDialog(context);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 6,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Image.network(
                        message.attachmentUrl,
                        width: HeightManager.h200,
                        height: HeightManager.h270,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (context, error, stackTrace) =>
                                const Icon(Icons.broken_image, size: 100),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
