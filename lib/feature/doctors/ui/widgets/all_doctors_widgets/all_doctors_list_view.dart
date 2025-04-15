import 'package:flutter/material.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
import 'package:leuko_care/feature/doctors/ui/widgets/all_doctors_widgets/doctor_list_tile.dart';
import 'package:leuko_care/core/widgets/empty_state_widget.dart';


class AllDoctorsListView extends StatelessWidget {
  final List<DoctorModel> doctors;
  const AllDoctorsListView({super.key, required this.doctors});

  @override
  Widget build(BuildContext context) {
    if (doctors.isEmpty) {
      return const EmptyStateWidget(
        icon: Icons.medical_information_outlined,
        title: 'No doctors available.',
        message: 'Please add a doctor to get started.',
      );
    }

    return ListView.builder(
      itemCount: doctors.length,
      itemBuilder: (context, index) {
        final doctor = doctors[index];
        return DoctorListTile(doctor: doctor);
      },
    );
  }
}
