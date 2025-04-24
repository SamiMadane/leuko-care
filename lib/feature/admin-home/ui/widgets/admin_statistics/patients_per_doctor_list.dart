// PatientsPerDoctorList Widget
import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';

class PatientsPerDoctorList extends StatelessWidget {
  final Map<String, int> data;

  const PatientsPerDoctorList({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: data.entries.map((entry) {
        return Card(
          color: Colors.green[50],
          elevation: 8,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: WidthManager.w16),
            title: Text(
              "Dr. ${entry.key}: ${entry.value} Patients",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
