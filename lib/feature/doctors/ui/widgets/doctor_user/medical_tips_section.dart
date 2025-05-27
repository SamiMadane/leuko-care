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
        'icon'.tr(): Icons.water_drop,
        'text'.tr(): 'Drink enough water before taking a blood sample.'.tr(),
        'color'.tr(): Colors.lightBlue,
      },
      {
        'icon'.tr(): Icons.bedtime,
        'text'.tr(): 'Get proper sleep to improve immune function.'.tr(),
        'color'.tr(): Colors.deepPurpleAccent,
      },
      {
        'icon'.tr(): Icons.no_food,
        'text'.tr(): 'Avoid eating heavy meals before blood tests.'.tr(),
        'color'.tr(): Colors.orange,
      },
      {
        'icon'.tr(): Icons.fitness_center,
        'text'.tr(): 'Encourage light exercise to boost circulation.'.tr(),
        'color'.tr(): Colors.teal,
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
                icon: tip['icon'.tr()] as IconData,
                text: tip['text'.tr()] as String,
                backgroundColor: (tip['color'.tr()] as Color).withValues(alpha: .1),
                iconColor: tip['color'.tr()] as Color,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
