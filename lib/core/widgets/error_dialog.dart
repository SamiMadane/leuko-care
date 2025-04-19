import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';

class ErrorDialog extends StatelessWidget {
  final String message;

  const ErrorDialog({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: Icon(Icons.error, color: Colors.red, size: IconSizeManager.s32),
      content: Text(
        message,
        style: getMediumTextStyle(fontSize: FontSizeManager.s15, color: ColorsManager.darkBlue),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Got it',
            style: getSemiBoldTextStyle(
              fontSize: FontSizeManager.s14,
              color: ColorsManager.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
