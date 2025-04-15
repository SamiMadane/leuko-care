import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:leuko_care/core/helpers/extensions.dart';
import 'package:leuko_care/core/resourses/colors_manager.dart';
import 'package:leuko_care/core/resourses/fonts_manager.dart';
import 'package:leuko_care/core/resourses/sizes_util_manager.dart';
import 'package:leuko_care/core/resourses/styles_manager.dart';
import 'package:leuko_care/core/routes/routes.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';
import 'package:shimmer/shimmer.dart';

class PatientListTile extends StatelessWidget {
  final PatientModel patient;
  const PatientListTile({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    return Card(
          margin: EdgeInsets.symmetric(
            vertical: HeightManager.h8,
            horizontal: WidthManager.w16,
          ),
          elevation: 4,
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(
              vertical: HeightManager.h18,
              horizontal: WidthManager.w18,
            ),
            title: Text(
              patient.name,
              style: getBoldTextStyle(
                fontSize: FontSizeManager.s18,
                color: ColorsManager.darkBlue,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: HeightManager.h6),
                Text(patient.email),
                SizedBox(height: HeightManager.h4),
              ],
            ),
            leading:  CircleAvatar(
          radius: RadiusManager.r32,
          backgroundColor: Colors.grey[200],
          backgroundImage: null,
          child: ClipOval(
            child: CachedNetworkImage(
              imageUrl: patient.profileImage,
              fit: BoxFit.cover,
              placeholder: (context, url) => _buildShimmerLoading(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
            onTap: () {
              context.pushNamed(
                Routes.patientDetailsScreen,
                arguments: patient,
              );
            },
          ),
        );
  }


  Widget _buildShimmerLoading() {
    return Shimmer.fromColors(
      baseColor: ColorsManager.lightGray,
      highlightColor: Colors.white,
      child: CircleAvatar(
        radius: RadiusManager.r28,
        backgroundColor: Colors.white,
      ),
    );
  }
}
