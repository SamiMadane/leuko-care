import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';

class HealthCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const HealthCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.symmetric(
        vertical: HeightManager.h16,
        horizontal: WidthManager.w16,
      ),
      decoration: BoxDecoration(
        color: ColorsManager.moreLighterGray,
        borderRadius: BorderRadius.circular(RadiusManager.r16),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, size: IconSizeManager.s32, color: ColorsManager.primaryColor),
          SizedBox(width: WidthManager.w16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: FontSizeManager.s14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: HeightManager.h4),
              Text(value, style: TextStyle(fontSize: FontSizeManager.s16)),
            ],
          ),
        ],
      ),
    );
  }
}
