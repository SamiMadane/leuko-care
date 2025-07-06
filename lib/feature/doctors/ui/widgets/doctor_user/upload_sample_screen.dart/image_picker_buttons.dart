import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
class ImagePickerButtons extends StatelessWidget {
  final Future<void> Function(ImageSource) onPick;

  const ImagePickerButtons({super.key, required this.onPick});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ElevatedButton.icon(
              onPressed: () => onPick(ImageSource.gallery),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsManager.primaryColor,
                padding: EdgeInsets.symmetric(vertical: HeightManager.h14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(RadiusManager.r16),
                ),
              ),
              icon: Icon(Icons.image_outlined, color: ColorsManager.white),
              label: Text(
                'From Gallery'.tr(),
                style: getMediumTextStyle(
                  fontSize: FontSizeManager.s15,
                  color: ColorsManager.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ElevatedButton.icon(
              onPressed: () => onPick(ImageSource.camera),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsManager.primaryColor,
                padding:  EdgeInsets.symmetric(vertical: HeightManager.h14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              icon: Icon(Icons.camera_alt, color: ColorsManager.white),
              label: Text(
                'Use Camera'.tr(),
                style: getMediumTextStyle(
                  fontSize: FontSizeManager.s15,
                  color: ColorsManager.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
