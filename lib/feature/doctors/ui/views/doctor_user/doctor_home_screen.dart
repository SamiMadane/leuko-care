import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/widgets/home_top_widget.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
import 'package:leuko_care/feature/doctors/ui/widgets/doctor_user/doctor_home_screen/examination_chart_section.dart';
import 'package:leuko_care/feature/doctors/ui/widgets/doctor_user/doctor_home_screen/health_status_section.dart';
import 'package:leuko_care/feature/doctors/ui/widgets/doctor_user/doctor_home_screen/stats_cards_section.dart';
import 'package:leuko_care/feature/doctors/ui/widgets/doctor_user/medical_tips_section.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';

class DoctorHomeScreen extends StatelessWidget {
  final DoctorModel doctor;
  final List<PatientModel> patients;

  const DoctorHomeScreen({
    super.key,
    required this.doctor,
    required this.patients,
  });

  @override
  Widget build(BuildContext context) {
    final totalPatients = patients.length;
    final pending = patients.where((p) => !p.isExamined).length;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: WidthManager.w16,
        vertical: HeightManager.h16,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeTopWidget(
              name: "Dr. ${doctor.name}",
              imageUrl: doctor.profileImage,
              subMessage: "Your patients at a glance.",
            ),
            SizedBox(height: HeightManager.h24),
            StatsCardsSection(total: totalPatients, pending: pending),
            SizedBox(height: HeightManager.h24),
            ExaminationChartSection(total: totalPatients, pending: pending),
            SizedBox(height: HeightManager.h24),
            HealthStatusSection(patients: patients),
            SizedBox(height: HeightManager.h24),
            const MedicalTipsSection(),
          ],
        ),
      ),
    );
  }
}
