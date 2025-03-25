import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/resourses/assets_manager.dart';
import 'package:leuko_care/core/resourses/colors_manager.dart';
import 'package:leuko_care/core/resourses/fonts_manager.dart';
import 'package:leuko_care/core/resourses/sizes_util_manager.dart';
import 'package:leuko_care/core/resourses/styles_manager.dart';
import 'package:leuko_care/feature/login/logic/cubit/admin_login_cubit.dart';

class GoogleAuth extends StatelessWidget {
  const GoogleAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Divider(
                color: ColorsManager.gray,
                thickness: HeightManager.h0_5,
              ),
            ),
            SizedBox(width: WidthManager.w6),
            Text(
              'Or, login with',
              style: getRegularTextStyle(
                fontSize: FontSizeManager.s14,
                color: ColorsManager.gray,
              ),
            ),
            SizedBox(width: WidthManager.w6),
            Expanded(
              child: Divider(
                color: ColorsManager.gray,
                thickness: HeightManager.h0_5,
              ),
            ),
          ],
        ),
        SizedBox(height: HeightManager.h16),
        GestureDetector(
          child: Container(
            height: HeightManager.h50,
            decoration: BoxDecoration(
              color: ColorsManager.lighterGray,
              borderRadius: BorderRadius.circular(RadiusManager.r16),
              border: Border.all(
                color: ColorsManager.lightGray,
                width: WidthManager.w1,
              ),
            ),
          
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: WidthManager.w10,
              ),
          
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AssetsManager.google,
                    width: WidthManager.w40,
                    height: HeightManager.h40,
                  ),
                  SizedBox(width: WidthManager.w2),
                  Text(
                    'Google',
                    style: getRegularTextStyle(
                      fontSize: FontSizeManager.s14,
                      color: ColorsManager.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          onTap: (){
            context.read<AdminLoginCubit>().signInWithGoogle();
          },
        ),
      ],
    );
  }
}
