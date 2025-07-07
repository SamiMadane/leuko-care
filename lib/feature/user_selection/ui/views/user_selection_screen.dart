import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:leuko_care/core/helpers/extensions.dart';
import 'package:leuko_care/core/resources/assets_manager.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/core/routes/routes.dart';
import 'package:leuko_care/feature/user_selection/ui/widgets/build_selection_card.dart';
import 'package:leuko_care/feature/user_selection/ui/widgets/language_switcher.dart';

class UserSelectionScreen extends StatelessWidget {
  const UserSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.white,
      body: MediaQuery.removePadding(
        context: context,
        removeBottom: true,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              LanguageSwitcher(),
              Image.asset(
                AssetsManager.logoImage,
                height: HeightManager.h200,
                width: WidthManager.w200,
                fit: BoxFit.contain,
              ),
              SizedBox(height: HeightManager.h10),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                    top: HeightManager.h30,
                    right: WidthManager.w20,
                    left: WidthManager.w20,
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
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          'User Selection'.tr(),
                          style: getBoldTextStyle(
                            fontSize: FontSizeManager.s26,
                            color: ColorsManager.darkBlue,
                          ),
                        ),
                        SizedBox(height: HeightManager.h10),
                        Text(
                          'Please select your role to continue'.tr(),
                          style: getSemiBoldTextStyle(
                            fontSize: FontSizeManager.s16,
                            color: ColorsManager.darkBlue,
                          ),
                        ),
                        SizedBox(height: HeightManager.h40),
                        buildSelectionCard(
                          context,
                          imagePath: AssetsManager.userSelectionAdminImage,
                          label: 'ADMIN'.tr(),
                          onTap: () {
                            context.pushNamed(
                              Routes.loginScreen,
                              arguments: 'admin',
                            );
                          },
                        ),
                        SizedBox(height: HeightManager.h30),
                        buildSelectionCard(
                          context,
                          imagePath: AssetsManager.doctorImage,
                          label: 'DOCTOR'.tr(),
                          onTap: () {
                            context.pushNamed(
                              Routes.loginScreen,
                              arguments: 'doctor',
                            );
                          },
                        ),
                        SizedBox(height: HeightManager.h30),
                        buildSelectionCard(
                          context,
                          imagePath: AssetsManager.patientImage,
                          label: 'PATIENT'.tr(),
                          onTap: () {
                            context.pushNamed(
                              Routes.loginScreen,
                              arguments: 'patient',
                            );
                          },
                          positionedRight: WidthManager.w10,
                          positionedBottom: HeightManager.h4,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}