import 'package:flutter/material.dart';
import 'package:leuko_care/core/helpers/extensions.dart';
import 'package:leuko_care/core/resources/assets_manager.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/core/routes/routes.dart';
import 'package:leuko_care/feature/user_selection/ui/widgets/build_selection_card.dart';

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
              SizedBox(height: HeightManager.h20),
              Image.asset(
                AssetsManager.logoImage,
                height: HeightManager.h180,
                width: WidthManager.w180,
                fit: BoxFit.contain,
              ),
              SizedBox(height: HeightManager.h20),
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
                        color: ColorsManager.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(3, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "User Selection",
                        style: getBoldTextStyle(
                          fontSize: FontSizeManager.s26,
                          color: ColorsManager.black,
                        ),
                      ),
                      SizedBox(height: HeightManager.h10),
                      Text(
                        "Please select your role to continue",
                        style: getSemiBoldTextStyle(
                          fontSize: FontSizeManager.s16,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: HeightManager.h50),
                      buildSelectionCard(
                        context,
                        imagePath: AssetsManager.userSelectionAdminImage,
                        label: 'ADMIN',
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
                        label: "DOCTOR",
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
                        label: "PATIENT",
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
            ],
          ),
        ),
      ),
    );
  }
}
