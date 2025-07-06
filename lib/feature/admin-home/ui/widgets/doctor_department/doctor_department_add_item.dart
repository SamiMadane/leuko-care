import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:leuko_care/core/helpers/extensions.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/core/routes/routes.dart';

class DoctorDepartmentAddItem extends StatelessWidget {
  const DoctorDepartmentAddItem();

  @override
  Widget build(BuildContext context) {
    final _ = context.locale;

    return GestureDetector(
      onTap: () => context.pushNamed(Routes.addUpdateDoctorScreen),
      child: Padding(
        padding: EdgeInsetsDirectional.only(start: WidthManager.w20),
        child: Column(
          children: [
            CircleAvatar(
              radius: RadiusManager.r30,
              backgroundColor: ColorsManager.lightBlue,
              child: Icon(
                Icons.add,
                size: 30,
                color: ColorsManager.primaryColor,
              ),
            ),
            SizedBox(height: HeightManager.h8),
            Text(
              'Add Doctor'.tr(),
              style: getRegularTextStyle(
                fontSize: FontSizeManager.s12,
                color: ColorsManager.darkBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}