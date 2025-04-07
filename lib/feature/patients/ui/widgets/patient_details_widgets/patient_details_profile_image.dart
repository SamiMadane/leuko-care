import 'package:flutter/material.dart';
import 'package:leuko_care/core/resourses/colors_manager.dart';
import 'package:leuko_care/core/resourses/sizes_util_manager.dart';

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
        backgroundImage: NetworkImage(
          profileImageUrl
        ),
        radius: RadiusManager.r60,
      ),
    );
  }
}