import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';

class DoctorChatsScreen extends StatelessWidget {
  final List<PatientModel> patients;

  const DoctorChatsScreen({super.key, required this.patients});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Patient Chats',
          style: getBoldTextStyle(
            fontSize: FontSizeManager.s20,
            color: ColorsManager.darkBlue,
          ),
        ),
        elevation: 0,
        backgroundColor: ColorsManager.white,
      ),
      body:
          patients.isEmpty
              ? const Center(child: Text('No patients available for chat'))
              : ListView.builder(
                itemCount: patients.length,
                itemBuilder: (context, index) {
                  final patient = patients[index];
                  return _buildPatientChatItem(patient, context);
                },
              ),
    );
  }

  Widget _buildPatientChatItem(PatientModel patient, BuildContext context) {
    return ListTile(
      onTap: () {
        // Navigate to the chat screen with the selected patient
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChatScreen(patient: patient)),
        );
      },
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(patient.profileImage), // صورة المريض
        radius: 30,
      ),
      title: Text(
        patient.name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(patient.email),
      trailing: const Icon(Icons.chat_bubble_outline),
    );
  }
}

class ChatScreen extends StatelessWidget {
  final PatientModel patient;

  const ChatScreen({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    // تصميم المحادثة مع المريض
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with ${patient.name}'),
        elevation: 0,
        backgroundColor: ColorsManager.white,
        foregroundColor: ColorsManager.primaryColor,
      ),
      body: Center(child: Text('Chat UI with ${patient.name} here')),
    );
  }
}
