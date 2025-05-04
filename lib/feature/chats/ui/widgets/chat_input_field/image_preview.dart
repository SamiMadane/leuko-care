import 'dart:io';
import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';

class ImagePreview extends StatelessWidget {
  final String imagePath;
  final VoidCallback onRemove;

  const ImagePreview({
    super.key,
    required this.imagePath,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: HeightManager.h8),
      alignment: Alignment.centerLeft,
      child: Stack(
        children: [
          Image.file(
            File(imagePath),
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
                child: Icon(Icons.close, size: IconSizeManager.s16, color: ColorsManager.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
