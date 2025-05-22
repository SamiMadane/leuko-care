import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';

class ImageAndTitle extends StatelessWidget {
   final String imagePath;
   final String title;
   const ImageAndTitle({super.key, required this.imagePath, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: WidthManager.w10
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.asset(
              imagePath,
              height: HeightManager.h210,
              width: WidthManager.w210,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: HeightManager.h10),
          Text(
            title,
            style: getSemiBoldTextStyle(
              fontSize: FontSizeManager.s22,
              color: ColorsManager.black,
            ),
          ),
        ],
      ),
    );
  }
}
