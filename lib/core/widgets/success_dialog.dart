import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';

class SuccessDialog extends StatelessWidget {
  final String message;
  final VoidCallback onSuccess;

  const SuccessDialog({
    super.key,
    required this.message,
    required this.onSuccess,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: Icon(Icons.check, color: Colors.green, size: IconSizeManager.s32),
      content: Text(
        message,
        style: getMediumTextStyle(fontSize: FontSizeManager.s15, color: ColorsManager.darkBlue),
      ),
      actions: [
        TextButton(
          onPressed: onSuccess,
          child: Text(
            'Got it'.tr(),
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
