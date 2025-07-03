import 'package:audioplayers/audioplayers.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:lottie/lottie.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/core/resources/assets_manager.dart';

enum DialogStatusType { success, error, warning }

class CustomStatusDialog extends StatelessWidget {
  final String? title;
  final String message;
  final DialogStatusType statusType;
  final String? buttonText;
  final VoidCallback? onConfirm;

  const CustomStatusDialog({
    super.key,
    this.title,
    required this.message,
    required this.statusType,
    this.buttonText,
    this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    // تحديد مسار ملف Lottie حسب نوع الحالة
    final String animationPath = switch (statusType) {
      DialogStatusType.success => AssetsManager.successLottie,
      DialogStatusType.error => AssetsManager.errorLottie,
      DialogStatusType.warning =>
        AssetsManager.warningLottie, // <-- أضف هذا الملف
    };

    // تحديد اللون الرئيسي حسب الحالة
    final Color mainColor = switch (statusType) {
      DialogStatusType.success => ColorsManager.green,
      DialogStatusType.error => ColorsManager.red,
      DialogStatusType.warning => ColorsManager.warninigColor,
    };

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(RadiusManager.r20),
      ),
      elevation: 16,
      backgroundColor: Colors.white,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: HeightManager.h64,
              left: WidthManager.w16,
              right: WidthManager.w16,
              bottom: HeightManager.h16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (title != null) ...[
                  Text(
                    title!,
                    textAlign: TextAlign.center,

                    style: getSemiBoldTextStyle(
                      fontSize: FontSizeManager.s18,
                      color: mainColor,
                    ),
                  ),
                  SizedBox(height: HeightManager.h8),
                ],
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: getMediumTextStyle(
                    fontSize: FontSizeManager.s14,
                    color: ColorsManager.darkBlue,
                    height: HeightManager.h1_1,
                  ),
                ),
                SizedBox(height: HeightManager.h20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: WidthManager.w24,
                      vertical: HeightManager.h12,
                    ),
                  ),
                  onPressed: onConfirm,
                  child: Text(
                    buttonText ?? 'Got it'.tr(),
                    style: getSemiBoldTextStyle(
                      fontSize: FontSizeManager.s14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // رأس اللوتي
          Positioned(
            top: -50,
            child: Container(
              width: WidthManager.w90,
              height: HeightManager.h90,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: .9),
                boxShadow: [
                  BoxShadow(
                    color: mainColor.withValues(alpha: .6),
                    blurRadius: 6,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: WidthManager.w12,
                  vertical: HeightManager.h12,
                ),
                child: Lottie.asset(animationPath, repeat: true),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void showAnimatedStatusDialog({
  required BuildContext context,
  required DialogStatusType statusType,
  required String message,
  String? title,
  String? buttonText,
  VoidCallback? onConfirm,
}) async {
    final player = AudioPlayer();
  final String sound = switch (statusType) {
    DialogStatusType.success => AssetsManager.successSound,
    DialogStatusType.error => AssetsManager.errorSound,
    DialogStatusType.warning => AssetsManager.errorSound,
  };

  await player.setReleaseMode(ReleaseMode.stop);
  await player.setSourceAsset(sound);
  await player.resume();
    await Future.delayed(const Duration(milliseconds: 500));

  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'StatusDialog',
    barrierColor: Colors.black.withValues(alpha: .5),
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (_, __, ___) => const SizedBox.shrink(),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      final curved = Curves.easeInOut.transform(animation.value);
      return Transform.scale(
        scale: curved,
        child: Opacity(
          opacity: animation.value,
          child: CustomStatusDialog(
            title: title,
            message: message,
            statusType: statusType,
            buttonText: buttonText,
            onConfirm: onConfirm ?? () => Navigator.of(context).pop(),
          ),
        ),
      );
    },
  );
}
