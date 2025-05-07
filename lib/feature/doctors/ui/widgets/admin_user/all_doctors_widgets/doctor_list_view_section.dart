import 'package:flutter/material.dart';
import 'package:leuko_care/core/widgets/empty_state_widget.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
import 'package:leuko_care/feature/doctors/ui/widgets/admin_user/all_doctors_widgets/doctor_list_tile.dart';

class DoctorListViewSection extends StatelessWidget {
  final List<DoctorModel> doctors;

  const DoctorListViewSection({
    super.key,
    required this.doctors,
  });

  @override
  Widget build(BuildContext context) {
    if (doctors.isEmpty) {
      return const EmptyStateWidget(
        icon: Icons.medical_information_outlined,
        title: 'No matching doctors.',
        message: 'Try adjusting your search or filter options.',
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
