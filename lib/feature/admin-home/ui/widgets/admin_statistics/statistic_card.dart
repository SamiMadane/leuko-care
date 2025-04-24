import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
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
    return Card(
      color: backgroundColor,
      elevation: 8,
      margin: EdgeInsets.symmetric(vertical: HeightManager.h8),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: WidthManager.w16),
        leading: Icon(icon, color: iconColor),
        title: Text(
          text,
          style: getBoldTextStyle(
            fontSize: IconSizeManager.s18,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
