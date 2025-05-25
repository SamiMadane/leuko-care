import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
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
        Padding(
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
                color: ColorsManager.red.withValues(alpha: .1),
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
