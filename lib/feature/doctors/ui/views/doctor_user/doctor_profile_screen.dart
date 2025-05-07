import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/core/widgets/profile_image_widget.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
import 'package:leuko_care/feature/doctors/ui/widgets/shared/doctor_details_edit_button.dart';
import 'package:leuko_care/feature/patients/ui/widgets/patient_user/home/info_card.dart';

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
              'My Profile',
              style: getSemiBoldTextStyle(
                fontSize: FontSizeManager.s20,
                color: ColorsManager.darkBlue,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: ColorsManager.darkBlue),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: HeightManager.h16,
          horizontal: WidthManager.w20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ProfileImageWidget(profileImageUrl: doctor.profileImage),
            SizedBox(height: HeightManager.h16),
            Text(
              'Dr. ${doctor.name}',
              style: getBoldTextStyle(
                fontSize: FontSizeManager.s22,
                color: ColorsManager.darkBlue,
              ),
            ),
            SizedBox(height: HeightManager.h16),

            InfoCard(title: 'Email', value: doctor.email, icon: Icons.email),
            InfoCard(title: 'Phone', value: doctor.phone, icon: Icons.phone),
            InfoCard(
              title: 'Experience',
              value: doctor.experience,
              icon: Icons.work,
            ),
            InfoCard(
              title: 'Description',
              value: doctor.description,
              icon: Icons.info_outline,
            ),
            SizedBox(height: HeightManager.h16),
            DoctorEditButton(doctor: doctor, userType: 'doctor',)
          ],
        ),
      ),
    );
  }
}
