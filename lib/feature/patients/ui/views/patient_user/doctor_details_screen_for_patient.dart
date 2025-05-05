import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
import 'package:leuko_care/core/widgets/profile_image_widget.dart';
import 'package:leuko_care/feature/patients/ui/widgets/patient_user/home/info_card.dart';

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

      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: HeightManager.h20,
          horizontal: WidthManager.w22,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ProfileImageWidget(profileImageUrl: doctor.profileImage),
            SizedBox(height: HeightManager.h20),

            Text(
              'Dr.${doctor.name}',
              style: getMediumTextStyle(
                fontSize: FontSizeManager.s24,
                color: ColorsManager.darkBlue,
              ),
            ),
            SizedBox(height: HeightManager.h20),

            InfoCard(icon: Icons.email, title: 'Email', value: doctor.email),
            InfoCard(icon: Icons.phone, title: 'Phone', value: doctor.phone),
            InfoCard(
              icon: Icons.work_outline,
              title: 'Experience',
              value: '${doctor.experience} years',
            ),
            InfoCard(
              icon: Icons.description,
              title: 'Description',
              value: doctor.description,
              isMultiline: true,
            ),
            SizedBox(height: HeightManager.h16),
          ],
        ),
      ),

      floatingActionButton: ClipOval(
        child: Material(
          color: ColorsManager.primaryColor,
          child: InkWell(
            onTap: () {
              Navigator.pop(context, true);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: HeightManager.h14,
                horizontal: WidthManager.w14,
              ),
              child: Icon(Icons.message, color: ColorsManager.white),
            ),
          ),
        ),
      ),
    );
  }
}
