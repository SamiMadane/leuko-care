import 'dart:io';

import 'package:flutter/material.dart';
import 'package:leuko_care/core/resourses/colors_manager.dart';
import 'package:leuko_care/core/resourses/sizes_util_manager.dart';

class AddUpdatePatientProfileImagePicker extends StatelessWidget {
  final String? profileImageUrl;
  final bool isEditMode;
  final VoidCallback onPickImage;
  const AddUpdatePatientProfileImagePicker({
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
                color: ColorsManager.profileBackGroundColor.withValues(alpha: 0.4),
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: CircleAvatar(
            radius: RadiusManager.r80,
            backgroundImage: profileImageUrl!.startsWith('http')
                ? NetworkImage(profileImageUrl!)
                : FileImage(File(profileImageUrl!)),
            child: Align(
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
          ),
        ),
      ),
    );
  }
}
