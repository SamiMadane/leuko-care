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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [ColorsManager.primaryColor.withOpacity(0.7), ColorsManager.lightBlue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: WidthManager.w20,
              vertical: HeightManager.h20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  AssetsManager.bloodImage,
                  height: HeightManager.h200,
                  width: WidthManager.w200,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: HeightManager.h10),
                Text(
                  "User Selection",
                  style: getBoldTextStyle(
                    fontSize: FontSizeManager.s26,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: HeightManager.h10),
                Text(
                  "Please select your role to continue",
                  style: getSemiBoldTextStyle(
                    fontSize: FontSizeManager.s16,
                    color: Colors.white70,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: HeightManager.h40),
                buildSelectionCard(
                  context,
                  imagePath: AssetsManager.userSelectionAdminImage,
                  label: 'ADMIN',
                  onTap: () {
                    context.pushNamed(Routes.loginScreen, arguments: 'admin');
                  },
                ),
                SizedBox(height: HeightManager.h30),
                buildSelectionCard(
                  context,
                  imagePath: AssetsManager.doctorImage,
                  label: "DOCTOR",
                  onTap: () {
                    context.pushNamed(Routes.loginScreen, arguments: 'doctor');
                  },
                ),
                SizedBox(height: HeightManager.h30),
                buildSelectionCard(
                  context,
                  imagePath: AssetsManager.patientImage,
                  label: "PATIENT",
                  onTap: () {
                    context.pushNamed(Routes.loginScreen, arguments: 'patient');
                  },
                  positionedRight: WidthManager.w10,
                  positionedBottom: HeightManager.h3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
