import 'package:flutter/material.dart';
import 'package:leuko_care/core/widgets/home_top_widget.dart';
import 'package:leuko_care/feature/chats/data/models/conversation_model.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/feature/patients/ui/widgets/patient_user/home/patient_examined/patient_examined_section.dart';
import 'package:leuko_care/feature/patients/ui/widgets/patient_user/home/patient_not_examined/examination_pending_widget.dart';

class PatientHomeScreen extends StatelessWidget {
  final PatientModel patient;
  final DoctorModel doctor;
  final ConversationModel? conversation;
  const PatientHomeScreen({super.key,  required this.patient, required this.doctor,  this.conversation});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: WidthManager.w20,
        vertical: HeightManager.h16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HomeTopWidget(name: patient.name, imageUrl: patient.profileImage),
          SizedBox(height: HeightManager.h20),
          Row(
            children: [
              Icon(
                Icons.perm_device_information,
                color: ColorsManager.primaryColor,
                size: FontSizeManager.s24,
              ),
              SizedBox(width: WidthManager.w8),
              Text(
                "Current Health Status",
                style: getBoldTextStyle(
                  fontSize: FontSizeManager.s18,
                  color: ColorsManager.darkBlue,
                ),
              ),
            ],
          ),
          SizedBox(height: HeightManager.h20),
          patient.isExamined
              ? PatientExaminedSection(patient: patient, doctor: doctor,conversation: conversation)
              : const ExaminationPendingWidget(),
          SizedBox(height: HeightManager.h20),
        ],
      ),
    );
  }
}
