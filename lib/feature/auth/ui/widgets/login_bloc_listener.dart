import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/helpers/extensions.dart';
import 'package:leuko_care/core/routes/routes.dart';
import 'package:leuko_care/core/widgets/custom_status_dialog.dart';
import 'package:leuko_care/core/widgets/loading_dialog.dart';
import 'package:leuko_care/feature/auth/logic/cubit/auth_cubit.dart';
import 'package:leuko_care/feature/auth/logic/cubit/auth_state.dart';

class LoginBlocListener extends StatelessWidget {
  const LoginBlocListener({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen:
          (previous, current) =>
              current is LoginLoading ||
              current is LoginSuccess ||
              current is LoginError,
      listener: (context, state) {
        state.whenOrNull(
          loginLoading: () {
            setUpLoadingState(context);
          },
          loginSuccess: (user,userType) {
            context.pop();
             if (userType == 'admin') {
              context.pushNamedAndRemoveUntil(Routes.adminHomeScreen,predicate: (route) => false,);
            } else if (userType == 'doctor') {
              context.pushNamedAndRemoveUntil(Routes.doctorScreen,predicate: (route) => false,);
            } else if (userType == 'patient') {
              context.pushNamedAndRemoveUntil(Routes.patientScreen,predicate: (route) => false,);
            }
          },
          loginError: (error) {
            context.pop();
            setUpErrorState(context, error);
          },
        );
      },
      child:
          const SizedBox.shrink(), // Empty widget as BlocListener is for listening.
    );
  }

  setUpLoadingState(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => LoadingDialog(),
    );
  }
void setUpErrorState(BuildContext context, String error) {
  final isWarning = error == 'Please verify your email. A verification link has been sent.'.tr() ||
      error == 'Please verify your email. A verification link has already been sent.'.tr();

  final isNetworkError = error == 'error_network_request_failed'.tr();

  showAnimatedStatusDialog(
    context: context,
    title: isWarning
        ? 'Warning'.tr()
        : isNetworkError
            ? 'No Internet'.tr()
            : 'Error'.tr(),
    message: error,
    statusType: isWarning ? DialogStatusType.warning : DialogStatusType.error,
    onConfirm: () => Navigator.of(context).pop(),
  );
}

}
