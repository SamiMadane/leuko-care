import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:leuko_care/core/helpers/extensions.dart';
import 'package:leuko_care/core/resources/assets_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/core/routes/routes.dart';
import 'package:lottie/lottie.dart';

class AboutUsIntroScreen extends StatefulWidget {
  const AboutUsIntroScreen({super.key});

  @override
  State<AboutUsIntroScreen> createState() => _AboutUsIntroScreenState();
}

class _AboutUsIntroScreenState extends State<AboutUsIntroScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      context.pushReplacementNamed(Routes.aboutUsScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(AssetsManager.aboutUsLottie, fit: BoxFit.contain),
          SizedBox(height: HeightManager.h20),
          Text(
            'about_us_intro_text'.tr(),
            style: getMediumTextStyle(
              fontSize: FontSizeManager.s17,
              color: Colors.grey[700]!,
            ),
          ),
        ],
      ),
    );
  }
}
