import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/resourses/colors_manager.dart';
import 'package:leuko_care/core/resourses/fonts_manager.dart';
import 'package:leuko_care/core/resourses/sizes_util_manager.dart';
import 'package:leuko_care/core/resourses/styles_manager.dart';
import 'package:leuko_care/core/widgets/app_text_button.dart';
import 'package:leuko_care/feature/login/logic/cubit/login_cubit.dart';
import 'package:leuko_care/feature/login/ui/widgets/login_bloc_listener.dart';
import 'package:leuko_care/feature/login/ui/widgets/email_and_password.dart';
import 'package:leuko_care/feature/login/ui/widgets/google_auth.dart';
import 'package:leuko_care/feature/login/ui/widgets/image_and_title.dart';

class LoginScreen extends StatelessWidget {
  final String userType;
  const LoginScreen({super.key, required this.userType});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<LoginCubit>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: WidthManager.w20,
            vertical: HeightManager.h20,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
               ImageAndTitle(
                  imagePath: cubit.userTypeData[userType]!['image'],
                  title: cubit.userTypeData[userType]!['title'],
                ),
                SizedBox(height: HeightManager.h30),
                EmailAndPassword(),
                SizedBox(height: HeightManager.h40),
                AppTextButton(
                  buttonText: "Login",
                  textStyle: getSemiBoldTextStyle(
                    fontSize: FontSizeManager.s16,
                    color: ColorsManager.white,
                  ),
                  onPressed: () {
                    validateThenDoLogin(context,userType);
                  },
                ),
                SizedBox(height: HeightManager.h40),
                GoogleAuth(userType: userType),
                SizedBox(height: HeightManager.h36),
                const LoginBlocListener(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void validateThenDoLogin(BuildContext context,String userType) {
  if (context.read<LoginCubit>().formKey.currentState!.validate()) {
    context.read<LoginCubit>().checkAdmin(userType);
  }
}
