import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/helpers/extensions.dart';
import 'package:leuko_care/core/routes/routes.dart';
import 'package:leuko_care/core/widgets/error_dialog.dart';
import 'package:leuko_care/core/widgets/loading_dialog.dart';
import 'package:leuko_care/core/widgets/success_dialog.dart';
import 'package:leuko_care/feature/patients/logic/cubit/patient_cubit.dart';
import 'package:leuko_care/feature/patients/logic/cubit/patient_state.dart';

class DeletePatientBlocListener extends StatelessWidget {
  final String doctorId;
  final String doctorName;
  final Widget child;

  const DeletePatientBlocListener({
    super.key,
    required this.doctorId,
    required this.doctorName,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<PatientCubit, PatientState>(
      listenWhen:
          (previous, current) =>
              current is DeletePatientStateLoading ||
              current is DeletePatientStateSuccess ||
              current is DeletePatientStateError,
      listener: (context, state) {
        state.whenOrNull(
          deletePatientStateLoading: () {
            showDialog(
              context: context,
              builder: (context) => const LoadingDialog(),
              barrierDismissible: false,
            );
          },
          deletePatientStateSuccess: () {
            Navigator.of(
              context,
              rootNavigator: true,
            ).pop(); // لإغلاق LoadingDialog
            showDialog(
              context: context,
              builder:
                  (context) => SuccessDialog(
                    message: 'The patient has been deleted successfully.'.tr(),
                    onSuccess: () {
                      context.pop();
                      context.pop();
                      context.pop();

                      context.pushReplacementNamed(
                        Routes.allPatientsScreen,
                        arguments: {
                          'doctorId': doctorId,
                          'doctorName': doctorName,
                        },
                      );
                    },
                  ),
            );
          },
          deletePatientStateError: (message) {
            Navigator.of(context, rootNavigator: true).pop();
            showDialog(
              context: context,
              builder: (context) => ErrorDialog(message: message),
            );
          },
        );
      },
      child: child,
    );
  }
}
