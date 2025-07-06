import 'dart:ui' as flutterMaterial;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/helpers/network_helper.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/widgets/custom_confirmation_dialog.dart';
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
    showAnimatedConfirmationDialog(
      context: context,
      title: 'Delete Message'.tr(),
      message:
          'Are you sure you want to delete this message for everyone?'.tr(),
      confirmText: 'Delete'.tr(),
      type: ConfirmationType.delete,
      onConfirmed: () {
        context.read<ChatCubit>().deleteMessage(
          senderId: message.senderId,
          receiverId: message.receiverId,
          messageId: message.id,
        );
        Navigator.pop(context); // لإغلاق الديالوج بعد التنفيذ
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final alignment = isMe ? Alignment.centerRight : Alignment.centerLeft;
    Locale currentLocale = context.locale;

    return Align(
      alignment: alignment,
      child: Column(
        crossAxisAlignment:
            isMe && currentLocale.toString() == 'en'
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
        children: [
          Directionality(
            textDirection: flutterMaterial.TextDirection.ltr,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (isMe && message.status == MessageStatus.failed)
                  Row(
                    children: [
                      Icon(Icons.error, color: Colors.red, size: 16),
                      SizedBox(width: WidthManager.w4),
                      GestureDetector(
                        onTap: () {
                          context
                              .read<ChatCubit>()
                              .sendMessageWithOptionalImageAndText(
                                senderId: message.senderId,
                                receiverId: message.receiverId,
                                text: message.text,
                                imagePath:
                                    message.attachmentUrl.isNotEmpty
                                        ? message.attachmentUrl
                                        : null,
                                retryingMessageId: message.id,
                              );
                        },
                        child: Icon(
                          Icons.refresh,
                          color: Colors.blue,
                          size: 18,
                        ),
                      ),
                    ],
                  ),

                if (isMe &&
                    message.status == MessageStatus.sending &&
                    (NetworkHelper.hasInternetConnection == false ||
                        (message.localImagePath != null &&
                            message.localImagePath!.isNotEmpty)))
                  Padding(
                    padding: EdgeInsets.only(
                      right: WidthManager.w2,
                      bottom: HeightManager.h8,
                    ),
                    child: SizedBox(
                      width: 12,
                      height: 12,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),

                GestureDetector(
                  onLongPress: () => _showDeleteDialog(context),
                  child: _buildMessageContent(context),
                ),
              ],
            ),
          ),

          if (message.pendingDelete)
            Padding(
              padding: EdgeInsets.only(
                left: WidthManager.w12,
                right: WidthManager.w12,
                top: HeightManager.h2,
              ),
              child: Text(
                'The message will be deleted once internet is available'.tr(),
                style: TextStyle(fontSize: 11, color: Colors.red),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMessageContent(BuildContext context) {
    return Opacity(
      opacity: message.pendingDelete ? 0.6 : 1.0,

      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: HeightManager.h6,
          horizontal: WidthManager.w8,
        ),
        child: Builder(
          builder: (_) {
            final hasText = message.text.isNotEmpty;
            final hasImage =
                message.attachmentUrl.isNotEmpty ||
                (message.localImagePath != null &&
                    message.localImagePath!.isNotEmpty);

            if (hasText && hasImage) {
              return TextAndImageBubble(
                message: message,
                isMe: isMe,
                onDelete: () => _showDeleteDialog(context),
              );
            } else if (hasText) {
              return TextBubble(message: message, isMe: isMe);
            } else if (hasImage) {
              return ImageBubble(
                message: message,
                isMe: isMe,
                onDelete: () => _showDeleteDialog(context),
                localImagePath: message.localImagePath,
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
