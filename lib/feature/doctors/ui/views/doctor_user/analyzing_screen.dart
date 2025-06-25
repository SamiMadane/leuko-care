import 'package:audioplayers/audioplayers.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/assets_manager.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:lottie/lottie.dart';

class AnalyzingScreen extends StatefulWidget {
  const AnalyzingScreen({super.key});

  @override
  State<AnalyzingScreen> createState() => _AnalyzingScreenState();
}
class _AnalyzingScreenState extends State<AnalyzingScreen> {
  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    playSound();
  }

  Future<void> playSound() async {
    await player.setReleaseMode(ReleaseMode.stop);
    await player.setSourceAsset(AssetsManager.aiSound);
    await player.resume();
  }

  @override
  void dispose() {
    player.stop();    // توقف الصوت فوراً عند الخروج من الشاشة
    player.dispose(); // تنظف الموارد
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              AssetsManager.aiLottie,
              width: 250,
              height: 250,
            ),
            SizedBox(height: 20),
            Text(
              'Analyzing blood sample...'.tr(),
              style: getMediumTextStyle(
                fontSize: FontSizeManager.s18,
                color: ColorsManager.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
