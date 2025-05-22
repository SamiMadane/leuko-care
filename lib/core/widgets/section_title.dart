import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: HeightManager.h8,
        horizontal: WidthManager.w20,
      ),
      child: Text(
        title,
        style: getSemiBoldTextStyle(
          fontSize: FontSizeManager.s16,
          color: ColorsManager.darkBlue,
        ),
      ),
    );
  }
}
