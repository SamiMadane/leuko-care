import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:leuko_care/core/resourses/colors_manager.dart';
import 'package:leuko_care/core/resourses/sizes_util_manager.dart';
import 'package:shimmer/shimmer.dart';

class AddUpdateDoctorProfileImagePicker extends StatelessWidget {
  final String? profileImageUrl;
  final bool isEditMode;
  final VoidCallback onPickImage;
  const AddUpdateDoctorProfileImagePicker({
    super.key,
    this.profileImageUrl,
    required this.isEditMode,
    required this.onPickImage,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onPickImage,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: ColorsManager.profileBackGroundColor.withValues(
                  alpha: 0.4,
                ),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: CircleAvatar(
            radius: RadiusManager.r80,
            backgroundColor: Colors.grey[200],
            child: Stack(
              children: [
                ClipOval(
                  child: SizedBox(
                    width: WidthManager.w160,
                    height: HeightManager.h160,
                    child:
                        profileImageUrl!.startsWith('http')
                            ? CachedNetworkImage(
                              imageUrl: profileImageUrl!,
                              fit: BoxFit.cover,
                              placeholder:
                                  (context, url) =>
                                      Center(child: _buildShimmerLoading()),
                              errorWidget:
                                  (context, url, error) => Container(
                                    color: Colors.grey[200],
                                    child: const Icon(
                                      Icons.error,
                                      color: Colors.red,
                                    ),
                                  ),
                            )
                            : Image.file(
                              File(profileImageUrl!),
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                              errorBuilder:
                                  (context, error, stackTrace) => Container(
                                    color: Colors.grey[200],
                                    child: const Icon(
                                      Icons.error,
                                      color: Colors.red,
                                    ),
                                  ),
                            ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: CircleAvatar(
                    radius: RadiusManager.r20,
                    backgroundColor: ColorsManager.primaryColor,
                    child: Icon(
                      isEditMode ? Icons.edit : Icons.add,
                      color: Colors.white,
                      size: IconSizeManager.s18,
                    ),
                  ),
                ),
              ],
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
        radius: RadiusManager.r80,
        backgroundColor: Colors.white,
      ),
    );
  }
}
