import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/helpers/extensions.dart';
import 'package:leuko_care/core/resourses/colors_manager.dart';
import 'package:leuko_care/core/routes/routes.dart';
import 'package:leuko_care/core/widgets/error_dialog.dart';
import 'package:leuko_care/core/widgets/loading_dialog.dart';
import 'package:leuko_care/core/widgets/success_dialog.dart';
import 'package:leuko_care/feature/admin-home/logic/cubit/admin_home_cubit.dart';
import 'package:leuko_care/feature/admin-home/logic/cubit/admin_home_state.dart';

class SignOutBlocListener extends StatelessWidget {
  const SignOutBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AdminHomeCubit, AdminHomeState>(
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

  // عرض حالة تحميل (loading)
  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => const Center(
            child: CircularProgressIndicator(color: ColorsManager.primaryColor),
          ),
    );
  }

  // عند حدوث خطأ في عملية تسجيل الخروج
  void _showErrorDialog(BuildContext context, String error) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            icon: const Icon(Icons.error, color: Colors.red, size: 32),
            content: Text(
              error,
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  'Got it',
                  style: TextStyle(color: ColorsManager.primaryColor),
                ),
              ),
            ],
          ),
    );
  }

  // الانتقال إلى شاشة اختيار المستخدم
  void _navigateToUserSelectionScreen(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.userSelectionScreen,
      (route) => false,
    );
  }
}
