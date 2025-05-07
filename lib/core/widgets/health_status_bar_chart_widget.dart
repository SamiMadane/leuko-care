import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:fl_chart/fl_chart.dart';

class HealthStatusBarChart extends StatelessWidget {
  final Map<String, int> data;

  const HealthStatusBarChart({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final completeData = {
      'Sick': data['sick'] ?? 0,
      'Healthy': data['healthy'] ?? 0,
    };

    final sortedEntries = completeData.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    final filteredEntries = sortedEntries.toList();

    final int dataLength = filteredEntries.length;
    final double baseHeight = 100;
    final double extraHeightPerItem = 30;
    final double maxHeight = 300;

    // حساب الارتفاع الديناميكي بناءً على عدد العناصر
    final double dynamicHeight = (baseHeight + dataLength * extraHeightPerItem)
        .clamp(baseHeight, maxHeight);
    final double maxValue = filteredEntries.isNotEmpty
        ? filteredEntries.map((e) => e.value).reduce((a, b) => a > b ? a : b).toDouble()
        : 0;

    final double maxY = maxValue +1;


    return SizedBox(
      height: dynamicHeight,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: maxY,
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              getTooltipColor: (group) => ColorsManager.darkBlue,
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                final label = _formatLabel(filteredEntries[group.x.toInt()].key);
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
                interval: _getInterval(maxValue),
                getTitlesWidget: (value, _) => Text(
                  value.toInt().toString(),
                  style: const TextStyle(fontSize: 10),
                ),
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index < 0 || index >= filteredEntries.length)
                    return const SizedBox.shrink();
                  final key = filteredEntries[index].key;
                  Color titleColor;
                  if (key.toLowerCase() == 'sick') {
                    titleColor = Colors.redAccent;
                  } else {
                    titleColor = Colors.green;
                  }

                  return SideTitleWidget(
                    meta: meta,
                    child: Text(
                      _formatLabel(key),
                      style: getMediumTextStyle(
                        fontSize: FontSizeManager.s11,
                        color: titleColor,
                      ),
                    ),
                  );
                },
              ),
            ),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          gridData: FlGridData(show: true),
          borderData: FlBorderData(show: false),
          barGroups: filteredEntries.mapIndexed((index, entry) {
            final key = entry.key.toLowerCase();
            Color barColor;
            if (key == 'sick') {
              barColor = Colors.redAccent;
            } else {
              barColor = Colors.green;
            }

            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: entry.value.toDouble(),
                  width: WidthManager.w16,
                  color: barColor,
                  borderRadius: BorderRadius.circular(RadiusManager.r4),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  String _formatLabel(String key) {
    switch (key.toLowerCase()) {
      case 'sick':
        return 'Sick';
      case 'healthy':
        return 'Healthy';
      default:
        return key;
    }
  }

  double _getInterval(double maxValue) {
    if (maxValue <= 10) return 1;  // تغيير من 2 إلى 1 ليتمكن من عرض الأرقام الصغيرة
    if (maxValue <= 50) return 5;
    if (maxValue <= 100) return 10;
    return 20;
  }
}
