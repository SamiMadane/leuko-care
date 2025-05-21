import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';
import 'package:leuko_care/core/widgets/all_patient_list_view.dart';

class DoctorPatientsScreen extends StatelessWidget {
  final DoctorModel doctor;
  final List<PatientModel> patients;

  const DoctorPatientsScreen({
    super.key,
    required this.doctor,
    required this.patients,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(width: WidthManager.w8),

            Text(
              'Patients of Dr. ${doctor.name}',
              style: getMediumTextStyle(
                fontSize: FontSizeManager.s20,
                color: ColorsManager.darkBlue,
              ),
            ),
          ],
        ),
        elevation: 0,
        backgroundColor: ColorsManager.white,
      ),
      body: AllPaitentListView(
        patients: patients,
        doctorId: doctor.id!,
        doctorName: doctor.name,
        userType: 'doctor',
      ),
    );
  }
}
