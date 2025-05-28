import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';

class TipCardWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color backgroundColor;
  final Color iconColor;

  const TipCardWidget({
    super.key,
    required this.icon,
    required this.text,
    required this.backgroundColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: WidthManager.w16,
        vertical: HeightManager.h16,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(RadiusManager.r12),
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 28),
          SizedBox(width: WidthManager.w16),
          Expanded(
            child: Text(
              text,
              style: getSemiBoldTextStyle(
                fontSize: FontSizeManager.s14,
                color: iconColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
