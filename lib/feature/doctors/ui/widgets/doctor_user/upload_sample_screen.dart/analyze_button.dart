import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';

class AnalyzeButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AnalyzeButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorsManager.primaryColor,
          padding: EdgeInsets.symmetric(
            horizontal: WidthManager.w40,
            vertical: HeightManager.h12,
          ),
        ),
        child: Text(
          'Analyze Sample'.tr(),
          style: getMediumTextStyle(
            fontSize: FontSizeManager.s14,
            color: ColorsManager.white,
          ),
        ),
      ),
    );
  }
}
