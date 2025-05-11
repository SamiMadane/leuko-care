import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';

class ImagePreviewThumbnail extends StatelessWidget {
  final String? imagePath;
  final VoidCallback onRemove;
  final Uint8List? initialDoctorImage;

  const ImagePreviewThumbnail({
    super.key,
    this.imagePath,
    required this.onRemove,
    this.initialDoctorImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: HeightManager.h8),
      alignment: Alignment.centerLeft,
      child: Stack(
        children: [
          imagePath != null
              ? Image.file(
                File(imagePath!),
                width: WidthManager.w100,
                height: HeightManager.h100,
                fit: BoxFit.cover,
              )
              : Image.memory(
                initialDoctorImage!,
                width: WidthManager.w100,
                height: HeightManager.h100,
                fit: BoxFit.cover,
              ),
          Positioned(
            top: 2,
            right: 2,
            child: GestureDetector(
              onTap: onRemove,
              child: CircleAvatar(
                radius: RadiusManager.r12,
                backgroundColor: Colors.black54,
                child: Icon(
                  Icons.close,
                  size: IconSizeManager.s16,
                  color: ColorsManager.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
