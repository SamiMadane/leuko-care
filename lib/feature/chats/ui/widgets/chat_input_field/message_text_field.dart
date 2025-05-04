import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';

class MessageTextField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onEmojiToggle;

  const MessageTextField({
    super.key,
    required this.controller,
    required this.onEmojiToggle,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: HeightManager.h46, maxHeight: HeightManager.h160),
      child: Scrollbar(
        child: TextFormField(
          controller: controller,
          maxLines: null,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
            hintText: "Type a message...",
            hintStyle: TextStyle(color: ColorsManager.gray),
            filled: true,
            fillColor: ColorsManager.moreLighterGray,
            contentPadding: EdgeInsets.symmetric(vertical: HeightManager.h10, horizontal: WidthManager.w14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(RadiusManager.r30),
              borderSide: BorderSide.none,
            ),
            suffixIcon: IconButton(
              icon: const Icon(Icons.emoji_emotions, color: ColorsManager.primaryColor),
              onPressed: onEmojiToggle,
            ),
          ),
        ),
      ),
    );
  }
}
