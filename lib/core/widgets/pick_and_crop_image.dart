import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';

Future<File?> pickAndCropImage(BuildContext context) async {
  final picker = ImagePicker();

  final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  if (pickedFile == null) {
    debugPrint("❌ لم يتم اختيار صورة");
    return null;
  }

  final CroppedFile? croppedFile = await ImageCropper().cropImage(
    sourcePath: pickedFile.path,
    uiSettings: [
      AndroidUiSettings(
        toolbarTitle: 'Cropper',
        toolbarColor: Colors.black,
        toolbarWidgetColor: Colors.white,
        statusBarColor: Colors.black,
        activeControlsWidgetColor: ColorsManager.primaryColor,
        lockAspectRatio: false,
        aspectRatioPresets: [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9,
          
        ],
      ),
      IOSUiSettings(
        title: 'Cropper',
        aspectRatioPresets: [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9,
        ],
      ),
      WebUiSettings(
        context: context,
        presentStyle: WebPresentStyle.dialog,
        size: const CropperSize(width: 520, height: 520),
      ),
    ],
  );

  if (croppedFile == null) {
    debugPrint("❌ تم إلغاء القص");
    return null;
  }

  debugPrint("✅ تم القص: ${croppedFile.path}");

  return File(croppedFile.path);
}
