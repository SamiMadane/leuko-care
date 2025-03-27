import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/helpers/extensions.dart';
import 'package:leuko_care/core/resourses/colors_manager.dart';
import 'package:leuko_care/core/resourses/fonts_manager.dart';
import 'package:leuko_care/core/resourses/styles_manager.dart';
import 'package:leuko_care/core/routes/routes.dart';
import 'package:leuko_care/feature/login/logic/cubit/login_cubit.dart';
import 'package:leuko_care/feature/login/logic/cubit/login_state.dart';

class LoginBlocListener extends StatelessWidget {
  const LoginBlocListener({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
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
          loginSuccess: (user) {
            context.pop();
            context.pushNamed(Routes.adminHomeScreen);
          },
          loginError: (error) {
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
