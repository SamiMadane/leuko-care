import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/helpers/extensions.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/core/widgets/confirmation_dialog.dart';
import 'package:leuko_care/core/widgets/signout_bloc_listener.dart';
import 'package:leuko_care/feature/auth/logic/cubit/auth_cubit.dart';

class HomeTopBar extends StatelessWidget {
  const HomeTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AuthCubit>();
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi, Admin!'.tr(),
              style: getBoldTextStyle(
                fontSize: FontSizeManager.s20,
                color: ColorsManager.darkBlue,
              ),
            ),
            SizedBox(height: HeightManager.h6),
            Text(
              'How Are you Today?'.tr(),
              style: getSemiBoldTextStyle(
                fontSize: FontSizeManager.s12,
                color: ColorsManager.gray,
              ),
            ),
          ],
        ),
        const Spacer(),
        CircleAvatar(
          radius: RadiusManager.r24,
          backgroundColor: ColorsManager.moreLighterGray,
          child: IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder:
                    (context) => ConfirmationDialog(
                      title: 'Confirm Sign Out'.tr(),
                      message: 'Are you sure you want to sign out?'.tr(),
                      confirmText: 'SignOut'.tr(),
                      onConfirmed: () {
                        cubit.signOut(); // ثم نسجل الخروج
                        context.pop(); // أولاً نغلق الـ Dialog
                      },
                    ),
              );
            },
            icon: Icon(Icons.logout, color: ColorsManager.darkBlue,),
          ),
        ),
        SignOutBlocListener(),
      ],
    );
  }
}
