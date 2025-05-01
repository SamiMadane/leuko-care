import 'package:flutter/material.dart';
import 'package:leuko_care/core/widgets/empty_state_widget.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';
import 'package:leuko_care/feature/patients/ui/widgets/admin_user/all_patients_widgets/patient_list_tile.dart';

class PatientListViewSection extends StatelessWidget {
  final List<PatientModel> patients;
  final String doctorId;
  final String doctorName;

  const PatientListViewSection({
    super.key,
    required this.patients,
    required this.doctorId,
    required this.doctorName,
  });

  @override
  Widget build(BuildContext context) {
    if (patients.isEmpty) {
      return const EmptyStateWidget(
        icon: Icons.person_outline_sharp,
        title: 'No matching patients.',
        message: 'Try adjusting your search or filter options.',
      );
    }

    return ListView.builder(
      itemCount: patients.length,
      itemBuilder: (context, index) {
        final patient = patients[index];
        return PatientListTile(
          patient: patient,
          doctorId: doctorId,
          doctorName: doctorName,
        );
      },
    );
  }
}
