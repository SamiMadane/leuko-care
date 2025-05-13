import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:shimmer/shimmer.dart';

class ImagePreviewScreen extends StatelessWidget {
  final String imageUrl;

  const ImagePreviewScreen({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Image Preview',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: InteractiveViewer(
          maxScale: 5,
          minScale: 1,
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.contain,
            placeholder: (context, url) => _buildShimmerLoading(),
            errorWidget:
                (context, url, error) => const Icon(
                  Icons.broken_image,
                  size: 100,
                  color: Colors.white,
                ),
          ),
        ),
      ),
    );
  }

  _buildShimmerLoading() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: HeightManager.h30),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[800]!,
        highlightColor: Colors.grey[600]!,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.grey[800],
        ),
      ),
    );
  }
}
