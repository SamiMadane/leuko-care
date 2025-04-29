import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/feature/patients/logic/cubit/patient_cubit.dart';
import 'package:leuko_care/feature/patients/logic/cubit/patient_state.dart';

class PatientHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Home'),
      ),
      body: BlocBuilder<PatientCubit, PatientState>(
        builder: (context, state) {
          if (state is GetPatientStateLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is GetPatientStateSuccess) {
            final patient = state.patients.first; // Assume we're working with the first patient here

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Welcome message
                    Text(
                      'Hello, ${patient.name}!',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),

                    // Profile picture
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(patient.profileImage),
                    ),
                    SizedBox(height: 16),

                    // Health summary
                    Text(
                      'Health Summary',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    // Example: Displaying a health condition message
                    Text(
                      'Latest test result: Normal',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 16),

                    // Buttons for navigation
                    ElevatedButton(
                      onPressed: () {
                        // Navigate to upload sample page
                      },
                      child: Text('Upload New Blood Sample'),
                    ),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        // Navigate to review results page
                      },
                      child: Text('Review Test Results'),
                    ),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        // Navigate to settings page
                      },
                      child: Text('Settings'),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is GetPatientStateError) {
            return Center(child: Text('Error loading patient data'));
          }

          return Center(child: Text('No patient data available'));
        },
      ),
    );
  }
}
