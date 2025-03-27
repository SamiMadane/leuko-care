import 'package:flutter/material.dart';
import 'package:leuko_care/core/resourses/colors_manager.dart';
import 'package:leuko_care/core/resourses/fonts_manager.dart';
import 'package:leuko_care/core/resourses/styles_manager.dart';


class DoctorsDepartmentSeeAll extends StatelessWidget {
  const DoctorsDepartmentSeeAll({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Doctors Department',
          style: getSemiBoldTextStyle(fontSize: FontSizeManager.s18, color: ColorsManager.darkBlue),
        ),
        const Spacer(),
        InkWell(
          onTap: () {
            
          },
          child: Text(
            'See All',
            style: getRegularTextStyle(fontSize: FontSizeManager.s12, color: ColorsManager.primaryColor),
          ),
        ),
      ],
    );
  }
}