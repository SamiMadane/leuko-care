import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/assets_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';

Widget buildSelectionCard(
  BuildContext context, {
  required String imagePath,
  required String label,
  required VoidCallback onTap,
  double? imageHeight,
  double? imageWidth,
  double? positionedRight,
  double? positionedBottom,
}) {
  return SizedBox(
    height: HeightManager.h100,
    width: double.infinity,
    child: Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(RadiusManager.r30),
          child: Container(
            margin: EdgeInsets.only(bottom: HeightManager.h12), // هامش لتفادي قطع الظل
            width: double.infinity,
            height: HeightManager.h88,
            padding: EdgeInsets.symmetric(
              horizontal: WidthManager.w16,
              vertical: HeightManager.h16,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(RadiusManager.r24),
              image: DecorationImage(
                image: AssetImage(AssetsManager.homeBluePatternImage),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black87,
                  blurRadius: 8,
                  offset: const Offset(4, 3),
                ),
              ],
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                label,
                style: TextStyle(
                  fontSize: FontSizeManager.s20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          right: positionedRight ?? WidthManager.w8,
          bottom: positionedBottom ?? HeightManager.h6,
          child: Image.asset(
            imagePath,
            height: imageHeight ?? HeightManager.h120,
            width: imageWidth ?? WidthManager.w120,
            fit: BoxFit.fill,
          ),
        ),
      ],
    ),
  );
}
