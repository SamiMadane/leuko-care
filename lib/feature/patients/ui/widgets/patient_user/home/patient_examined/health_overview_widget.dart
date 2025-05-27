import 'package:easy_localization/easy_localization.dart';

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
    final healthItems = [
      HealthInfoData(Icons.health_and_safety, 'Health Status'.tr(), patient.healthStatus),
      HealthInfoData(Icons.biotech, 'Leukemia Type'.tr(), patient.leukemiaType),
      HealthInfoData(Icons.check_circle_outline, 'Diagnosis Confidence'.tr(), '${patient.diseaseConfidence}%'.tr()),
      HealthInfoData(Icons.date_range, 'Last Exam Date'.tr(), patient.lastExamDate ?? "N/A"),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Health Overview'.tr(),
          style: getSemiBoldTextStyle(
            fontSize: FontSizeManager.s18,
            color: ColorsManager.darkBlue,
          ),
        ),
        SizedBox(height: HeightManager.h20),
        if (patient.latestSampleImageUrl != null && patient.latestSampleImageUrl!.isNotEmpty)
          SampleImageWidget(imageUrl: patient.latestSampleImageUrl!),
        SizedBox(height: HeightManager.h12),

        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: healthItems.length,
          padding: EdgeInsets.symmetric(horizontal: WidthManager.w8),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: HeightManager.h16,
            crossAxisSpacing: WidthManager.w16,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            final item = healthItems[index];
            return HealthInfoWidget(
              icon: item.icon,
              label: item.label,
              value: item.value,
            );
          },
        ),
      ],
    );
  }
}

class HealthInfoData {
  final IconData icon;
  final String label;
  final String value;

  HealthInfoData(this.icon, this.label, this.value);
}
