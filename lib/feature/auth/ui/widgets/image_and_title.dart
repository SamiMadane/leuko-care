import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';

class ImageAndTitle extends StatelessWidget {
  final String imagePath;
  final String title;

  const ImageAndTitle({
    super.key,
    required this.imagePath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Container(
            height: HeightManager.h220,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(RadiusManager.r16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 4,
                  offset: const Offset(1, 3),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(RadiusManager.r16),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
        ),
        SizedBox(height: HeightManager.h40),
        Text(
          title,
          style: getSemiBoldTextStyle(
            fontSize: FontSizeManager.s22,
            color: ColorsManager.black,
          ).copyWith(
    shadows: [
      Shadow(
        color: ColorsManager.black.withOpacity(0.1),
        blurRadius: 3,
        offset: const Offset(2, 3),
      ),
    ],
  ),
        ),
      ],
    );
  }
}
