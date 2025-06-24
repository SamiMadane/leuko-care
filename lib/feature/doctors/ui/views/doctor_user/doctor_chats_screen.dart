import 'package:easy_localization/easy_localization.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/assets_manager.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/core/widgets/empty_state_widget.dart';
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
        title: Row(
          children: [
            SizedBox(width: WidthManager.w8),
            Text(
              'Chat with Patients'.tr(),
              style: getMediumTextStyle(
                fontSize: FontSizeManager.s20,
                color: ColorsManager.darkBlue,
              ),
            ),
          ],
        ),
        elevation: 0,
        backgroundColor: ColorsManager.appBarColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: HeightManager.h10,
          horizontal: WidthManager.w16,
        ),
        child:
            patients.isEmpty
                ? EmptyStateWidget(
                  title: 'No patients available for chat'.tr(),
                  message:
                      'You currently don\'t have any patients to chat with.'
                          .tr(),
                  lottiePath:
                      AssetsManager.noChat2Lottie, // تأكد من إضافته في المسارات
                  isFullScreen: true,
                )
                : ListView.separated(
                  itemCount: sortedPatients.length,
                  separatorBuilder:
                      (_, __) => SizedBox(height: HeightManager.h12),
                  itemBuilder: (context, index) {
                    final patient = sortedPatients[index];
                    final conversation =
                        conversationsByPatientId[patient.id] ??
                        ConversationModel(
                          lastMessage: 'Send your first message.'.tr(),
                          lastMessageTime: Timestamp.fromDate(DateTime(1970)),
                          conversationId: '',
                          participantAId: '',
                          participantBId: '',
                          hasUnreadMessagesByParticipant: {},
                          lastMessageSenderId: '',
                        );
                    return PatientChatCard(
                      patient: patient,
                      conversation: conversation,
                      doctor: doctor,
                    );
                  },
                ),
      ),
    );
  }
}
