import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/feature/chats/data/models/conversation_model.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
import 'package:leuko_care/feature/doctors/ui/widgets/doctor_user/doctor_chats_screen/patient_chat_card.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';

class DoctorChatsScreen extends StatelessWidget {
  final DoctorModel doctor;
  final List<PatientModel> patients;
  final Map<String, ConversationModel> conversationsByPatientId; // مضاف

  const DoctorChatsScreen({
    super.key,
    required this.patients,
    required this.doctor,
    required this.conversationsByPatientId,
  });

  @override
  Widget build(BuildContext context) {
    final sortedPatients = [...patients]..sort((a, b) {
      final aTime =
          conversationsByPatientId[a.id]?.lastMessageTime?.toDate() ??
          DateTime(1970);
      final bTime =
          conversationsByPatientId[b.id]?.lastMessageTime?.toDate() ??
          DateTime(1970);
      return bTime.compareTo(aTime); // تنازلي: الأحدث أولاً
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Patients',
          style: getBoldTextStyle(
            fontSize: FontSizeManager.s20,
            color: ColorsManager.darkBlue,
          ),
        ),
        elevation: 0,
        backgroundColor: ColorsManager.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(HeightManager.h16),
        child:
            patients.isEmpty
                ? const Center(child: Text('No patients available for chat'))
                : ListView.separated(
                  itemCount: sortedPatients.length,
                  separatorBuilder:
                      (_, __) => SizedBox(height: HeightManager.h12),
                  itemBuilder: (context, index) {
                    final patient = sortedPatients[index];
                    final conversation =
                        conversationsByPatientId[patient.id] ??
                        ConversationModel(
                          lastMessage: 'Send your first message.',
                          lastMessageTime: Timestamp.fromDate(DateTime(1970)),
                          conversationId: '',
                          participantAId: '',
                          participantBId: '',
                          hasUnreadMessagesByParticipant: {}, lastMessageSenderId: '',
                        );
                    return PatientChatCard(
                      patient:patient,
                      conversation:conversation,
                      doctor:doctor,
                    );
                  },
                ),
      ),
    );
  }


}
