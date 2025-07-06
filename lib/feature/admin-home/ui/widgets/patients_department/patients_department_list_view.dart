import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/resources/assets_manager.dart';
import 'package:leuko_care/core/widgets/empty_state_widget.dart';
import 'package:leuko_care/feature/admin-home/logic/cubit/admin_home_cubit.dart';
import 'package:leuko_care/feature/admin-home/ui/widgets/patients_department/patients_department_list_view_item.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';

class PatientsDepartmentListView extends StatelessWidget {
  final List<PatientModel> patients;

  const PatientsDepartmentListView({super.key, required this.patients});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AdminHomeCubit>();
    final filteredPatients = cubit.filteredPatients;
    final hasDoctors = cubit.doctors.isNotEmpty;

    if (filteredPatients.isEmpty) {
      return Expanded(
        child:
            hasDoctors
                ?  EmptyStateWidget(
                  lottiePath: AssetsManager.noPatientsLottie,
                  title: 'No patients assigned'.tr(),
                  message:
                      'There are currently no patients assigned to this doctor. You can add patients or select a different doctor.'.tr(),
                )
                :  EmptyStateWidget(
                  lottiePath: AssetsManager.noDoctorsLottie,
                  title: 'No doctors found'.tr(),
                  message:
                      'no doctors added message',
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
