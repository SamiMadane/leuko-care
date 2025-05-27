import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';

class PasswordValidations extends StatelessWidget {
  final bool hasLowerCase;
  final bool hasUpperCase;
  final bool hasSpecialCharacters;
  final bool hasNumber;
  final bool hasMinLength;
  const PasswordValidations({
    super.key,
    required this.hasLowerCase,
    required this.hasUpperCase,
    required this.hasSpecialCharacters,
    required this.hasNumber,
    required this.hasMinLength,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildValidationRow('At least 1 lowercase letter'.tr(), hasLowerCase),
        SizedBox(height: HeightManager.h2),
        buildValidationRow('At least 1 uppercase letter'.tr(), hasUpperCase),
        SizedBox(height: HeightManager.h2),
        buildValidationRow(
          'At least 1 special character'.tr(),
          hasSpecialCharacters,
        ),
        SizedBox(height: HeightManager.h2),

        buildValidationRow('At least 1 number'.tr(), hasNumber),
        SizedBox(height: HeightManager.h2),

        buildValidationRow('At least 8 characters long'.tr(), hasMinLength),
      ],
    );
  }

Widget buildValidationRow(String text, bool hasValidated) {
  return Row(
    children: [
      hasValidated
          ? Icon(Icons.check_circle, color: ColorsManager.green, size: 14)
          : CircleAvatar(radius: 2.5, backgroundColor: ColorsManager.gray),
      SizedBox(width: WidthManager.w6),
      Text(
        text,
        style: getRegularTextStyle(
          fontSize: FontSizeManager.s13,
          color: hasValidated ? ColorsManager.gray : ColorsManager.darkBlue,
        ).copyWith(
          decoration: hasValidated ? TextDecoration.lineThrough : null,
          decorationColor: ColorsManager.green,
          decorationThickness: 2,
        ),
      ),
    ],
  );
}

}
