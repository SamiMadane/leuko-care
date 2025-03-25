import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/helpers/extensions.dart';
import 'package:leuko_care/core/resourses/colors_manager.dart';
import 'package:leuko_care/core/resourses/fonts_manager.dart';
import 'package:leuko_care/core/resourses/styles_manager.dart';
import 'package:leuko_care/core/routes/routes.dart';
import 'package:leuko_care/feature/login/logic/cubit/admin_login_cubit.dart';
import 'package:leuko_care/feature/login/logic/cubit/admin_login_state.dart';

class AdminLoginBlocListener extends StatelessWidget {
  const AdminLoginBlocListener({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocListener<AdminLoginCubit, AdminLoginState>(
      listenWhen:
          (previous, current) =>
              current is AdminLoginLoading ||
              current is AdminLoginSuccess ||
              current is AdminLoginError,
      listener: (context, state) {
        state.whenOrNull(
          adminLoginLoading: () {
            setUpLoadingState(context);
          },
          adminLoginSuccess: (user) {
            context.pop();
            context.pushNamed(Routes.adminHomeScreen);
          },
          adminLoginError: (error) {
            context.pop();
            print ('===================== $error');
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
          (context) => const Center(
            child: CircularProgressIndicator(color: ColorsManager.primaryColor),
          ),
    );
  }

  setUpErrorState(BuildContext context, String error) {
    print ('========================= $error');
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            icon: error == "Please verify your email. A verification link has been sent." || error == "Please verify your email. A verification link has already been sent." ? Icon(Icons.warning, color: Colors.amber, size: 32) : Icon(Icons.error, color: Colors.red, size: 32),
            content: Text(
              error,
              style: getMediumTextStyle(
                fontSize: FontSizeManager.s15,
                color: ColorsManager.darkBlue,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => context.pop(),
                child: Text(
                  'Got it',
                  style: getSemiBoldTextStyle(
                    fontSize: FontSizeManager.s14,
                    color: ColorsManager.primaryColor,
                  ),
                ),
              ),
            ],
          ),
    );
  }
}
