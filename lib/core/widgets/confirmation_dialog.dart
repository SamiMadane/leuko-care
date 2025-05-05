import 'package:flutter/material.dart';
import 'package:leuko_care/core/helpers/extensions.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onConfirmed;
  final IconData? icon;

  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.message,
    required this.onConfirmed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, color: Colors.red),
            SizedBox(width: WidthManager.w8),
          ],
          Expanded(
            child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      content: Text(message),
      actions: [
        TextButton.icon(
          icon: const Icon(Icons.delete_forever, color: Colors.red),
          label: const Text("Delete"),
          onPressed: onConfirmed,
        ),
        TextButton(
          child: const Text("Cancel"),
          onPressed: () => context.pop(),
        ),
      ],
    );
  }
}
