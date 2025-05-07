import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/core/widgets/app_text_button.dart';

class AddUpdateDoctorSubmitButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const AddUpdateDoctorSubmitButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextButton(
      buttonText: buttonText,
      textStyle: getBoldTextStyle(
        fontSize: FontSizeManager.s18,
        color: Colors.white,
      ),
      onPressed: onPressed,
    );
  }
}

