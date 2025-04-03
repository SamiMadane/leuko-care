import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/helpers/extensions.dart';
import 'package:leuko_care/core/routes/routes.dart';
import 'package:leuko_care/feature/doctors/logic/cubit/doctor_cubit.dart';
import 'package:leuko_care/feature/doctors/logic/cubit/doctor_state.dart';
import 'package:leuko_care/core/resourses/colors_manager.dart';
import 'package:leuko_care/core/resourses/styles_manager.dart';

class DeleteDoctorBlocListener extends StatelessWidget {
  const DeleteDoctorBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<DoctorCubit, DoctorState>(
      listenWhen: (previous, current) =>
          current is DeleteDoctorStateLoading ||
          current is DeleteDoctorStateSuccess ||
          current is DeleteDoctorStateError,
      listener: (context, state) {
        state.whenOrNull(
          deleteDoctorStateLoading: () => _showLoadingDialog(context),
          deleteDoctorStateSuccess: () {
            context.pop();
            _showSuccessDialog(context, 'The doctor has been deleted successfully.');
          },
          deleteDoctorStateError: (message) {
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
      builder: (context) => const Center(
        child: CircularProgressIndicator(color: ColorsManager.primaryColor),
      ),
      barrierDismissible: false,
    );
  }

  void _showSuccessDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
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
              // قم بالانتقال لصفحة الأطباء بعد النجاح
              context.pushNamedAndRemoveUntil(
                Routes.allDoctorsScreen,
                predicate: (route) =>
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
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
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
