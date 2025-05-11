import 'package:flutter/material.dart';
import 'package:leuko_care/feature/doctors/ui/widgets/doctor_user/sample_result_screen/result_info_row.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';

Widget patientInfoWidget(PatientModel patient) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Patient Info", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue)),
      SizedBox(height: 8),
      resultInfoRow("Name", patient.name),
      resultInfoRow("Email", patient.email),
      resultInfoRow("Phone", patient.phone),
      SizedBox(height: 16),
    ],
  );
}


