import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/helpers/extensions.dart';
import 'package:leuko_care/core/routes/routes.dart';
import 'package:leuko_care/core/widgets/custom_status_dialog.dart';
import 'package:leuko_care/core/widgets/loading_dialog.dart';
import 'package:leuko_care/feature/auth/logic/cubit/auth_cubit.dart';
import 'package:leuko_care/feature/auth/logic/cubit/auth_state.dart';

class SignOutBlocListener extends StatelessWidget {
  const SignOutBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen:
          (previous, current) =>
              current is SignedOutStateLoading ||
              current is SignedOutStateSuccess ||
              current is SignedOutStateError,
      listener: (context, state) {
        state.whenOrNull(
          // عندما تكون الحالة Loading
          signedOutStateLoading: () {
            showDialog(context: context, builder: (context) => LoadingDialog());
          },
          // عندما يكون تسجيل الخروج ناجحًا
          signedOutStateSuccess: () {
            showAnimatedStatusDialog(
              context: context,
              title: 'Success'.tr(),
              message: 'You have signed out successfully'.tr(),
              statusType: DialogStatusType.success,
              onConfirm: () {
                context.pushNamedAndRemoveUntil(
                  Routes.userSelectionScreen,
                  predicate: (route) => false,
                );
              },
            );
          },

          signedOutStateError: (errorMessage) {
            showAnimatedStatusDialog(
              context: context,
              title: 'Error'.tr(),
              message: errorMessage,
              statusType: DialogStatusType.error,
              onConfirm: () => Navigator.of(context).pop(),
            );
          },
        );
      },
      child: const SizedBox.shrink(), // لا حاجة لعرض أي شيء هنا
    );
  }
}
