// ExaminationPieChart Widget
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';

class ExaminationPieChart extends StatelessWidget {
  final Map<String, int> data;

  const ExaminationPieChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: HeightManager.h230,
      child: PieChart(
        PieChartData(
          sections: data.entries.map((entry) {
            return PieChartSectionData(
              value: entry.value.toDouble(),
              title: '${entry.key}: ${entry.value}',
              color: _getPieChartColor(entry.key),
              radius: RadiusManager.r64,
              titleStyle: getBoldTextStyle(fontSize: FontSizeManager.s12, color: ColorsManager.white)
            );
          }).toList(),
          borderData: FlBorderData(show: false),
          sectionsSpace: 2,
          centerSpaceRadius: 40,
        ),
      ),
    );
  }

  Color _getPieChartColor(String status) {
    switch (status) {
      case "Examined":
        return Colors.green;
      case "Unexamined":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}