import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/helpers/extensions.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/core/widgets/confirmation_dialog.dart';
import 'package:leuko_care/core/widgets/signout_bloc_builder.dart';
import 'package:leuko_care/feature/login/logic/cubit/login_cubit.dart';

class HomeTopBar extends StatelessWidget {
  const HomeTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<LoginCubit>();
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi, Admin!',
              style: getBoldTextStyle(
                fontSize: FontSizeManager.s18,
                color: ColorsManager.darkBlue,
              ),
            ),
            SizedBox(height: HeightManager.h6),
            Text(
              'How Are you Today?',
              style: getRegularTextStyle(
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
                      title: 'Confirm Sign Out',
                      message: 'Are you sure you want to sign out?',
                      onConfirmed: () {
                        cubit.signOut(); // ثم نسجل الخروج
                        context.pop(); // أولاً نغلق الـ Dialog
                      },
                    ),
              );
            },
            icon: Icon(Icons.exit_to_app),
          ),
        ),
        SignOutBlocListener(),
      ],
    );
  }
}
