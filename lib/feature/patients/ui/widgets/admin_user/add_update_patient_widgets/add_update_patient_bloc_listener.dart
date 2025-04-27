import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/helpers/extensions.dart';
import 'package:leuko_care/core/routes/routes.dart';
import 'package:leuko_care/core/widgets/error_dialog.dart';
import 'package:leuko_care/core/widgets/success_dialog.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';
import 'package:leuko_care/feature/patients/logic/cubit/patient_cubit.dart';
import 'package:leuko_care/feature/patients/logic/cubit/patient_state.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';

class AddUpdatePatientBlocListener extends StatelessWidget {
  final PatientModel? patient;
  final String? doctorId;
  final String? doctorName;
  const AddUpdatePatientBlocListener({
    super.key,
    this.patient,
    this.doctorId,
    this.doctorName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<PatientCubit, PatientState>(
      listenWhen:
          (previous, current) =>
              current is AddPatientStateLoading ||
              current is AddPatientStateSuccess ||
              current is AddPatientStateError ||
              current is UpdatePatientStateLoading ||
              current is UpdatePatientStateSuccess ||
              current is UpdatePatientStateError,
      listener: (context, state) {
        state.whenOrNull(
          addPatientStateLoading: () => _showLoadingDialog(context),
          updatePatientStateLoading: () => _showLoadingDialog(context),
          addPatientStateSuccess: () {
            context.pop();
            _showAddSuccessDialog(
              context,
              'The patient has been added successfully.',
            );
          },
          updatePatientStateSuccess: (patient) {
            context.pop();
            _showUpdateSuccessDialog(
              context,
              'Patient updated successfully',
              patient,
            );
          },
          addPatientStateError: (message) {
            context.pop();
            _showErrorDialog(context, message);
          },
          updatePatientStateError: (message) {
            context.pop();
            _showErrorDialog(context, message);
          },
        );
      },
      child: const SizedBox.shrink(),
    );
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => const Center(
            child: CircularProgressIndicator(color: ColorsManager.primaryColor),
          ),
      barrierDismissible: false,
    );
  }

  void _showAddSuccessDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder:
          (context) => SuccessDialog(
            message: message,
            onSuccess: () {
              context.pop();
              context.pop();
              context.pushReplacementNamed(
                Routes.allPatientsScreen,
                arguments: {'doctorId': doctorId, 'doctorName': doctorName},
              );
            },
          ),
    );
  }

  void _showUpdateSuccessDialog(
    BuildContext context,
    String message,
    PatientModel patient,
  ) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder:
          (context) => SuccessDialog(
            message: message,
            onSuccess: () {
              context.pop();
              context.pop();
              context.pushReplacementNamed(
                Routes.patientDetailsScreen,
                arguments: {
                  'patientId': patient.id,
                  'doctorId': doctorId,
                  'doctorName': doctorName,
                },
              );
            },
          ),
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => ErrorDialog(message: message),
    );
  }
}
