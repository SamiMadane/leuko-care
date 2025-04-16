import 'package:flutter/material.dart';
import 'package:leuko_care/core/widgets/empty_state_widget.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';
import 'package:leuko_care/feature/patients/ui/widgets/all_patients_widgets/patient_list_tile.dart';


class AllPaitentListView extends StatelessWidget {
  final List<PatientModel> patients;
  final String doctorId;
  final String doctorName;
  
  
  const AllPaitentListView({super.key, required this.patients, required this.doctorId, required this.doctorName});

  @override
  Widget build(BuildContext context) {
    if (patients.isEmpty) {
      return const EmptyStateWidget(
        icon: Icons.person_outline_sharp,
        title: 'No patient available.',
        message: 'Please add a patient to get started.',
      );
    }

    return ListView.builder(
      itemCount: patients.length,
      itemBuilder: (context, index) {
        final patient = patients[index];
        return PatientListTile(patient: patient,doctorId:doctorId ,doctorName:doctorName ,);
      },
    );
  }
}
