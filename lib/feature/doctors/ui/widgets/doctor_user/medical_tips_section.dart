import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/feature/doctors/ui/widgets/doctor_user/tip_card_widget.dart.dart';

class MedicalTipsSection extends StatelessWidget {
  const MedicalTipsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final tips = [
      {
        'icon': Icons.water_drop,
        'text': 'Drink enough water before taking a blood sample.'.tr(),
        'color': Colors.lightBlue,
      },
      {
        'icon': Icons.bedtime,
        'text': 'Get proper sleep to improve immune function.'.tr(),
        'color': Colors.deepPurpleAccent,
      },
      {
        'icon': Icons.no_food,
        'text': 'Avoid eating heavy meals before blood tests.'.tr(),
        'color': Colors.orange,
      },
      {
        'icon': Icons.fitness_center,
        'text': 'Encourage light exercise to boost circulation.'.tr(),
        'color': Colors.teal,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Medical Tips:'.tr(),
          style: getBoldTextStyle(
            fontSize: FontSizeManager.s18,
            color: ColorsManager.darkBlue,
          ),
        ),
        SizedBox(height: HeightManager.h14),
        Column(
          children: tips.map((tip) {
            return Padding(
              padding:  EdgeInsets.only(bottom: HeightManager.h12),
              child: TipCardWidget(
                icon: tip['icon'] as IconData,
                text: tip['text'] as String,
                backgroundColor: (tip['color'] as Color).withValues(alpha: .15),
                iconColor: tip['color'] as Color,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
