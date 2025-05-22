import 'package:flutter/material.dart';
import 'package:leuko_care/core/helpers/extensions.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/core/routes/routes.dart';
import 'package:leuko_care/core/widgets/profile_image_widget.dart';
import 'package:leuko_care/core/widgets/section_title.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
import 'package:leuko_care/feature/doctors/ui/widgets/doctor_user/doctor_profile_screen/about_box_widget.dart';
import 'package:leuko_care/core/widgets/profile_info_row.dart';

class DoctorProfileScreen extends StatelessWidget {
  final DoctorModel doctor;

  const DoctorProfileScreen({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.white,
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(width: WidthManager.w8),
            Text(
              'My Profile',
              style: getMediumTextStyle(
                fontSize: FontSizeManager.s20,
                color: ColorsManager.darkBlue,
              ),
            ),
          ],
        ),
        backgroundColor: ColorsManager.appBarColor,
        iconTheme: const IconThemeData(color: ColorsManager.darkBlue),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.edit, color: ColorsManager.primaryColor),
            onPressed: () {
              context.pushNamed(
                Routes.addUpdateDoctorScreen,
                arguments: {'doctorModel': doctor, 'userType': 'doctor'},
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              padding: EdgeInsets.symmetric(vertical: HeightManager.h24),
              child: Column(
                children: [
                  ProfileImageWidget(profileImageUrl: doctor.profileImage),
                  SizedBox(height: HeightManager.h12),
                  Text(
                    'Dr. ${doctor.name}',
                    style: getBoldTextStyle(
                      fontSize: FontSizeManager.s20,
                      color: ColorsManager.darkBlue,
                    ),
                  ),
                  SizedBox(height: HeightManager.h4),
                ],
              ),
            ),

            // Section: Contact Info
            SectionTitle(title: 'Contact Info'),
            ProfileInfoRow(
              icon: Icons.email,
              title: 'Email',
              value: doctor.email,
            ),
            ProfileInfoRow(
              icon: Icons.phone,
              title: 'Phone',
              value: doctor.phone,
            ),

            // Section: Professional Info
            SectionTitle(title: 'Professional Info'),
            ProfileInfoRow(
              icon: Icons.work_outline,
              title: 'Experience',
              value: doctor.experience,
            ),
            ProfileInfoRow(
              icon: doctor.gender.toLowerCase() == 'male'
                      ? Icons.male
                      : Icons.female,
              title: 'Gender',
              value: doctor.gender,
            ),

            // Section: About
            SectionTitle(title:'About'),
            AboutBoxWidget(description: doctor.description),

            SizedBox(height: HeightManager.h24),
          ],
        ),
      ),
    );
  }

}
