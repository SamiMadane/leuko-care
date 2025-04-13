import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/resourses/colors_manager.dart';
import 'package:leuko_care/core/resourses/fonts_manager.dart';
import 'package:leuko_care/core/resourses/sizes_util_manager.dart';
import 'package:leuko_care/core/resourses/styles_manager.dart';
import 'package:leuko_care/feature/admin-home/logic/cubit/admin_home_cubit.dart';
import 'package:leuko_care/feature/admin-home/ui/widgets/patients_department/patients_department_list_view_item.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';

class PatientsDepartmentListView extends StatelessWidget {
  final List<PatientModel> patients;

  const PatientsDepartmentListView({super.key, required this.patients});

  @override
  Widget build(BuildContext context) {
    final filteredPatients = context.read<AdminHomeCubit>().filteredPatients;

    if (filteredPatients.isEmpty) {
      return Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.person_off, size: 80, color: ColorsManager.gray),
              SizedBox(height: HeightManager.h16),
              Text(
                'No patients found',
                style: getMediumTextStyle(
                  fontSize: FontSizeManager.s16,
                  color: ColorsManager.gray,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Expanded(
      child: ListView.builder(
        itemCount: filteredPatients.length,
        itemBuilder: (context, index) {
          var patient = filteredPatients[index];
          return PatientsDepartmentListViewItem(patient: patient);
        },
      ),
    );
  }
}
