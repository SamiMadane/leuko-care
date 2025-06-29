import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/helpers/extensions.dart';
import 'package:leuko_care/core/widgets/custom_status_dialog.dart';
import 'package:leuko_care/feature/doctors/logic/cubit/doctor_cubit.dart';
import 'package:leuko_care/feature/doctors/logic/cubit/doctor_state.dart';

class ConfirmResultBlocListener extends StatelessWidget {
  final Widget child;

  const ConfirmResultBlocListener({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<DoctorCubit, DoctorState>(
      listener: (context, state) {
        state.whenOrNull(
          savingAnalysisResultSuccess: () {
            showAnimatedStatusDialog(
              context: context,
              statusType: DialogStatusType.success,
              title: 'Success'.tr(),
              message: 'Analysis result has been saved successfully.'
                  .tr(),
              buttonText: 'OK'.tr(),
              onConfirm: () => context.pop(),
            );
          },
          savingAnalysisResultError: (message) {
            showAnimatedStatusDialog(
              context: context,
              statusType: DialogStatusType.error,
              title: 'Error'.tr(),
              message: message,
              buttonText: 'OK'.tr(),
              onConfirm: () => context.pop(),
            );
          },
        );
      },
      child: child,
    );
  }
}
