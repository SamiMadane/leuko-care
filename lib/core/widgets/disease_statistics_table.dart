import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';

class DiseaseStatisticsTable extends StatelessWidget {
  final Map<String, int> diseaseCounts;

  const DiseaseStatisticsTable({Key? key, required this.diseaseCounts})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Table(
          border: TableBorder.all(color: ColorsManager.lightGray),
          columnWidths: const {0: FlexColumnWidth(1.5), 1: FlexColumnWidth(1)},
          children: [
            // Header row
            TableRow(
              decoration: BoxDecoration(color: ColorsManager.moreLighterGray),
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: HeightManager.h8,
                    horizontal: WidthManager.w8,
                  ),
                  child: Text(
                    'Leukemia Type',
                    style: getBoldTextStyle(
                      fontSize: FontSizeManager.s14,
                      color: ColorsManager.darkBlue,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: HeightManager.h8,
                    horizontal: WidthManager.w8,
                  ),
                  child: Text(
                    'Number of cases',
                    style: getBoldTextStyle(
                      fontSize: FontSizeManager.s14,
                      color: ColorsManager.darkBlue,
                    ),
                  ),
                ),
              ],
            ),
            // Dynamic rows
            ...diseaseCounts.entries
                .where((entry) => entry.key.toLowerCase() != "unknown")
                .map((entry) {
                  return TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: HeightManager.h8,
                          horizontal: WidthManager.w8,
                        ),
                        child: Text(entry.key,style: getSemiBoldTextStyle(fontSize: FontSizeManager.s13, color: ColorsManager.darkBlue),),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: HeightManager.h8,
                          horizontal: WidthManager.w8,
                        ),
                        child: Center(child: Text(entry.value.toString(),style: getSemiBoldTextStyle(fontSize: FontSizeManager.s16, color: ColorsManager.darkBlue),)),
                      ),
                    ],
                  );
                })
                .toList(),
          ],
        ),
      ],
    );
  }
}
