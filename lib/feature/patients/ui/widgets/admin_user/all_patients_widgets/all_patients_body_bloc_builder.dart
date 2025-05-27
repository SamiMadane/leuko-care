import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/feature/patients/logic/cubit/patient_cubit.dart';
import 'package:leuko_care/feature/patients/logic/cubit/patient_state.dart';
import 'package:leuko_care/core/widgets/all_patient_list_view.dart';

class AllPatientsBodyBlocBuilder extends StatelessWidget {
  final String doctorId;
  final String doctorName;


  const AllPatientsBodyBlocBuilder({super.key, required this.doctorId, required this.doctorName});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PatientCubit, PatientState>(
      buildWhen:
          (previous, current) =>
              current is GetPatientsByDoctorIdStateLoading ||
              current is GetPatientsByDoctorIdStateSuccess ||
              current is GetPatientsByDoctorIdStateError,
      builder: (context, state) {
        switch (state) {
          case GetPatientsByDoctorIdStateLoading():
            return _buildPatientsLoadingWidget();

          case GetPatientsByDoctorIdStateSuccess():
            return AllPaitentListView(patients: state.patients,doctorId: doctorId,doctorName: doctorName,userType: 'admin'.tr(),);

          case GetPatientsByDoctorIdStateError():
            return _buildPatientsErrorWidget(message: state.message);

          default:
            return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildPatientsLoadingWidget() {
    return Center(
      child: CircularProgressIndicator(color: ColorsManager.primaryColor),
    );
  }

  Widget _buildPatientsErrorWidget({required String message}) {
    return Center(
      child: Text(message, style: const TextStyle(color: Colors.red)),
    );
  }
}
