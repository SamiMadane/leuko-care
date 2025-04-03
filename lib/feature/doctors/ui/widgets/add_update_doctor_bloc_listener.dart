import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/helpers/extensions.dart';
import 'package:leuko_care/core/routes/routes.dart';
import 'package:leuko_care/feature/doctors/logic/cubit/doctor_cubit.dart';
import 'package:leuko_care/feature/doctors/logic/cubit/doctor_state.dart';
import 'package:leuko_care/core/resourses/colors_manager.dart';
import 'package:leuko_care/core/resourses/styles_manager.dart';

class AddUpdateDoctorBlocListener extends StatelessWidget {
  const AddUpdateDoctorBlocListener({super.key});

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
            _showSuccessDialog(
              context,
              'The doctor has been added successfully.',
            );
          },
          updateDoctorStateSuccess: () {
            context.pop();
            _showSuccessDialog(context, 'Dr. updated successfully');
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
                  context.pushNamedAndRemoveUntil(
                    Routes.allDoctorsScreen,
                    predicate:
                        (route) =>
                            route.settings.name == Routes.adminHomeScreen,
                  );
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
    ).then((_) {
      // عندما يتم إغلاق الـ Dialog (بما في ذلك الضغط خارج الـ Dialog)
      context.pushNamedAndRemoveUntil(
        Routes.allDoctorsScreen,
        predicate: (route) => route.settings.name == Routes.adminHomeScreen,
      );
    });
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            icon: const Icon(Icons.error, color: Colors.red, size: 32),
            content: Text(
              message,
              style: getMediumTextStyle(
                fontSize: 15,
                color: ColorsManager.darkBlue,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
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
}
