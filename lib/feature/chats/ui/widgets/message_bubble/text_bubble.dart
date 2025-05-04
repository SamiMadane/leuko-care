import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import '../../../data/models/chat_model.dart';

class TextBubble extends StatelessWidget {
  final ChatModel message;
  final bool isMe;

  const TextBubble({super.key, required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    final color = isMe ? ColorsManager.primaryColor : Colors.grey[300];
    final textColor = isMe ? ColorsManager.white : ColorsManager.darkBlue;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: WidthManager.w14,
        vertical: HeightManager.h10,
      ),
      constraints: BoxConstraints(maxWidth: WidthManager.w260),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(RadiusManager.r16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 6,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Text(
        message.text,
        style: getMediumTextStyle(
          fontSize: FontSizeManager.s15,
          color: textColor,
        ),
      ),
    );
  }
}
