import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:leuko_care/core/resources/assets_manager.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';

enum ConfirmationType { delete, logout, generic }

class CustomConfirmationDialog extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onConfirmed;
  final ConfirmationType type;
  final String? confirmText;
  final String? cancelText;

  const CustomConfirmationDialog({
    super.key,
    required this.title,
    required this.message,
    required this.onConfirmed,
    this.type = ConfirmationType.generic,
    this.confirmText,
    this.cancelText,
  });

  @override
  Widget build(BuildContext context) {
    final (animationPath, mainColor) = switch (type) {
      ConfirmationType.delete => (AssetsManager.deleteLottie, ColorsManager.red),
      ConfirmationType.logout => (AssetsManager.logoutLottie, ColorsManager.primaryColor),
      ConfirmationType.generic => (AssetsManager.warningLottie, ColorsManager.warninigColor),
    };

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(RadiusManager.r20)),
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
                Text(
                  title,
                  style: getSemiBoldTextStyle(
                    fontSize: FontSizeManager.s18,
                    color: mainColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: HeightManager.h8),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: getMediumTextStyle(
                    fontSize: FontSizeManager.s15,
                    color: ColorsManager.darkBlue,
                    height: HeightManager.h1_1,
                  ),
                ),
                SizedBox(height: HeightManager.h20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        cancelText ?? 'Cancel'.tr(),
                        style: getSemiBoldTextStyle(
                          fontSize: FontSizeManager.s14,
                          color: ColorsManager.gray,
                        ),
                      ),
                    ),
                    SizedBox(width: WidthManager.w8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: mainColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: EdgeInsets.symmetric(
                          horizontal: WidthManager.w24,
                          vertical: HeightManager.h12,
                        ),
                      ),
                      onPressed: onConfirmed,
                      child: Text(
                        confirmText ?? 'Confirm'.tr(),
                        style: getSemiBoldTextStyle(
                          fontSize: FontSizeManager.s14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: -HeightManager.h50,
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
                padding: EdgeInsets.symmetric(horizontal: WidthManager.w12, vertical: HeightManager.h12),
                child: Lottie.asset(animationPath, repeat: true),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
void showAnimatedConfirmationDialog({
  required BuildContext context,
  required String title,
  required String message,
  required VoidCallback onConfirmed,
  ConfirmationType type = ConfirmationType.generic,
  String? confirmText,
  String? cancelText,
}) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'ConfirmationDialog',
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (_, __, ___) => const SizedBox.shrink(),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      final curved = Curves.easeInOut.transform(animation.value);
      return Transform.scale(
        scale: curved,
        child: Opacity(
          opacity: animation.value,
          child: CustomConfirmationDialog(
            title: title,
            message: message,
            onConfirmed: onConfirmed,
            type: type,
            confirmText: confirmText,
            cancelText: cancelText,
          ),
        ),
      );
    },
  );
}
