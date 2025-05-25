import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/core/widgets/disease_statistics_table.dart';

class DiseaseStatisticsSection extends StatelessWidget {
  final Map<String, int> diseaseCounts;
  const DiseaseStatisticsSection({super.key, required this.diseaseCounts});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Disease Statistics:",
          style: getBoldTextStyle(
            fontSize: IconSizeManager.s18,
            color: ColorsManager.darkBlue,
          ),
        ),
        SizedBox(height: HeightManager.h14),
        DiseaseStatisticsTable(diseaseCounts: diseaseCounts),
      ],
    );
  }
}
