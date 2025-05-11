import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';

class PatientDetailsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String patientName;
  final VoidCallback onDeletePressed;
  final String? userType;

  const PatientDetailsAppBar({
    super.key,
    required this.patientName,
    required this.onDeletePressed,
    this.userType,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        patientName,
        overflow: TextOverflow.ellipsis,
        style:
            userType == 'doctor'
                ? getSemiBoldTextStyle(
                  fontSize: FontSizeManager.s20,
                  color: ColorsManager.darkBlue,
                )
                : null,
      ),
      actions: [
        userType == 'doctor'
            ? SizedBox.shrink()
            : IconButton(
              icon: const Icon(Icons.delete),
              onPressed: onDeletePressed,
            ),
      ],
      backgroundColor: userType == 'doctor' ? ColorsManager.white : null,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
