import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:leuko_care/core/helpers/extensions.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/core/routes/routes.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';

class DoctorEditButton extends StatelessWidget {
  final DoctorModel doctor;
  final String userType;

  const DoctorEditButton({super.key, required this.doctor, required this.userType});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          context.pushNamed(Routes.addUpdateDoctorScreen, arguments: {
            'doctorModel'.tr(): doctor,
            'userType'.tr(): userType,
          });
        },
        icon: const Icon(Icons.edit, color: ColorsManager.white),
        label: Text(
          userType == 'admin'.tr()
              ? 'Edit Doctor'.tr()
              : 'Edit Profile'.tr(),
          style: getSemiBoldTextStyle(
            fontSize: FontSizeManager.s14,
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorsManager.primaryColor,
          padding: EdgeInsets.symmetric(vertical: HeightManager.h14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(RadiusManager.r12),
          ),
        ),
      ),
    );
  }
}
