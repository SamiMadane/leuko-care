import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';

class ExaminedStatusProgressWidget extends StatelessWidget {
  final Map<String, int> data;

  const ExaminedStatusProgressWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final examined = data['Examined'] ?? 0;
    final unexamined = data['Unexamined'] ?? 0;
    final total = examined + unexamined;
    final double percent = total == 0 ? 0.0 : examined / total;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Examined Patients (${(percent * 100).toStringAsFixed(0)}%)',
          style: getBoldTextStyle(fontSize: FontSizeManager.s14, color: ColorsManager.darkGreen),
        ),
        SizedBox(height: HeightManager.h8),
        ClipRRect(
          borderRadius: BorderRadius.circular(RadiusManager.r8),
          child: LinearProgressIndicator(
            value: percent,
            minHeight: HeightManager.h16,
            backgroundColor: Colors.orange.shade100,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
          ),
        ),
        SizedBox(height: HeightManager.h6),
        Text(
          '$examined examined • $unexamined unexamined',
          style: getRegularTextStyle(fontSize: FontSizeManager.s13, color: ColorsManager.darkBlue),
        ),
      ],
    );
  }
}
