import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/helpers/extensions.dart';
import 'package:leuko_care/core/routes/routes.dart';
import 'package:leuko_care/core/widgets/error_dialog.dart';
import 'package:leuko_care/core/widgets/loading_dialog.dart';
import 'package:leuko_care/core/widgets/success_dialog.dart';
import 'package:leuko_care/feature/doctors/logic/cubit/doctor_cubit.dart';
import 'package:leuko_care/feature/doctors/logic/cubit/doctor_state.dart';

class DeleteDoctorBlocListener extends StatelessWidget {
  const DeleteDoctorBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<DoctorCubit, DoctorState>(
      listenWhen:
          (previous, current) =>
              current is DeleteDoctorStateLoading ||
              current is DeleteDoctorStateSuccess ||
              current is DeleteDoctorStateError,
      listener: (context, state) {
        state.whenOrNull(
          deleteDoctorStateLoading: () {
            print('Doctor deleted loading');

            showDialog(
              context: context,
              builder: (context) => const LoadingDialog(),
              barrierDismissible: false,
            );
          },
          deleteDoctorStateSuccess: () {
            print('Doctor deleted successfully');
            Navigator.pop(context);
            showDialog(
              context: context,
              builder:
                  (context) => SuccessDialog(
                    message: 'The doctor has been deleted successfully.',
                    onSuccess: () {
                      context.pushNamedAndRemoveUntil(
                        Routes.allDoctorsScreen,
                        predicate:
                            (route) =>
                                route.settings.name == Routes.adminHomeScreen,
                      );
                    },
                  ),
            );
          },
          deleteDoctorStateError: (message) {
            print('Doctor deleted faield');

            Navigator.pop(context);
            showDialog(
              context: context,
              builder: (context) => ErrorDialog(message: message),
            );
          },
        );
      },
      child: const SizedBox.shrink(),
    );
  }
}
