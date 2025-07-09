import 'package:easy_localization/easy_localization.dart';

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
import 'package:leuko_care/feature/auth/ui/widgets/image_section.dart';
import 'package:leuko_care/feature/auth/ui/widgets/reset_password_bloc_listener.dart';

class LoginScreen extends StatelessWidget {
  final String userType;
  const LoginScreen({super.key, required this.userType});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AuthCubit>();
    String image = cubit.userTypeData[userType]!['image'];
    String title = cubit.userTypeData[userType]!['title'];

    // ضبط لون أيقونات status bar (غامقة)
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // شفاف لو تحب
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      backgroundColor: ColorsManager.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ImageSection(imagePath: image),
              Container(
                padding: EdgeInsets.only(
                  top: HeightManager.h30,
                  right: WidthManager.w20,
                  left: WidthManager.w20,
                  bottom: HeightManager.h120,
                ),
                decoration: BoxDecoration(
                  color: ColorsManager.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.zero,
                    topRight: Radius.circular(RadiusManager.r20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: ColorsManager.black.withValues(alpha: .2),
                      blurRadius: 10,
                      offset: const Offset(3, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: getSemiBoldTextStyle(
                        fontSize: FontSizeManager.s22,
                        color: ColorsManager.black,
                      ).copyWith(
                        shadows: [
                          Shadow(
                            color: ColorsManager.black.withValues(alpha: .1),
                            blurRadius: 3,
                            offset: const Offset(2, 3),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: HeightManager.h20),
                    EmailAndPassword(),
                    SizedBox(height: HeightManager.h30),
                    AppTextButton(
                      buttonText: 'Login'.tr(),
                      textStyle: getSemiBoldTextStyle(
                        fontSize: FontSizeManager.s16,
                        color: ColorsManager.white,
                      ),
                      backgroundImage: AssetsManager.homeBluePatternImage,
                      onPressed: () {
                        validateThenDoLogin(context, userType);
                      },
                    ),
                    SizedBox(height: HeightManager.h30),
                    GoogleAuth(userType: userType),
                    const LoginBlocListener(),
                    const ResetPasswordBlocListener(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void validateThenDoLogin(BuildContext context, String userType) {
  if (context.read<AuthCubit>().formKey.currentState!.validate()) {
    context.read<AuthCubit>().login(userType);
  }
}
