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
            Row(
              children: [
                Icon(Icons.email, size: IconSizeManager.s16, color: ColorsManager.gray),
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
            SizedBox(height: HeightManager.h6),
            ExaminedStatusWidget(isExamined: patient.isExamined),
          ],
        ),
        leading: CircleAvatar(
          radius: RadiusManager.r40,
          backgroundColor: Colors.grey[200],
          backgroundImage: null,
          child: ClipOval(
            child: CachedNetworkImage(
              imageUrl: patient.profileImage,
              width: 60,
              height: 60,
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

}
