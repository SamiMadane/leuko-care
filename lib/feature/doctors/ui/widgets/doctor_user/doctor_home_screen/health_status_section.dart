import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/core/widgets/health_status_bar_chart_widget.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';

class HealthStatusSection extends StatelessWidget {
  final List<PatientModel> patients;

  const HealthStatusSection({super.key, required this.patients});

  @override
  Widget build(BuildContext context) {
   
    final healthy = patients.where((p) => p.isExamined && p.healthStatus.toLowerCase() == 'healthy').length;
    final sick = patients.where((p) => p.isExamined && p.healthStatus.toLowerCase() == 'sick').length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Health Status:'.tr(),
          style: getBoldTextStyle(
            fontSize: IconSizeManager.s18,
            color: ColorsManager.darkBlue,
          ),
        ),
        SizedBox(height: HeightManager.h20),
        HealthStatusBarChart(
          data: {
            'healthy': healthy,
            'sick': sick,
          },
        ),
      ],
    );
  }
}