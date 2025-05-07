import 'package:flutter/material.dart';

class DoctorDetailsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String doctorName;
  final VoidCallback onDeletePressed;
  const DoctorDetailsAppBar({
    super.key,
    required this.doctorName,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Dr. ${doctorName}', overflow: TextOverflow.ellipsis),

      actions: [
        IconButton(icon: const Icon(Icons.delete), onPressed: onDeletePressed),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
