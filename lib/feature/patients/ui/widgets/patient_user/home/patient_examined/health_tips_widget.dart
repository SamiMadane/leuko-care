import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';

class HealthTipsWidget extends StatelessWidget {
  final PatientModel patient;

  const HealthTipsWidget({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    final bool isSick = patient.isExamined && patient.healthStatus.toLowerCase() == "sick";
    final tips = isSick ? _getLeukemiaTips() : _getGeneralTips();

    final bgColor = isSick ? Colors.purple.shade50 : Colors.green.shade50;
    final borderColor = isSick ? Colors.deepPurple : Colors.green;
    final titleColor = isSick ? Colors.deepPurple : Colors.green;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Helpful Health Tips:",
          style: getSemiBoldTextStyle(
            fontSize: FontSizeManager.s18,
            color: ColorsManager.darkBlue,
          ),
        ),
        SizedBox(height: HeightManager.h14),
        Container(
          padding: EdgeInsets.symmetric(
            vertical: HeightManager.h16,
            horizontal: WidthManager.w16,
          ),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(RadiusManager.r12),
            border: Border.all(color: borderColor),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 3,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isSick
                    ? 'Tips for Managing Leukemia:'
                    : 'Congratulations! Stay Healthy:',
                style: getSemiBoldTextStyle(
                  fontSize: FontSizeManager.s16,
                  color: titleColor,
                ),
              ),
              SizedBox(height: HeightManager.h6),
              ...tips.map(
                (tip) => Padding(
                  padding: EdgeInsets.symmetric(vertical: HeightManager.h6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        tip.icon,
                        size: IconSizeManager.s22,
                        color: titleColor,
                      ),
                      SizedBox(width: WidthManager.w8),
                      Expanded(
                        child: Text(
                          tip.text,
                          style: getMediumTextStyle(fontSize: FontSizeManager.s14, color: ColorsManager.darkBlue,height: HeightManager.h1_3),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<HealthTipItem> _getGeneralTips() {
    return [
      HealthTipItem(Icons.emoji_events, "You are healthy! Keep it up!"),
      HealthTipItem(Icons.local_drink, "Drink plenty of water every day."),
      HealthTipItem(
        Icons.restaurant,
        "Eat a balanced diet full of vegetables and fruits.",
      ),
      HealthTipItem(Icons.directions_run, "Exercise regularly and sleep well."),
    ];
  }

  List<HealthTipItem> _getLeukemiaTips() {
    return [
      HealthTipItem(
        Icons.health_and_safety,
        "Take your medications on time and avoid skipping doses.",
      ),
      HealthTipItem(
        Icons.food_bank,
        "Consume high-protein, high-calorie meals to maintain energy.",
      ),
      HealthTipItem(
        Icons.clean_hands,
        "Wash your hands frequently to avoid infections.",
      ),
      HealthTipItem(Icons.masks, "Avoid crowded areas and wear a mask when needed."),
      HealthTipItem(
        Icons.support,
        "Stay in contact with your doctor and report any new symptoms.",
      ),
    ];
  }
}

class HealthTipItem {
  final IconData icon;
  final String text;

  HealthTipItem(this.icon, this.text);
}
