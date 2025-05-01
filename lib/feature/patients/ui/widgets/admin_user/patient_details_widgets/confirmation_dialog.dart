import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onConfirmed;
  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.message,
    required this.onConfirmed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(onPressed: onConfirmed, child: const Text('Yes')),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('No'),
        ),
      ],
    );
  }
}
