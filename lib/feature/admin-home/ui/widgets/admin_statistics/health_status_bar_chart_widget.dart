// HealthStatusBarChart Widget
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';

class HealthStatusBarChart extends StatelessWidget {
  final Map<String, int> data;

  const HealthStatusBarChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: HeightManager.h270,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: (data.values.isNotEmpty ? data.values.reduce((a, b) => a > b ? a : b) : 0).toDouble() + 5,
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              getTooltipColor: (group) => ColorsManager.darkBlue,
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                final label = data.keys.elementAt(group.x.toInt());
                return BarTooltipItem(
                  '$label: ${rod.toY.toInt()}',
                  const TextStyle(color: Colors.white),
                );
              },
            ),
          ),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: WidthManager.w28,
                getTitlesWidget: (value, _) => Text(value.toInt().toString(), style: const TextStyle(fontSize: 10)),
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index < 0 || index >= data.keys.length) return const SizedBox.shrink();
                  return SideTitleWidget(
                    meta: meta,
                    child: Text(data.keys.elementAt(index), style: getMediumTextStyle(fontSize: FontSizeManager.s11, color: ColorsManager.darkBlue)),
                  );
                },
              ),
            ),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          gridData: FlGridData(show: true),
          borderData: FlBorderData(show: false),
          barGroups: data.entries.mapIndexed((index, entry) {
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: entry.value.toDouble(),
                  width: WidthManager.w16,
                  gradient: LinearGradient(
                    colors: [ColorsManager.primaryColor, ColorsManager.lightBlueAccent, ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                  borderRadius: BorderRadius.circular(RadiusManager.r4),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
