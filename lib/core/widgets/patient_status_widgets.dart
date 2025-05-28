import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';

class ExaminedStatusWidget extends StatelessWidget {
  final bool isExamined;

  const ExaminedStatusWidget({super.key, required this.isExamined});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          isExamined ? Icons.check_circle : Icons.cancel,
          color: isExamined ? Colors.green : Colors.red,
          size: IconSizeManager.s22,
        ),
        SizedBox(width: WidthManager.w6),
        Text(
          isExamined ? 'Examined'.tr() : 'Not Examined'.tr(),
          style: getSemiBoldTextStyle(
            fontSize: FontSizeManager.s15,
            color: isExamined
                ? ColorsManager.darkGreen
                : ColorsManager.darkRed,
          ),
        ),
      ],
    );
  }
}

class HealthStatusWidget extends StatelessWidget {
  final String status;

  const HealthStatusWidget({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    String displayText;
    Color color;
    IconData icon;

    // تحديد الحالة وتعيين النص واللون
    if (status.toLowerCase() == 'unknown') {
      displayText = 'Status not determined yet';
      color = ColorsManager.darkOrange;
      icon = Icons.help_outline;
    } else if (status.toLowerCase() == 'healthy') {
      displayText = 'Healthy'.tr();
      color = ColorsManager.darkGreen;
      icon = Icons.check_circle_outline; 
    } else {
      displayText = status;
      color = ColorsManager.darkRed;
      icon = Icons.cancel_outlined; 
    }

    return Row(
      children: [
        Icon(
          icon,
          color: color,
          size: IconSizeManager.s20,
        ),
        SizedBox(width: WidthManager.w8),
        Text(
          displayText,
          style: getMediumTextStyle(
            fontSize: FontSizeManager.s16,
            color: color,
          ),
        ),
      ],
    );
  }
}