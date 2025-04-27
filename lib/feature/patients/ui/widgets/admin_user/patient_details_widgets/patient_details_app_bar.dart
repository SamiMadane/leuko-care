import 'package:flutter/material.dart';

class PatientDetailsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String patientName;
  final VoidCallback onDeletePressed;

  const PatientDetailsAppBar({
    super.key,
    required this.patientName,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        patientName,
        overflow: TextOverflow.ellipsis,
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.delete),
          onPressed: onDeletePressed,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
