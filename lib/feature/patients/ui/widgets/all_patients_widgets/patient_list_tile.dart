import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:leuko_care/core/helpers/extensions.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/core/routes/routes.dart';
import 'package:leuko_care/core/widgets/patient_status_widgets.dart';
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
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
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: HeightManager.h18,
            horizontal: WidthManager.w18,
          ),
          child: Row(
            children: [
              _PatientImage(profileImage: patient.profileImage),
              SizedBox(width: WidthManager.w16),
              _PatientInfo(patient: patient),
            ],
          ),
        ),
      ),
    );
  }
}

class _PatientImage extends StatelessWidget {
  final String profileImage;

  const _PatientImage({
    required this.profileImage,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: RadiusManager.r35,
      backgroundColor: Colors.grey[200],
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: profileImage,
          width: WidthManager.w70,
          height: HeightManager.h70,
          fit: BoxFit.cover,
          placeholder: (context, url) => _buildShimmerLoading(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return Shimmer.fromColors(
      baseColor: ColorsManager.lightGray,
      highlightColor: Colors.white,
      child: CircleAvatar(
        radius: RadiusManager.r35,
        backgroundColor: Colors.white,
      ),
    );
  }
}

class _PatientInfo extends StatelessWidget {
  final PatientModel patient;

  const _PatientInfo({
    required this.patient,
  });

  @override
  Widget build(BuildContext context) {
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
          ),
          SizedBox(height: HeightManager.h6),
          _EmailRow(email: patient.email),
          SizedBox(height: HeightManager.h6),
          ExaminedStatusWidget(isExamined: patient.isExamined),
        ],
      ),
    );
  }
}

class _EmailRow extends StatelessWidget {
  final String email;

  const _EmailRow({
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
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
            email,
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
}
