import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leuko_care/core/helpers/extensions.dart';
import 'package:leuko_care/core/resourses/colors_manager.dart';
import 'package:leuko_care/core/resourses/fonts_manager.dart';
import 'package:leuko_care/core/resourses/sizes_util_manager.dart';
import 'package:leuko_care/core/resourses/styles_manager.dart';
import 'package:leuko_care/core/routes/routes.dart';
import 'package:leuko_care/core/widgets/app_text_button.dart';

class DoctorDetailsViewPatientsButton extends StatelessWidget {
  final String? doctorId;
  final String? doctorName;
  const DoctorDetailsViewPatientsButton({super.key, this.doctorId, this.doctorName});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: AppTextButton(
        buttonText: 'View Patient',
        textStyle: getSemiBoldTextStyle(
          fontSize: FontSizeManager.s14,
          color: Colors.white,
        ),
        onPressed: () {
          context.pushNamed(
            Routes.allPatientsScreen,
            arguments: {
              'doctorId': doctorId,
              'doctorName': doctorName,
            },
          );
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
