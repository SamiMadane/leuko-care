import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/widgets/custom_status_dialog.dart';
import 'package:leuko_care/core/widgets/loading_dialog.dart';
import 'package:leuko_care/feature/auth/logic/cubit/auth_cubit.dart';
import 'package:leuko_care/feature/auth/logic/cubit/auth_state.dart';

class ResetPasswordBlocListener extends StatelessWidget {
  const ResetPasswordBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (prev, curr) =>
          curr is ResetPasswordLoading ||
          curr is ResetPasswordSuccess ||
          curr is ResetPasswordFailure,
      listener: (context, state) {
        if (state is ResetPasswordLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const LoadingDialog(),
          );
        } else if (state is ResetPasswordSuccess) {
          Navigator.of(context).pop(); // إغلاق LoadingDialog
          Navigator.of(context).pop(); // إغلاق ForgotPasswordDialog
          showAnimatedStatusDialog(
            context: context,
            title: "Success".tr(),
            message: state.message,
            statusType: DialogStatusType.success,
          );
        } else if (state is ResetPasswordFailure) {
          Navigator.of(context).pop(); // إغلاق LoadingDialog
          showAnimatedStatusDialog(
            context: context,
            title: "Error".tr(),
            message: state.error,
            statusType: DialogStatusType.error,
          );
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
