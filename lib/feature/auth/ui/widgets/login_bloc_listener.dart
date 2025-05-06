import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/helpers/extensions.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/core/routes/routes.dart';
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
              context.pushReplacementNamed(Routes.adminHomeScreen);
            } else if (userType == 'doctor') {
              context.pushReplacementNamed(Routes.doctorScreen);
            } else if (userType == 'patient') {
              context.pushReplacementNamed(Routes.patientScreen);
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

  setUpErrorState(BuildContext context, String error) {
    print('error is $error');
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
