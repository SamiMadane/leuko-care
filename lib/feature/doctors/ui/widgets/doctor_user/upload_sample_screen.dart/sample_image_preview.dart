import 'dart:io';

import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';

class SampleImagePreview extends StatelessWidget {
  final File? image;

  const SampleImagePreview({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        height: HeightManager.h200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(RadiusManager.r16),
          color: Colors.grey[200],
          image: image != null
              ? DecorationImage(image: FileImage(image!), fit: BoxFit.cover)
              : null,
        ),
        child: image == null
            ? Center(
                child: Icon(
                  Icons.image_outlined,
                  size: 60,
                  color: ColorsManager.gray,
                ),
              )
            : null,
      ),
    );
  }
}
