import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/assets_manager.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
import 'package:leuko_care/core/widgets/doctor_details_profile_image.dart';

class DoctorDetailsScreenForPatient extends StatelessWidget {
  final DoctorModel doctor;

  const DoctorDetailsScreenForPatient({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Doctor Details',
          style: getMediumTextStyle(
            fontSize: FontSizeManager.s20,
            color: ColorsManager.darkBlue,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: ColorsManager.darkBlue),
      ),
      floatingActionButton: ClipOval(
        child: Material(
          color: ColorsManager.primaryColor,
          child: InkWell(
            onTap: () {
              // TODO: navigate to chat or ask doctor
            },
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Image.asset(
                AssetsManager.chatIcon, // تأكد من أن المسار صحيح
                width: 28,
                height: 28,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: HeightManager.h20,
          horizontal: WidthManager.w22,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DoctorDetailsProfileImage(profileImageUrl: doctor.profileImage),
            SizedBox(height: HeightManager.h20),

            Text(
              'Dr.${doctor.name}',
              style: getMediumTextStyle(
                fontSize: FontSizeManager.s24,
                color: ColorsManager.darkBlue,
              ),
            ),
            SizedBox(height: HeightManager.h20),

            _buildInfoCard(
              icon: Icons.email,
              title: 'Email',
              value: doctor.email,
            ),
            _buildInfoCard(
              icon: Icons.phone,
              title: 'Phone',
              value: doctor.phone,
            ),
            _buildInfoCard(
              icon: Icons.work_outline,
              title: 'Experience',
              value: '${doctor.experience} years',
            ),
            _buildInfoCard(
              icon: Icons.description,
              title: 'Description',
              value: doctor.description,
              isMultiline: true,
            ),
            SizedBox(height: HeightManager.h16),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
    bool isMultiline = false,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(RadiusManager.r16),
      ),
      elevation: 2,
      margin: EdgeInsets.only(bottom: HeightManager.h16),
      child: Padding(
        padding: EdgeInsets.all(HeightManager.h16),
        child: Row(
          crossAxisAlignment:
              isMultiline ? CrossAxisAlignment.start : CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(HeightManager.h8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorsManager.primaryColor.withOpacity(0.1),
              ),
              child: Icon(
                icon,
                color: ColorsManager.primaryColor,
                size: FontSizeManager.s20,
              ),
            ),
            SizedBox(width: WidthManager.w16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: getSemiBoldTextStyle(
                      fontSize: FontSizeManager.s16,
                      color: ColorsManager.darkBlue,
                    ),
                  ),
                  SizedBox(height: HeightManager.h6),
                  Text(
                    value,
                    style: getRegularTextStyle(
                      fontSize: FontSizeManager.s14,
                      color: ColorsManager.black87,
                    ),
                    maxLines: isMultiline ? null : 1,
                    overflow: isMultiline ? TextOverflow.visible : TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
