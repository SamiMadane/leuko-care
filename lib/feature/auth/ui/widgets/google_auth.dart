import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/resources/assets_manager.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/feature/auth/logic/cubit/auth_cubit.dart';

class GoogleAuth extends StatelessWidget {
  final String userType;
  const GoogleAuth({super.key, required this.userType});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(child: Divider(color: Colors.grey)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: WidthManager.w8),
              child: Text(
                'Or login with'.tr(),
                style: getRegularTextStyle(
                  fontSize: FontSizeManager.s14,
                  color: ColorsManager.gray,
                ),
              ),
            ),
            const Expanded(child: Divider(color: Colors.grey)),
          ],
        ),
        SizedBox(height: HeightManager.h20),
        GestureDetector(
          onTap: () {
            context.read<AuthCubit>().signInWithGoogle(userType);
          },
          child: Container(
            height: HeightManager.h50,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: WidthManager.w16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(RadiusManager.r16),
              border: Border.all(color: ColorsManager.lightGray),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: .04),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,

              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AssetsManager.googleImage,
                    width: WidthManager.w24,
                    height: WidthManager.w24,
                  ),
                  SizedBox(width: WidthManager.w10),
                  Text(
                    'Sign in with Google'.tr(),
                    style: getMediumTextStyle(
                      fontSize: FontSizeManager.s14,
                      color: ColorsManager.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
