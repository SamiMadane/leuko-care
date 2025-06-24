import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:lottie/lottie.dart';

class EmptyStateWidget extends StatelessWidget {
  final String title;
  final String message;
  final String? lottiePath;
  final bool isFullScreen;

  const EmptyStateWidget({
    super.key,
    required this.title,
    required this.message,
    this.lottiePath,
    this.isFullScreen = false,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: WidthManager.w20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: isFullScreen ? MainAxisSize.max : MainAxisSize.min,
          children: [
              Flexible(
                child: Lottie.asset(lottiePath!, fit: BoxFit.contain),
              ),
            SizedBox(height: HeightManager.h16),
            Text(
              title,
              style: getBoldTextStyle(
                fontSize:
                    isFullScreen ? FontSizeManager.s18 : FontSizeManager.s14,
                color: ColorsManager.gray,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: HeightManager.h8),
            Text(
              message,
              style: getRegularTextStyle(
                fontSize:
                    isFullScreen ? FontSizeManager.s16 : FontSizeManager.s13,
                color: ColorsManager.gray,
                height: HeightManager.h1_3,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
