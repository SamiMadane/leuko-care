import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';

class ImageSection extends StatelessWidget {
  final String imagePath;

  const ImageSection({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: HeightManager.h20,horizontal: WidthManager.w10),
      child: Container(
        height: HeightManager.h220,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(RadiusManager.r16),
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
    );
  }
}
