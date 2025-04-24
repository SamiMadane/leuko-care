// PatientsPerDoctorList Widget
import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';

class PatientsPerDoctorList extends StatelessWidget {
  final Map<String, int> data;

  const PatientsPerDoctorList({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: data.entries.map((entry) {
        return Card(
          color: ColorsManager.lightGreen,
          elevation: 8,
          margin: EdgeInsets.symmetric(vertical: HeightManager.h8),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: WidthManager.w16),
            title: Text(
              "Dr. ${entry.key}: ${entry.value} Patients",
              style: getMediumTextStyle(fontSize: FontSizeManager.s16, color: ColorsManager.darkBlue)
            ),
          ),
        );
      }).toList(),
    );
  }
}
