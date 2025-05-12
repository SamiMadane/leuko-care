import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';

class ImagePickerButtons extends StatelessWidget {
  final Future<void> Function(ImageSource) onPick;

  const ImagePickerButtons({super.key, required this.onPick});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          onPressed: () => onPick(ImageSource.gallery),
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorsManager.primaryColor,
          ),
          icon: Icon(Icons.image_outlined, color: ColorsManager.white),
          label: Text(
            "From Gallery",
            style: getMediumTextStyle(
              fontSize: FontSizeManager.s14,
              color: ColorsManager.white,
            ),
          ),
        ),
        ElevatedButton.icon(
          onPressed: () => onPick(ImageSource.camera),
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorsManager.primaryColor,
          ),
          icon: Icon(Icons.camera_alt, color: ColorsManager.white),
          label: Text(
            "Use Camera",
            style: getMediumTextStyle(
              fontSize: FontSizeManager.s14,
              color: ColorsManager.white,
            ),
          ),
        ),
      ],
    );
  }
}
