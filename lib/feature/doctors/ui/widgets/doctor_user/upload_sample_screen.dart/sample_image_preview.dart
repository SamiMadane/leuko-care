import 'dart:io';
import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';

class SampleImagePreview extends StatelessWidget {
  final File? image;
  final String? networkImageUrl;

  const SampleImagePreview({
    super.key,
    required this.image,
    this.networkImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(RadiusManager.r16);

    Widget content;

    if (image != null) {
      content = ClipRRect(
        borderRadius: borderRadius,
        child: Image.file(
          image!,
          width: double.infinity,
          height: HeightManager.h200,
          fit: BoxFit.contain,
        ),
      );
    } else if (networkImageUrl != null && networkImageUrl!.isNotEmpty) {
      content = ClipRRect(
        borderRadius: borderRadius,
        child: Image.network(
          networkImageUrl!,
          width: double.infinity,
          height: HeightManager.h200,
          fit: BoxFit.contain,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return SizedBox(
              width: double.infinity,
              height: HeightManager.h200,
              child: Center(child: CircularProgressIndicator()),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return _buildPlaceholder();
          },
        ),
      );
    } else {
      content = _buildPlaceholder();
    }

    return Center(child: content);
  }

  Widget _buildPlaceholder() {
    return Container(
      width: double.infinity,
      height: HeightManager.h200,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(RadiusManager.r16),
      ),
      child: Center(
        child: Icon(
          Icons.image_outlined,
          size: 60,
          color: ColorsManager.gray,
        ),
      ),
    );
  }
}
