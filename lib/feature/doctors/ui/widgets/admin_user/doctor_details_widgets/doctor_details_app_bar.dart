import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';

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
      title: Text(
        'Dr. ${doctorName}',
        style: getMediumTextStyle(
          fontSize: FontSizeManager.s20,
          color: ColorsManager.darkBlue,
        ),
        overflow: TextOverflow.ellipsis,
      ),
      backgroundColor: ColorsManager.appBarColor,
      actions: [
        IconButton(icon: const Icon(Icons.delete), onPressed: onDeletePressed),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
