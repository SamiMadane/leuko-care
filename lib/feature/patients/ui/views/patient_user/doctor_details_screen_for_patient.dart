import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
import 'package:leuko_care/core/widgets/profile_image_widget.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';
import 'package:leuko_care/feature/patients/ui/widgets/patient_user/home/patient_examined/info_card.dart';
import 'package:leuko_care/feature/patients/ui/widgets/patient_user/home/patient_examined/message_status_card.dart';

class DoctorDetailsScreenForPatient extends StatelessWidget {
  final DoctorModel doctor;
  final PatientModel patient;

  const DoctorDetailsScreenForPatient({
    super.key,
    required this.doctor,
    required this.patient,
  });

  @override
  Widget build(BuildContext context) {
    final hasUnread = patient.hasUnreadMessages ?? false;
    final lastMessage = patient.lastMessageTime?.toDate();

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
            SizedBox(height: HeightManager.h16),

            Text(
              'Dr. ${doctor.name}',
              style: getMediumTextStyle(
                fontSize: FontSizeManager.s24,
                color: ColorsManager.darkBlue,
              ),
            ),
            SizedBox(height: HeightManager.h10),

            if (lastMessage != null)
              MessageStatusCard(
                lastMessageTime: lastMessage,
                hasUnread: hasUnread,
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
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorsManager.primaryColor,
        onPressed: () {
          Navigator.pop(context, true); // لاحقًا توجه إلى شاشة الدردشة
        },
        child: Icon(Icons.message, color: Colors.white),
      ),
    );
  }
}


