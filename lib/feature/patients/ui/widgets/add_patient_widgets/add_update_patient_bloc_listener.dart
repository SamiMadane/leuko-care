import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/helpers/extensions.dart';
import 'package:leuko_care/core/routes/routes.dart';
import 'package:leuko_care/feature/patients/logic/cubit/patient_cubit.dart';
import 'package:leuko_care/feature/patients/logic/cubit/patient_state.dart';
import 'package:leuko_care/core/resourses/colors_manager.dart';
import 'package:leuko_care/core/resourses/styles_manager.dart';

class AddUpdatePatientBlocListener extends StatelessWidget {
  const AddUpdatePatientBlocListener({super.key});

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
            _showSuccessDialog(
              context,
              'The patient has been added successfully.',
            );
          },
          updatePatientStateSuccess: () {
            context.pop();
            _showSuccessDialog(context, 'Patient updated successfully');
          },
          addPatientStateError: (message) {
            Navigator.pop(context);
            _showErrorDialog(context, message);
          },
          updatePatientStateError: (message) {
            Navigator.pop(context);
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

  void _showSuccessDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder:
          (context) => AlertDialog(
            icon: const Icon(Icons.check, color: Colors.green, size: 32),
            content: Text(
              message,
              style: getMediumTextStyle(
                fontSize: 15,
                color: ColorsManager.darkBlue,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  context.pop();
                  context.pushNamedAndRemoveUntil(Routes.adminHomeScreen, predicate: (_) => false);
                },
                child: Text(
                  'Got it',
                  style: getSemiBoldTextStyle(
                    fontSize: 14,
                    color: ColorsManager.primaryColor,
                  ),
                ),
              ),
            ],
          ),
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(
              'Error',
              style: getBoldTextStyle(fontSize: 20, color: Colors.red),
            ),
            content: Text(
              message,
              style: getRegularTextStyle(
                fontSize: 16,
                color: ColorsManager.darkBlue,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => context.pop(),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }
}
