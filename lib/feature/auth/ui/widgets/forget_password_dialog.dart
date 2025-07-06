import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:leuko_care/core/helpers/app_regex.dart';
import 'package:leuko_care/core/resources/assets_manager.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/core/widgets/app_text_form_field.dart';
import 'package:leuko_care/feature/auth/logic/cubit/auth_cubit.dart';

class ForgotPasswordDialog extends StatefulWidget {
  final String? prefilledEmail;
  final AuthCubit authCubit;

  const ForgotPasswordDialog({
    super.key,
    this.prefilledEmail,
    required this.authCubit,
  });

  @override
  State<ForgotPasswordDialog> createState() => _ForgotPasswordDialogState();
}

class _ForgotPasswordDialogState extends State<ForgotPasswordDialog> {
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailController.text = widget.prefilledEmail ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: HeightManager.h64,
              left: WidthManager.w16,
              right: WidthManager.w16,
              bottom: HeightManager.h16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'forgot_password'.tr(),
                  style: getSemiBoldTextStyle(
                    fontSize: FontSizeManager.s18,
                    color: ColorsManager.primaryColor,
                  ),
                ),
                SizedBox(height: HeightManager.h12),
                Text(
                  'enter_email_to_reset'.tr(),
                  style: getRegularTextStyle(
                    fontSize: FontSizeManager.s14,
                    color: ColorsManager.darkBlue,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: HeightManager.h20),
                Form(
                  key: formKey,
                  child: AppTextFormField(
                    controller: emailController,
                    labelText: 'Email'.tr(),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !AppRegex.isEmailValid(value)) {
                        return 'Please enter a valid email'.tr();
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: HeightManager.h24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        'Cancel'.tr(),
                        style: getSemiBoldTextStyle(
                          fontSize: FontSizeManager.s14,
                          color: ColorsManager.gray,
                        ),
                      ),
                    ),
                    SizedBox(width: WidthManager.w8),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          widget.authCubit
                              .resetPassword(emailController.text);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsManager.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: WidthManager.w24,
                          vertical: HeightManager.h12,
                        ),
                      ),
                      child: Text(
                        'send_link'.tr(),
                        style: getSemiBoldTextStyle(
                          fontSize: FontSizeManager.s14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Positioned(
            top: -HeightManager.h50,
            child: Container(
              width: WidthManager.w100,
              height: HeightManager.h100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: ColorsManager.primaryColor.withValues(alpha: .3),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Lottie.asset(
                AssetsManager.forgetPasswordLottie, // ضع اللوتي المناسب هنا
                repeat: true,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
