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
  final String doctorId;
  final String doctorName;
  const PatientListTile({
    super.key,
    required this.patient,
    required this.doctorId,
    required this.doctorName,
  });

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
            _examinedStatus(patient.isExamined),
            SizedBox(height: HeightManager.h4),
          ],
        ),
        leading: CircleAvatar(
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
            arguments: {
              'patientId': patient.id,
              'doctorId': doctorId,
              'doctorName': doctorName,
            },
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
  Widget _examinedStatus(bool isExamined) {
  return Row(
    children: [
      Icon(
        isExamined ? Icons.check_circle : Icons.cancel,
        color: isExamined ? Colors.green : Colors.red,
      ),
      SizedBox(width: 8),
      Text(
        isExamined ? 'Patient has been examined' : 'Not examined yet',
        style: TextStyle(
          color: isExamined ? Colors.green[800] : Colors.red[800],
          fontWeight: FontWeight.w600,
          fontSize: FontSizeManager.s14,
        ),
      ),
    ],
  );
}
}
