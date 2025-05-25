import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';

class StatisticCard extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color iconColor;
  final Color textColor;
  final Color backgroundColor;

  const StatisticCard({
    super.key,
    required this.text,
    this.icon = Icons.info_outline,
    this.iconColor = ColorsManager.primaryColor,
    this.textColor = ColorsManager.primaryColor,
    this.backgroundColor = ColorsManager.lightBlue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: WidthManager.w10,
      margin: EdgeInsets.all(HeightManager.h8),
      padding: EdgeInsets.symmetric(
        vertical: HeightManager.h16,
        horizontal: WidthManager.w12,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
       
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 5,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 35,
            color: iconColor,
          ),
          SizedBox(height: HeightManager.h12),
          Text(
            text,
            textAlign: TextAlign.center,
            style: getBoldTextStyle(
              fontSize: FontSizeManager.s16,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
