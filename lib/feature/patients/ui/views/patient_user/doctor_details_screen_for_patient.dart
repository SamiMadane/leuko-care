import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/core/widgets/profile_image_widget.dart';
import 'package:leuko_care/core/widgets/section_title.dart';
import 'package:leuko_care/feature/chats/data/models/conversation_model.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';
import 'package:leuko_care/core/widgets/profile_info_row.dart';
import 'package:leuko_care/feature/doctors/ui/widgets/doctor_user/doctor_profile_screen/about_box_widget.dart';
import 'package:leuko_care/feature/patients/ui/widgets/patient_user/home/patient_examined/message_status_card.dart';

class DoctorDetailsScreenForPatient extends StatelessWidget {
  final DoctorModel doctor;
  final PatientModel patient;
  final ConversationModel? conversation;

  const DoctorDetailsScreenForPatient({
    super.key,
    required this.doctor,
    required this.patient,
    this.conversation,
  });

  @override
  Widget build(BuildContext context) {
    final hasUnread = conversation?.hasUnreadMessagesFor(patient.id!) ?? false;
    final lastMessage = conversation?.lastMessageTime?.toDate();

    return Scaffold(
      backgroundColor: ColorsManager.white,
      appBar: AppBar(
        title: Text(
          'Doctor Details'.tr(),
          style: getMediumTextStyle(
            fontSize: FontSizeManager.s20,
            color: ColorsManager.darkBlue,
          ),
        ),
        backgroundColor: ColorsManager.appBarColor,
        iconTheme: const IconThemeData(color: ColorsManager.darkBlue),
        elevation: 0,
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
                    tr('doctor_name', namedArgs: {'name': doctor.name}),
                    style: getBoldTextStyle(
                      fontSize: FontSizeManager.s20,
                      color: ColorsManager.darkBlue,
                    ),
                  ),
                ],
              ),
            ),

            if (lastMessage != null)
              Padding(
                padding: EdgeInsets.only(bottom: HeightManager.h16),
                child: MessageStatusCard(
                  lastMessageTime: lastMessage,
                  hasUnread: hasUnread,
                  doctorName: doctor.name,
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

      floatingActionButton: Stack(
        clipBehavior: Clip.none,
        children: [
          FloatingActionButton(
            shape: const CircleBorder(),
            backgroundColor: ColorsManager.primaryColor,
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: const Icon(Icons.message, color: Colors.white),
          ),
          if (hasUnread)
            Positioned(
              top: 3,
              right: 3,
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: HeightManager.h6,
                  horizontal: WidthManager.w6,
                ),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                constraints: const BoxConstraints(minWidth: 12, minHeight: 12),
              ),
            ),
        ],
      ),
    );
  }
}
