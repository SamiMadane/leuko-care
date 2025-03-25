import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/helpers/app_regex.dart';
import 'package:leuko_care/core/resourses/assets_manager.dart';
import 'package:leuko_care/core/resourses/colors_manager.dart';
import 'package:leuko_care/core/resourses/fonts_manager.dart';
import 'package:leuko_care/core/resourses/sizes_util_manager.dart';
import 'package:leuko_care/core/resourses/styles_manager.dart';
import 'package:leuko_care/core/widgets/app_text_button.dart';
import 'package:leuko_care/core/widgets/app_text_form_field.dart';
import 'package:leuko_care/feature/login/logic/cubit/admin_login_cubit.dart';
import 'package:leuko_care/feature/login/ui/widgets/admin_login_bloc_listener.dart';
import 'package:leuko_care/feature/login/ui/widgets/email_and_password.dart';
import 'package:leuko_care/feature/login/ui/widgets/google_auth.dart';
import 'package:leuko_care/feature/login/ui/widgets/terms_and_conditions_text.dart';

class AdminLoginScreen extends StatelessWidget {
  const AdminLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: WidthManager.w30,
            vertical: HeightManager.h30,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome Back',
                  style: getBoldTextStyle(
                    fontSize: FontSizeManager.s24,
                    color: ColorsManager.primaryColor,
                  ),
                ),
                SizedBox(height: HeightManager.h8),
                Text(
                  'We\'re excited to have you back, can\'t wait to see what you\'ve been up to since you last logged in.',
                  style: getRegularTextStyle(
                    fontSize: FontSizeManager.s14,
                    color: ColorsManager.gray,
                  ),
                ),
                SizedBox(height: HeightManager.h36),
                Column(
                  children: [
                    EmailAndPassword(),
                    SizedBox(height: HeightManager.h40),
                    AppTextButton(
                      buttonText: "Login",
                      textStyle: getSemiBoldTextStyle(
                        fontSize: FontSizeManager.s16,
                        color: ColorsManager.white,
                      ),
                      onPressed: () {
                        validateThenDoLogin(context);
                      },
                    ),
                    SizedBox(height: HeightManager.h30),
                    GoogleAuth(),
                    SizedBox(height: HeightManager.h36),
                    const TermsAndConditionsText(),
                    const AdminLoginBlocListener(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void validateThenDoLogin(BuildContext context) {
  if (context.read<AdminLoginCubit>().formKey.currentState!.validate()) {
    context.read<AdminLoginCubit>().checkAdmin();
  }
}
