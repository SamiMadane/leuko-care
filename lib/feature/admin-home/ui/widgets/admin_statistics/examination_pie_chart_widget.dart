// ExaminationPieChart Widget
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ExaminationPieChart extends StatelessWidget {
  final Map<String, int> data;

  const ExaminationPieChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      child: PieChart(
        PieChartData(
          sections: data.entries.map((entry) {
            return PieChartSectionData(
              value: entry.value.toDouble(),
              title: '${entry.key}: ${entry.value}',
              color: _getPieChartColor(entry.key),
              radius: 70,
              titleStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
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
      case "Healthy":
        return Colors.green;
      case "Sick":
        return Colors.red;
      case "Critical":
        return Colors.orange;
      case "Examined":
        return Colors.green;
      case "Unexamined":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}