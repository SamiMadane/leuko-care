import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/core/widgets/examined_status_progress_widget.dart';

class ExaminationChartSection extends StatelessWidget {
    final int total;
  final int pending;
  const ExaminationChartSection({super.key, required this.total, required this.pending});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Examination Stats:",
          style: getBoldTextStyle(
            fontSize: IconSizeManager.s18,
            color: ColorsManager.darkBlue,
          ),
        ),
        SizedBox(height: HeightManager.h14),
        ExaminedStatusProgressWidget(
          data: {
            "Examined": total - pending,
            "Unexamined": pending,
          },
        ),
      ],
    );
  }
}