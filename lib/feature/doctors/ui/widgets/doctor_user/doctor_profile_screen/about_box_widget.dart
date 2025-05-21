import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
class AboutBoxWidget extends StatelessWidget {
  final String description;

  const AboutBoxWidget({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: WidthManager.w20),
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: HeightManager.h12),
        padding: EdgeInsets.all(HeightManager.h16),
        decoration: BoxDecoration(
          color: ColorsManager.moreLighterGray, // خلفية خفيفة بدون بوردير
          borderRadius: BorderRadius.circular(RadiusManager.r16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.info_outline, color: ColorsManager.primaryColor, size: FontSizeManager.s18),
                SizedBox(width: WidthManager.w8),
                Text(
                  'Description',
                  style: getMediumTextStyle(
                    fontSize: FontSizeManager.s14,
                    color: ColorsManager.primaryColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: HeightManager.h12),
            Text(
              description,
              style: getRegularTextStyle(
                fontSize: FontSizeManager.s14,
                color: ColorsManager.darkBlue,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
