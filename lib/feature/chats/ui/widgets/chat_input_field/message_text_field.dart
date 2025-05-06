import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/feature/patients/logic/cubit/patient_cubit.dart';

class MessageTextField extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onEmojiToggle;
  final String? initialMessage;

  const MessageTextField({
    super.key,
    required this.controller,
    required this.onEmojiToggle,
    this.initialMessage,
  });

  @override
  State<MessageTextField> createState() => _MessageTextFieldState();
}

class _MessageTextFieldState extends State<MessageTextField> {
  @override
  Widget build(BuildContext context) {
    final shouldInject =
        widget.initialMessage != null &&
        widget.controller.text.isEmpty &&
        context.read<PatientCubit>().shouldInjectInitialMessage;

    if (shouldInject) {
      widget.controller.text = widget.initialMessage!;
      widget.controller.selection = TextSelection.fromPosition(
        TextPosition(offset: widget.controller.text.length),
      );

      context.read<PatientCubit>().shouldInjectInitialMessage = false;
    }

    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: HeightManager.h46,
        maxHeight: HeightManager.h160,
      ),
      child: Scrollbar(
        child: TextFormField(
          controller: widget.controller,
          maxLines: null,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
            hintText: "Type a message...",
            hintStyle: TextStyle(color: ColorsManager.gray),
            filled: true,
            fillColor: ColorsManager.moreLighterGray,
            contentPadding: EdgeInsets.symmetric(
              vertical: HeightManager.h10,
              horizontal: WidthManager.w14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(RadiusManager.r30),
              borderSide: BorderSide.none,
            ),
            suffixIcon: IconButton(
              icon: const Icon(
                Icons.emoji_emotions,
                color: ColorsManager.primaryColor,
              ),
              onPressed: widget.onEmojiToggle,
            ),
          ),
        ),
      ),
    );
  }
}
