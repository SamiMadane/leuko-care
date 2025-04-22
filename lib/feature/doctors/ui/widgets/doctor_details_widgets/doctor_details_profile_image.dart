import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:shimmer/shimmer.dart';

class DoctorDetailsProfileImage extends StatelessWidget {
  final String profileImageUrl;

  const DoctorDetailsProfileImage({super.key, required this.profileImageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: ColorsManager.black87.withValues(alpha: 0.4),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: CircleAvatar(
        radius: RadiusManager.r60,
        backgroundColor: ColorsManager.profileBackGroundColor,
        child: ClipOval(
          child:
              profileImageUrl.startsWith('http')
                  ? CachedNetworkImage(
                    width: HeightManager.h120,
                    height: WidthManager.w120,
                    imageUrl: profileImageUrl,
                    fit: BoxFit.cover,
                    placeholder:
                        (context, url) => Center(child: _buildShimmerLoading()),
                    errorWidget:
                        (context, url, error) => Container(
                          color: ColorsManager.profileBackGroundColor,
                          child: const Icon(Icons.error, color: Colors.red),
                        ),
                  )
                  : Image.file(
                    File(profileImageUrl),
                    fit: BoxFit.cover,
                    width: HeightManager.h120,
                    height: WidthManager.w120,
                    errorBuilder:
                        (context, error, stackTrace) => Container(
                          color: ColorsManager.profileBackGroundColor,
                          child: const Icon(Icons.error, color: Colors.red),
                        ),
                  ),
        ),
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return Shimmer.fromColors(
      baseColor: ColorsManager.lightGray,
      highlightColor: Colors.white,
      child: CircleAvatar(
        radius: RadiusManager.r60,
        backgroundColor: Colors.white,
      ),
    );
  }
}
