import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
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
        style: getMediumTextStyle(
          fontSize: FontSizeManager.s20,
          color: ColorsManager.darkBlue,
        ),
      ),
      actions: [
        userType == 'doctor'
            ? SizedBox.shrink()
            : Padding(
          padding: EdgeInsets.symmetric(horizontal: WidthManager.w12),
          child: InkWell(
            onTap: onDeletePressed,
            borderRadius: BorderRadius.circular(RadiusManager.r30),
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: HeightManager.h8,
                horizontal: WidthManager.w8,
              ),
              decoration: BoxDecoration(
                color: ColorsManager.red.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.delete,
                color: ColorsManager.red,
                size: 24,
              ),
            ),
          ),
        ),
      ],
      backgroundColor: ColorsManager.appBarColor,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
