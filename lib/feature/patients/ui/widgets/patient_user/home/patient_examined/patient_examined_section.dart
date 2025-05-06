import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';
import 'package:leuko_care/feature/patients/ui/widgets/patient_user/home/doctor_info_widget.dart';
import 'package:leuko_care/feature/patients/ui/widgets/patient_user/home/patient_examined/health_overview_widget.dart';
import 'package:leuko_care/feature/patients/ui/widgets/patient_user/home/patient_examined/health_tips_widget.dart';

class PatientExaminedSection extends StatelessWidget {
  final PatientModel patient;
  final DoctorModel doctor;

  const PatientExaminedSection({super.key, required this.patient, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HealthOverviewWidget(patient: patient,),
        SizedBox(height: HeightManager.h20),
        HealthTipsWidget(patient: patient),
        SizedBox(height:  HeightManager.h20),
        DoctorInfoWidget(patient: patient, doctor: doctor),
      ],
    );
  }
}
