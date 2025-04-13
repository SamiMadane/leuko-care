import 'package:flutter/material.dart';
import 'package:leuko_care/core/helpers/extensions.dart';
import 'package:leuko_care/core/resourses/colors_manager.dart';
import 'package:leuko_care/core/resourses/fonts_manager.dart';
import 'package:leuko_care/core/resourses/sizes_util_manager.dart';
import 'package:leuko_care/core/resourses/styles_manager.dart';
import 'package:leuko_care/core/routes/routes.dart';
import 'package:leuko_care/core/widgets/app_text_button.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';

class DoctorDetailsEditButton extends StatelessWidget {
  final DoctorModel doctor;

  const DoctorDetailsEditButton({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: AppTextButton(
        buttonText: 'Edit Doctor',
        textStyle: getSemiBoldTextStyle(
          fontSize: FontSizeManager.s14,
          color: Colors.white,
        ),
        onPressed: () {
          context.pushNamed(Routes.addUpdateDoctorScreen, arguments: doctor);
        },
        backgroundColor: ColorsManager.primaryColor,
        borderRadius: RadiusManager.r12,
        horizontalPadding: WidthManager.w12,
        verticalPadding: HeightManager.h14,
        buttonHeight: HeightManager.h50,
      ),
    );
  }
}
