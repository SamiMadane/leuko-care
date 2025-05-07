import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/helpers/extensions.dart';
import 'package:leuko_care/core/routes/routes.dart';
import 'package:leuko_care/core/widgets/error_dialog.dart';
import 'package:leuko_care/core/widgets/loading_dialog.dart';
import 'package:leuko_care/core/widgets/success_dialog.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
import 'package:leuko_care/feature/doctors/logic/cubit/doctor_cubit.dart';
import 'package:leuko_care/feature/doctors/logic/cubit/doctor_state.dart';

class AddUpdateDoctorBlocListener extends StatelessWidget {
  final bool? isDoctorUser;

  const AddUpdateDoctorBlocListener({super.key, this.isDoctorUser});

  @override
  Widget build(BuildContext context) {
    return BlocListener<DoctorCubit, DoctorState>(
      listenWhen:
          (previous, current) =>
              current is AddDoctorStateLoading ||
              current is AddDoctorStateSuccess ||
              current is AddDoctorStateError ||
              current is UpdateDoctorStateLoading ||
              current is UpdateDoctorStateSuccess ||
              current is UpdateDoctorStateError,
      listener: (context, state) {
        state.whenOrNull(
          addDoctorStateLoading: () => _showLoadingDialog(context),
          updateDoctorStateLoading: () => _showLoadingDialog(context),
          addDoctorStateSuccess: () {
            context.pop();
            _showAddSuccessDialog(
              context,
              'The doctor has been added successfully.',
            );
          },
          updateDoctorStateSuccess: (doctor) {
            context.pop();
            _showUpdateSuccessDialog(
              context,
              (isDoctorUser!)
                  ? 'Your information updated successfully'
                  : 'Dr. updated successfully',
              doctor,
            );
          },
          addDoctorStateError: (message) {
            Navigator.pop(context);
            _showErrorDialog(context, message);
          },
          updateDoctorStateError: (message) {
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
      builder: (context) => LoadingDialog(),
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
              context.pushReplacementNamed(Routes.adminHomeScreen);
            },
          ),
    );
  }

  void _showUpdateSuccessDialog(
    BuildContext context,
    String message,
    DoctorModel doctor,
  ) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder:
          (context) => SuccessDialog(
            message: message,
            onSuccess: () {
              if (!isDoctorUser!) {
                context.pop();
                context.pop();
                context.pushReplacementNamed(
                  Routes.doctorDetailsScreen,
                  arguments: doctor,
                );
              } else {
                context.pop();
                context.pop();
                context.pushReplacementNamed(
                  Routes.doctorScreen,
                );
              }
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
