import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';
import 'package:leuko_care/feature/patients/ui/widgets/patient_user/home/patient_examined/health_info_widget.dart';
import 'package:leuko_care/feature/patients/ui/widgets/patient_user/home/patient_examined/sample_image_widget.dart';

class HealthOverviewWidget extends StatelessWidget {
  final PatientModel patient;

  const HealthOverviewWidget({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Health Overview",
          style: getBoldTextStyle(
            fontSize: FontSizeManager.s18,
            color: ColorsManager.darkBlue,
          ),
        ),
        SizedBox(height: HeightManager.h20),
        if (patient.latestSampleImageUrl != null &&
            patient.latestSampleImageUrl!.isNotEmpty)
          SampleImageWidget(imageUrl: patient.latestSampleImageUrl!),

        HealthInfoWidget(
          icon: Icons.health_and_safety,
          label: "Health Status",
          value: patient.healthStatus,
        ),
        HealthInfoWidget(
          icon: Icons.biotech,
          label: "Leukemia Type",
          value: patient.leukemiaType,
        ),
        HealthInfoWidget(
          icon: Icons.check_circle_outline,
          label: "Diagnosis Confidence",
          value: "${patient.diseaseConfidence}%",
        ),
        HealthInfoWidget(
          icon: Icons.date_range,
          label: "Last Exam Date",
          value: patient.lastExamDate ?? "N/A",
        ),
      ],
    );
  }
}
