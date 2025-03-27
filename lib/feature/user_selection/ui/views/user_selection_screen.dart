import 'package:flutter/material.dart';
import 'package:leuko_care/core/helpers/extensions.dart';
import 'package:leuko_care/core/resourses/assets_manager.dart';
import 'package:leuko_care/core/resourses/colors_manager.dart';
import 'package:leuko_care/core/resourses/fonts_manager.dart';
import 'package:leuko_care/core/resourses/sizes_util_manager.dart';
import 'package:leuko_care/core/resourses/styles_manager.dart';
import 'package:leuko_care/core/routes/routes.dart';
import 'package:leuko_care/feature/user_selection/ui/widgets/build_selection_card.dart';

class UserSelectionScreen extends StatelessWidget {
  const UserSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.moreLighterGray,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: WidthManager.w20,
          vertical: HeightManager.h40,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
                AssetsManager.blood,
                height: HeightManager.h200,
                width: WidthManager.w200,
                fit: BoxFit.contain,
              ),
              SizedBox(height: HeightManager.h30),
            Text(
              "User selection",
              style: getBoldTextStyle(
                fontSize: FontSizeManager.s22,
                color: ColorsManager.darkBlue,
              ),
            ),
            SizedBox(height: HeightManager.h40),
            buildSelectionCard(
              context,
              imagePath: AssetsManager.admin, // ضع صورة مناسبة للأدمن
              label: 'ADMIN',
              onTap: () {
                // انتقل إلى صفحة تسجيل دخول الأدمن
                context.pushNamed(Routes.loginScreen, arguments: 'admin');
              },
              imageHeight: HeightManager.h130,
              imageWidth: WidthManager.w130,
              positionedRight: WidthManager.w16,
              positionedBottom: HeightManager.hm5,
            ),
            SizedBox(height: HeightManager.h30),
            buildSelectionCard(
              context,
              imagePath: AssetsManager.doctor,
              label: "DOCTOR",
              onTap: () {
                // انتقل إلى شاشة تسجيل الدخول للطبيب
                context.pushNamed(Routes.loginScreen, arguments: 'doctor');
              },
            ),
            SizedBox(height: HeightManager.h30),
            buildSelectionCard(
              context,
              imagePath: AssetsManager.paitent,
              label: "PATIENT",
              onTap: () {
                // انتقل إلى شاشة تسجيل الدخول للمريض
                context.pushNamed(
                  Routes.loginScreen,
                  arguments: 'patient'
            );
              },
              imageHeight: HeightManager.h130,
              imageWidth: WidthManager.w130,
              positionedRight: WidthManager.wm4,
              positionedBottom: HeightManager.hm4,
            ),
          ],
        ),
      ),
    );
  }
}
