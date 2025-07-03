import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/helpers/app_regex.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/core/widgets/app_text_form_field.dart';
import 'package:leuko_care/feature/auth/logic/cubit/auth_cubit.dart';
import 'package:leuko_care/feature/auth/ui/widgets/forget_password_dialog.dart';
import 'package:leuko_care/feature/auth/ui/widgets/password_validations.dart';

class EmailAndPassword extends StatefulWidget {
  const EmailAndPassword({super.key});

  @override
  State<EmailAndPassword> createState() => _EmailAndPasswordState();
}

class _EmailAndPasswordState extends State<EmailAndPassword> {
  bool isObscureText = true;
  bool hasLowercase = false;
  bool hasUppercase = false;
  bool hasSpecialCharacters = false;
  bool hasNumber = false;
  bool hasMinLength = false;
  bool showPasswordValidations = false; // ✅ نتحكم بالظهور هنا

  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    passwordController = context.read<AuthCubit>().passwordController;
    setupPasswordControllerListener();
  }

  void setupPasswordControllerListener() {
    passwordController.addListener(() {
      final text = passwordController.text;

      setState(() {
        showPasswordValidations = text.isNotEmpty; // ✅ شرط العرض
        hasLowercase = AppRegex.hasLowerCase(text);
        hasUppercase = AppRegex.hasUpperCase(text);
        hasSpecialCharacters = AppRegex.hasSpecialCharacter(text);
        hasNumber = AppRegex.hasNumber(text);
        hasMinLength = AppRegex.hasMinLength(text);
        if (hasLowercase &&
            hasUppercase &&
            hasSpecialCharacters &&
            hasNumber &&
            hasMinLength) {
          showPasswordValidations = false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<AuthCubit>().formKey,
      child: Column(
        children: [
          AppTextFormField(
            controller: context.read<AuthCubit>().emailController,
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
          SizedBox(height: HeightManager.h18),
          AppTextFormField(
            controller: context.read<AuthCubit>().passwordController,
            labelText: 'Password'.tr(),
            backgroundColor: ColorsManager.moreLightGray,
            isObscureText: isObscureText,
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  isObscureText = !isObscureText;
                });
              },
              child: Icon(
                isObscureText ? Icons.visibility_off : Icons.visibility,
              ),
            ),
            validator: (value) {
              if (value == null ||
                  value.isEmpty ||
                  !AppRegex.isPasswordValid(value)) {
                return 'Please enter a valid password'.tr();
              }
              return null;
            },
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder:
                      (_) => ForgotPasswordDialog(
                        prefilledEmail:
                            context.read<AuthCubit>().emailController.text, authCubit: context.read<AuthCubit>(),
                      ),
                );
              },
              child: Text(
                'forgot_password'.tr(),
                style: getBoldTextStyle(fontSize: FontSizeManager.s13, color: ColorsManager.primaryColor)
              ),
            ),
          ),

          if (showPasswordValidations) ...[
            SizedBox(height: HeightManager.h16),
            PasswordValidations(
              hasLowerCase: hasLowercase,
              hasUpperCase: hasUppercase,
              hasSpecialCharacters: hasSpecialCharacters,
              hasNumber: hasNumber,
              hasMinLength: hasMinLength,
            ),
          ],
        ],
      ),
    );
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }
}
