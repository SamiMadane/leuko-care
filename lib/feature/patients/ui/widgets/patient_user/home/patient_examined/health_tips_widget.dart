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
    final bool isSick =
        patient.isExamined && patient.healthStatus.toLowerCase() == "sick";
    final tips = isSick ? _getLeukemiaTips() : _getGeneralTips();

    final primaryColor = isSick ? Colors.deepPurple : Colors.green.shade700;
    final gradientColors =
        isSick
            ? [Colors.deepPurple.shade300, Colors.deepPurple.shade700]
            : [Colors.green.shade300, Colors.green.shade700];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Helpful Health Tips",
          style: getSemiBoldTextStyle(
            fontSize: FontSizeManager.s18,
            color: ColorsManager.darkBlue,
          ),
        ),
        SizedBox(height: HeightManager.h20),

        /// الكارد الرئيسي
        ClipRRect(
          borderRadius: BorderRadius.circular(RadiusManager.r20),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: WidthManager.w2, vertical: HeightManager.h6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(RadiusManager.r20),
              boxShadow: [
                BoxShadow(
                  color: primaryColor.withOpacity(0.2),
                  blurRadius: 5,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: HeightManager.h20,
                horizontal: WidthManager.w12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// العنوان داخل الكارد
                  Text(
                    isSick
                        ? 'Tips for Managing Leukemia'
                        : '🎉 Congratulations! Stay Healthy',
                    style: getBoldTextStyle(
                      fontSize: FontSizeManager.s16,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: HeightManager.h20),

                  /// قائمة النصائح
                  ...tips.mapIndexed((index, tip) {
                    return Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: gradientColors,
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: gradientColors.last.withOpacity(0.4),
                                    blurRadius: 8,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Icon(
                                tip.icon,
                                size: 24,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: WidthManager.w20),
                            Expanded(
                              child: Text(
                                tip.text,
                                style: getMediumTextStyle(
                                  fontSize: FontSizeManager.s15,
                                  color: ColorsManager.darkBlue,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),

                        /// Divider بين العناصر (عدا الأخير)
                        if (index != tips.length - 1)
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: HeightManager.h16,
                            ),
                            child: Divider(
                              thickness: 1,
                              color: primaryColor.withOpacity(0.1),
                            ),
                          ),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ),
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
      HealthTipItem(
        Icons.masks,
        "Avoid crowded areas and wear a mask when needed.",
      ),
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

extension IterableExtension<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(int index, E item) f) {
    var i = 0;
    return map((e) => f(i++, e));
  }
}
