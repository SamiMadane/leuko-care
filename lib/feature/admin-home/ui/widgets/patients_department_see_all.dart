import 'package:flutter/material.dart';
import 'package:leuko_care/core/helpers/extensions.dart';
import 'package:leuko_care/core/resourses/colors_manager.dart';
import 'package:leuko_care/core/resourses/fonts_manager.dart';
import 'package:leuko_care/core/resourses/styles_manager.dart';
import 'package:leuko_care/core/routes/routes.dart';

class PatientsDepartmentSeeAll extends StatelessWidget {
  const PatientsDepartmentSeeAll({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Text(
                'Patients\' Department',
                style: getSemiBoldTextStyle(
                  fontSize: FontSizeManager.s18,
                  color: ColorsManager.darkBlue,
                ),
              ),
        const Spacer(),
        InkWell(
          onTap: () {
            context.pushNamed(Routes.allDoctorsScreen);
          },
          child: Text(
            'See All',
            style: getRegularTextStyle(fontSize: FontSizeManager.s14, color: ColorsManager.primaryColor),
          ),
        ),
      ],
    );
  }
}