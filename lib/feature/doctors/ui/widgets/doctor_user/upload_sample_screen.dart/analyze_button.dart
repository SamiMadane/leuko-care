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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: SizedBox(
        width: double.infinity,
        height: HeightManager.h44, // ارتفاع أكبر للزر
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorsManager.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(RadiusManager.r20),
            ),
          ),
          child: Text(
            'Analyze Sample'.tr(),
            style: getMediumTextStyle(
              fontSize: FontSizeManager.s17,
              color: ColorsManager.white,
            ),
          ),
        ),
      ),
    );
  }
}
