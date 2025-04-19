import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:leuko_care/core/resourses/colors_manager.dart';
import 'package:leuko_care/core/resourses/fonts_manager.dart';
import 'package:leuko_care/core/resourses/sizes_util_manager.dart';
import 'package:leuko_care/core/resourses/styles_manager.dart';
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
      child: Row(
        children: [
          ClipRRect(
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
          SizedBox(width: WidthManager.w16),
          Expanded(
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
                Row(
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
                ),
                SizedBox(height: HeightManager.h8),
                ExaminedStatusWidget(isExamined: patient.isExamined),
              ],
            ),
          ),
        ],
      ),
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
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.white,
        ),
      ),
    );
  }
}
