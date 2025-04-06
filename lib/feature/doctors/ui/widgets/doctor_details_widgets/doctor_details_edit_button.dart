import 'package:flutter/material.dart';
import 'package:leuko_care/core/helpers/extensions.dart';
import 'package:leuko_care/core/resourses/colors_manager.dart';
import 'package:leuko_care/core/resourses/fonts_manager.dart';
import 'package:leuko_care/core/resourses/sizes_util_manager.dart';
import 'package:leuko_care/core/resourses/styles_manager.dart';
import 'package:leuko_care/core/routes/routes.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';

class DoctorDetailsEditButton extends StatelessWidget {
  final DoctorModel doctor;

  const DoctorDetailsEditButton({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          context.pushNamed(Routes.addUpdateDoctorScreen, arguments: doctor);
        },
        icon: const Icon(Icons.edit, color: ColorsManager.white),
        label: Text(
          'Edit Doctor',
          style: getSemiBoldTextStyle(fontSize: FontSizeManager.s14, color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorsManager.primaryColor,
          padding:  EdgeInsets.symmetric(vertical: HeightManager.h14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(RadiusManager.r12),
          ),
        ),
      ),
    );
  }
}
