import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/feature/doctors/ui/widgets/doctor_user/sample_result_screen/confirm_result_bloc_listener.dart';

Widget confirmationButtonsWidget({
  required VoidCallback onConfirm,
  required VoidCallback onCancel,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      ConfirmResultBlocListener(
        child: Expanded(
          flex: 2,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: WidthManager.w10),
            child: ElevatedButton.icon(
              onPressed: onConfirm,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsManager.primaryColor,
                padding: EdgeInsets.symmetric(vertical: HeightManager.h12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(RadiusManager.r16),
                ),
              ),
              icon: Icon(Icons.check, color: ColorsManager.white),
              label: Text(
                'Confirm Diagnosis'.tr(),
                style: TextStyle(
                  fontSize: FontSizeManager.s15,
                  color: ColorsManager.white,
                ),
              ),
            ),
          ),
        ),
      ),
      Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: WidthManager.w10),
          child: ElevatedButton.icon(
            onPressed: onCancel,
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsManager.red,
              padding: EdgeInsets.symmetric(vertical: HeightManager.h12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(RadiusManager.r16),
              ),
            ),
            icon: Icon(Icons.cancel, color: ColorsManager.white),
            label: Text(
              'Cancel'.tr(),
              style: TextStyle(
                fontSize: FontSizeManager.s15,
                color: ColorsManager.white,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
