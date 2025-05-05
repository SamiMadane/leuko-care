import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';
import 'package:leuko_care/feature/patients/ui/widgets/patient_user/home/patient_examined/health_card.dart';

class HealthOverviewWidget extends StatelessWidget {
  final PatientModel patient;

  const HealthOverviewWidget({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Health Overview:",
          style: getSemiBoldTextStyle(fontSize: FontSizeManager.s18, color: ColorsManager.darkBlue)
        ),
        SizedBox(height: HeightManager.h14),
        HealthCard(
          title: "Leukemia Type",
          value: patient.leukemiaType,
          icon: Icons.biotech,
        ),
        SizedBox(height: HeightManager.h14,),
        HealthCard(
          title: "Health Status",
          value: patient.healthStatus,
          icon: Icons.health_and_safety,
        ),
      ],
    );
  }
}
