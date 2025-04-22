import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';

class TermsAndConditionsText extends StatelessWidget {
  const TermsAndConditionsText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: 'By logging, you agree to our',
            style: getRegularTextStyle(
              fontSize: FontSizeManager.s13,
              color: ColorsManager.gray,
            ),
          ),
          TextSpan(
            text: ' Terms & Conditions',
            style: getMediumTextStyle(
              fontSize: FontSizeManager.s13,
              color: ColorsManager.darkBlue,
            ),
          ),
          TextSpan(
            text: ' and',
            style: getRegularTextStyle(
              fontSize: FontSizeManager.s13,
              color: ColorsManager.gray,
              height: HeightManager.h1_5,
            ),
          ),
          TextSpan(
            text: ' Privacy Policy',
            style: getMediumTextStyle(
              fontSize: FontSizeManager.s13,
              color: ColorsManager.darkBlue,
            ),
          ),
        ],
      ),
    );
  }
}
