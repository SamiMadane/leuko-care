import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/helpers/extensions.dart';
import 'package:leuko_care/core/routes/routes.dart';
import 'package:leuko_care/core/widgets/custom_status_dialog.dart';
import 'package:leuko_care/core/widgets/loading_dialog.dart';
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
            showDialog(
              context: context,
              builder: (context) => const LoadingDialog(),
              barrierDismissible: false,
            );
          },
          deleteDoctorStateSuccess: () {
            Navigator.pop(context); // إغلاق أي dialog مفتوح مسبقًا
            showAnimatedStatusDialog(
              context: context,
              title: 'Success'.tr(),
              message:
                  'The doctor and all of their patients have been deleted successfully.'
                      .tr(),
              statusType: DialogStatusType.success,
              onConfirm: () {
                context.pop(); // إغلاق dialog الحالي
                context.pop(); // إغلاق الشاشة السابقة
                context.pushReplacementNamed(Routes.allDoctorsScreen);
              },
            );
          },

          deleteDoctorStateError: (message) {
            Navigator.pop(context); // إغلاق أي dialog مفتوح مسبقًا
            showAnimatedStatusDialog(
              context: context,
              title: 'Error'.tr(),
              message: message,
              statusType: DialogStatusType.error,
              onConfirm: () => Navigator.of(context).pop(),
            );
          },
        );
      },
      child: const SizedBox.shrink(),
    );
  }
}
