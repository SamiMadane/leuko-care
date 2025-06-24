import 'package:easy_localization/easy_localization.dart';

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
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(width: WidthManager.w8),
            Text(
              'My Profile'.tr(),
              style: getMediumTextStyle(
                fontSize: FontSizeManager.s20,
                color: ColorsManager.darkBlue,
              ),
            ),
          ],
        ),
        elevation: 0,
        backgroundColor: ColorsManager.appBarColor,
        scrolledUnderElevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: WidthManager.w12),
            child: GestureDetector(
              onTap: () {
                context.pushNamed(
                  Routes.addUpdateDoctorScreen,
                  arguments: {'doctorModel': doctor, 'userType': 'doctor'},
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: ColorsManager.lightBlue,
                  shape: BoxShape.circle,
                ),
                padding: EdgeInsets.symmetric(horizontal: WidthManager.w8, vertical: HeightManager.h8),
                child: Icon(
                  Icons.edit,
                  color: ColorsManager.primaryColor,
                  size: 22,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: HeightManager.h24),
              child: Column(
                children: [
                  ProfileImageWidget(profileImageUrl: doctor.profileImage),
                  SizedBox(height: HeightManager.h12),
                  Text(
                    tr('doctor_name', namedArgs: {'name': doctor.name}),
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
            SectionTitle(title: 'Contact Info'.tr()),
            ProfileInfoRow(
              icon: Icons.email,
              title: 'Email'.tr(),
              value: doctor.email,
            ),
            ProfileInfoRow(
              icon: Icons.phone,
              title: 'Phone'.tr(),
              value: doctor.phone,
            ),

            // Section: Professional Info
            SectionTitle(title: 'Professional Info'.tr()),
            ProfileInfoRow(
              icon: Icons.work_outline,
              title: 'Experience'.tr(),
              value: plural(
                'years_count',
                doctor.experience,
                namedArgs: {'count': doctor.experience.toString()},
              ),
            ),
            ProfileInfoRow(
              icon:
                  doctor.gender.toLowerCase() == 'male'.tr()
                      ? Icons.male
                      : Icons.female,
              title: 'Gender'.tr(),
              value: doctor.gender.tr(),
            ),

            // Section: About
            SectionTitle(title: 'About'.tr()),
            AboutBoxWidget(description: doctor.description),

            SizedBox(height: HeightManager.h24),
          ],
        ),
      ),
    );
  }
}
