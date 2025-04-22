import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/helpers/extensions.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/core/routes/routes.dart';
import 'package:leuko_care/feature/admin-home/logic/cubit/admin_home_cubit.dart';

class PatientsDepartmentSeeAll extends StatelessWidget {
  const PatientsDepartmentSeeAll({super.key});

  @override
  Widget build(BuildContext context) {
    // we use watch here to listen to the selectedDoctor state and rebuild the widget when it changes
    final selectedDoctor = context.watch<AdminHomeCubit>().selectedDoctor;

    return Row(
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
            context.pushNamed(
              Routes.allPatientsScreen,
              arguments: {
                'doctorId': selectedDoctor!.id,
                'doctorName': selectedDoctor.name,
              },
            );
          },
          child: Text(
            'See All',
            style: getRegularTextStyle(
              fontSize: FontSizeManager.s14,
              color: ColorsManager.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
