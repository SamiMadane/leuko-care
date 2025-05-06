import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWelcomeHeader(doctor.name),
          const SizedBox(height: 20),
          _buildStatsCards(patients.length),
          const SizedBox(height: 20),
          const Text(
            "Recent Patients",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.separated(
              itemCount: patients.length > 5 ? 5 : patients.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final patient = patients[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 3,
                  child: ListTile(
                    title: Text(patient.name),
                    subtitle: Text("Status: ${patient.healthStatus}"),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      // Navigate to patient details
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildWelcomeHeader(String name) {
  return Text(
    "Welcome, Dr. $name 👋",
    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
  );
}

Widget _buildStatsCards(int patientsCount) {
  return Row(
    children: [
      Expanded(
        child: _buildStatCard(
          label: "Total Patients",
          value: "$patientsCount",
          color: ColorsManager.primaryColor,
        ),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: _buildStatCard(
          label: "Pending Samples",
          value: "0", // Placeholder for now
          color: Colors.orange,
        ),
      ),
    ],
  );
}

Widget _buildStatCard({
  required String label,
  required String value,
  required Color color,
}) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: color),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 14, color: color)),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    ),
  );
}
