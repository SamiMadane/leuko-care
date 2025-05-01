import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/helpers/extensions.dart';
import 'package:leuko_care/core/routes/routes.dart';
import 'package:leuko_care/core/widgets/error_dialog.dart';
import 'package:leuko_care/core/widgets/loading_dialog.dart';
import 'package:leuko_care/core/widgets/success_dialog.dart';
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
            showDialog(
              context: context,
              builder:
                  (context) => SuccessDialog(
                    message: 'You have signed out successfully.',
                    onSuccess: () {
                      context.pushNamedAndRemoveUntil(
                        Routes.userSelectionScreen,
                        predicate: (route) => false,
                      );
                    },
                  ),
            );
          },
          // عند حدوث خطأ في عملية تسجيل الخروج
          signedOutStateError: (errorMessage) {
            showDialog(
              context: context,
              builder: (context) => ErrorDialog(message: errorMessage),
            );
          },
        );
      },
      child: const SizedBox.shrink(), // لا حاجة لعرض أي شيء هنا
    );
  }

}
