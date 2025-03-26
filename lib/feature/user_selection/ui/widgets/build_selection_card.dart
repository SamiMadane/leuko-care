import 'package:flutter/material.dart';
import 'package:leuko_care/core/resourses/fonts_manager.dart';
import 'package:leuko_care/core/resourses/sizes_util_manager.dart';

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
            width: double.infinity,
            height: HeightManager.h88,
            padding: EdgeInsets.symmetric(
              horizontal: WidthManager.w16,
              vertical: HeightManager.h16,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(RadiusManager.r30),
              gradient: const LinearGradient(
                colors: [Colors.cyanAccent, Colors.lightBlueAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                label,
                style: TextStyle(
                  fontSize: FontSizeManager.s20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          right: positionedRight ?? WidthManager.w8, // لإخراج جزء من الصورة خارج الزر
          bottom: positionedBottom ?? HeightManager.h6,
          child: Image.asset(
            imagePath,
            height: imageHeight ?? HeightManager.h120, // تكبير الصورة
            width: imageWidth ?? WidthManager.w120,
            fit: BoxFit.fill,
          ),
        ),
      ],
    ),
  );
}
