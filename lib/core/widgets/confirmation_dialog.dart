import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:leuko_care/core/helpers/extensions.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onConfirmed;
  final String confirmText;
  final IconData? icon;

  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.message,
    required this.onConfirmed,
    required this.confirmText, // النص الآن مطلوب
    this.icon, // الأيقونة اختيارية
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      content: Text(message),
      actions: [
        TextButton.icon(
          icon:
              icon != null
                  ? Icon(icon, color: Colors.red)
                  : Container(), // الأيقونة اختيارية
          label: Text(confirmText, style: const TextStyle(color: Colors.red)),
          onPressed: onConfirmed,
        ),
        TextButton(child: Text("Cancel".tr()), onPressed: () => context.pop()),
      ],
    );
  }
}
