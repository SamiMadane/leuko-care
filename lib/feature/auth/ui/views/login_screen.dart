import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/resources/assets_manager.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/core/widgets/app_text_button.dart';
import 'package:leuko_care/feature/auth/logic/cubit/auth_cubit.dart';
import 'package:leuko_care/feature/auth/ui/widgets/login_bloc_listener.dart';
import 'package:leuko_care/feature/auth/ui/widgets/email_and_password.dart';
import 'package:leuko_care/feature/auth/ui/widgets/google_auth.dart';
import 'package:leuko_care/feature/auth/ui/widgets/image_and_title.dart';

class LoginScreen extends StatelessWidget {
  final String userType;
  const LoginScreen({super.key, required this.userType});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AuthCubit>();

    // ضبط لون أيقونات status bar (غامقة)
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // شفاف لو تحب
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ));

    return Scaffold(
      backgroundColor: ColorsManager.white,
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
                SizedBox(height: HeightManager.h40),
                EmailAndPassword(),
                SizedBox(height: HeightManager.h50),
                AppTextButton(
                  buttonText: "Login",
                  textStyle: getSemiBoldTextStyle(
                    fontSize: FontSizeManager.s16,
                    color: ColorsManager.white,
                  ),
                  backgroundImage: AssetsManager.homeBluePatternImage,
                  onPressed: () {
                    validateThenDoLogin(context, userType);
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

void validateThenDoLogin(BuildContext context, String userType) {
  if (context.read<AuthCubit>().formKey.currentState!.validate()) {
    context.read<AuthCubit>().checkAdmin(userType);
  }
}
