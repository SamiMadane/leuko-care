import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/core/widgets/patient_status_widgets.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';
import 'package:shimmer/shimmer.dart';

class PatientsDepartmentListViewItem extends StatelessWidget {
  final PatientModel patient;

  const PatientsDepartmentListViewItem({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: HeightManager.h16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPatientRow(),
          _buildDivider(),
        ],
      ),
    );
  }

  Widget _buildPatientRow() {
    return Row(
      children: [
        _buildPatientImage(),
        SizedBox(width: WidthManager.w16),
        _buildPatientDetails(),
      ],
    );
  }

Widget _buildPatientImage() {
  return Container(
    decoration: BoxDecoration(
      color: ColorsManager.profileBackGroundColor,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.3),
          blurRadius: 8,
          offset: Offset(1, 3),
        ),
      ],
      borderRadius: BorderRadius.circular(RadiusManager.r20),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(RadiusManager.r20),
      child: CachedNetworkImage(
        imageUrl: patient.profileImage,
        width: WidthManager.w120,
        height: HeightManager.h110,
        fit: BoxFit.cover,
        placeholder: (context, url) => _buildShimmerLoading(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    ),
  );
}

  Widget _buildPatientDetails() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            patient.name,
            style: getBoldTextStyle(
              fontSize: FontSizeManager.s18,
              color: ColorsManager.darkBlue,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: HeightManager.h5),
          _buildPatientEmail(),
          SizedBox(height: HeightManager.h8),
          ExaminedStatusWidget(isExamined: patient.isExamined),
        ],
      ),
    );
  }

  Widget _buildPatientEmail() {
    return Row(
      children: [
        Icon(
          Icons.email,
          size: IconSizeManager.s16,
          color: ColorsManager.gray,
        ),
        SizedBox(width: WidthManager.w6),
        Expanded(
          child: Text(
            patient.email,
            style: getMediumTextStyle(
              fontSize: FontSizeManager.s14,
              color: ColorsManager.gray,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildShimmerLoading() {
    return Shimmer.fromColors(
      baseColor: ColorsManager.lightGray,
      highlightColor: Colors.white,
      child: Container(
        width: WidthManager.w110,
        height: HeightManager.h120,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(RadiusManager.r12),
          color: Colors.white,
        ),
      ),
    );
  }

Widget _buildDivider() {
  return Divider(
    color: ColorsManager.lightGray.withValues(alpha: 0.6),
    thickness: 1,
    indent: WidthManager.w120 + WidthManager.w16, 
  );
}
}
