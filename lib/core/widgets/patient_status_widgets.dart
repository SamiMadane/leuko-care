import 'package:flutter/material.dart';
import 'package:leuko_care/core/resourses/colors_manager.dart';
import 'package:leuko_care/core/resourses/fonts_manager.dart';
import 'package:leuko_care/core/resourses/sizes_util_manager.dart';
import 'package:leuko_care/core/resourses/styles_manager.dart';

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
          isExamined ? 'Patient has been examined' : 'Not examined yet',
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

    if (status.toLowerCase() == 'unknown') {
      displayText = 'Health status not determined yet';
      color = ColorsManager.black87;
    } else if (status.toLowerCase() == 'healthy') {
      displayText = 'Healthy';
      color = ColorsManager.green;
    } else {
      displayText = status; 
      color = ColorsManager.darkRed;
    }

    return Text(
      displayText,
      style: getMediumTextStyle(
        fontSize: FontSizeManager.s14,
        color: color,
      ),
    );
  }
}