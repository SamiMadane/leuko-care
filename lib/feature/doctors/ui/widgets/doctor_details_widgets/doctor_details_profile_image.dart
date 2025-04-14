import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:leuko_care/core/resourses/colors_manager.dart';
import 'package:leuko_care/core/resourses/sizes_util_manager.dart';
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
            color: ColorsManager.profileBackGroundColor.withValues(alpha: 0.4),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: CircleAvatar(
        radius: RadiusManager.r60,
        backgroundColor: Colors.grey[200],
        child: ClipOval(
          child: CachedNetworkImage(
            imageUrl: profileImageUrl,
            fit: BoxFit.cover,
            placeholder:
                (context, url) => Container(
                  alignment: Alignment.center,
                  child: _buildShimmerLoading(),
                ),
            errorWidget:
                (context, url, error) => Container(
                  alignment: Alignment.center,
                  color: Colors.grey[200],
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
