import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/feature/chats/data/models/conversation_model.dart';
import 'package:leuko_care/feature/chats/logic/cubit/chat_cubit.dart';
import 'package:leuko_care/feature/chats/ui/views/chat_screen.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';
import 'package:shimmer/shimmer.dart';

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
                    print('Building item for patient ID: ${patient.id}');

                    final conversation =
                        conversationsByPatientId[patient.id] ??
                        ConversationModel(
                          lastMessage: 'Send your first message.',
                          lastMessageTime: Timestamp.fromDate(DateTime(1970)),
                          conversationId: '',
                          participantAId: '',
                          participantBId: '',
                          hasUnreadMessagesByParticipant: {},
                        );
                    return _buildPatientCard(
                      patient,
                      conversation,
                      context,
                      doctor,
                    );
                  },
                ),
      ),
    );
  }

  Widget _buildPatientCard(
    PatientModel patient,
    ConversationModel conversation,
    BuildContext context,
    DoctorModel doctor,
  ) {
    final hasUnreadForDoctor = conversation.hasUnreadMessagesFor(doctor.id!);
    final hasUnreadForPatient = conversation.hasUnreadMessagesFor(patient.id!);
    final lastMessage =
        conversation.lastMessage;
    final isImageMessage = lastMessage.startsWith('https://res.cloudinary.com');
    final isLastMessageFromDoctor =
        conversation.participantAId == doctor.id
            ? conversation.participantAId ==
                doctor
                    .id // participantAId == doctor.id ؟ => true
            : conversation.participantBId == doctor.id;

    // إذا lastMessageTime صفر (1970) نعطي null حتى نعالج الوضع بدون رسالة
    final lastMessageTime = conversation.lastMessageTime?.toDate();
    final bool hasValidTime =
        lastMessageTime != null && lastMessageTime.year > 1970;

    return Material(
      color: ColorsManager.moreLighterGray,
      elevation: 4,
      borderRadius: BorderRadius.circular(RadiusManager.r16),
      child: InkWell(
        onTap: () {
          var chatCubit = context.read<ChatCubit>();
          chatCubit.markMessagesAsReadForDoctor(doctor.id!, patient.id!);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (_) => BlocProvider.value(
                    value: context.read<ChatCubit>(),
                    child: ChatScreen(
                      currentUserId: doctor.id!,
                      otherUserId: patient.id!,
                      patient: patient,
                    ),
                  ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(RadiusManager.r16),
        child: Padding(
          padding: EdgeInsets.all(HeightManager.h16),
          child: Row(
            children: [
              ClipOval(
                child: CachedNetworkImage(
                  width: HeightManager.h60,
                  height: HeightManager.h60,
                  fit: BoxFit.cover,
                  imageUrl: patient.profileImage,
                  placeholder:
                      (context, url) => Shimmer.fromColors(
                        baseColor: ColorsManager.lightGray,
                        highlightColor: Colors.white,
                        child: CircleAvatar(
                          radius: RadiusManager.r34,
                          backgroundColor: Colors.white,
                        ),
                      ),
                  errorWidget:
                      (context, url, error) =>
                          Icon(Icons.person, size: HeightManager.h56),
                ),
              ),
              SizedBox(width: WidthManager.w12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      patient.name,
                      style: getBoldTextStyle(
                        fontSize: FontSizeManager.s16,
                        color: ColorsManager.darkBlue,
                      ),
                    ),
                    SizedBox(height: HeightManager.h6),
                    Row(
                      children: [
                        if (isLastMessageFromDoctor)
                          Icon(
                            Icons.done_all,
                            size: HeightManager.h16,
                            color:
                                hasUnreadForPatient
                                    ? ColorsManager.gray
                                    : ColorsManager.primaryColor,
                          ),
                        if (isLastMessageFromDoctor)
                          SizedBox(width: WidthManager.w4),
                        if (isImageMessage)
                          Row(
                            children: [
                              Icon(
                                Icons.image,
                                size: HeightManager.h16,
                                color: ColorsManager.gray,
                              ),
                              SizedBox(width: WidthManager.w4),
                              Text(
                                'Photo',
                                style: TextStyle(
                                  fontSize: FontSizeManager.s14,
                                  fontWeight:
                                      hasUnreadForDoctor
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                  color:
                                      hasUnreadForDoctor
                                          ? ColorsManager.primaryColor
                                          : ColorsManager.gray,
                                ),
                              ),
                            ],
                          )
                        else
                          Text(
                            lastMessage,
                            style: TextStyle(
                              fontSize: FontSizeManager.s14,
                              fontWeight:
                                  hasUnreadForDoctor
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                              color:
                                  hasUnreadForDoctor
                                      ? ColorsManager.primaryColor
                                      : ColorsManager.gray,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: WidthManager.w12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      if (hasUnreadForDoctor)
                        Container(
                          width: 10,
                          height: 10,
                          margin: EdgeInsets.only(right: 6),
                          decoration: const BoxDecoration(
                            color: Colors.redAccent,
                            shape: BoxShape.circle,
                          ),
                        ),
                      SizedBox(width: WidthManager.w4),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: HeightManager.h16,
                        color: ColorsManager.gray,
                      ),
                    ],
                  ),
                  SizedBox(height: HeightManager.h10),
                  if (hasValidTime)
                    Text(
                      _formatTimestampWithElapsed(lastMessageTime),
                      style: getRegularTextStyle(
                        fontSize: FontSizeManager.s12,
                        color: ColorsManager.gray,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // دالة لتنسيق الوقت + الوقت المنقضي مع بعض
  String _formatTimestampWithElapsed(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    String elapsed;
    if (difference.inDays > 7) {
      elapsed = '${time.day}/${time.month}/${time.year}';
    } else if (difference.inDays >= 1) {
      elapsed = '${difference.inDays}d ago';
    } else if (difference.inHours >= 1) {
      elapsed = '${difference.inHours}h ago';
    } else if (difference.inMinutes >= 1) {
      elapsed = '${difference.inMinutes}m ago';
    } else {
      elapsed = 'now';
    }

    // الوقت بالساعة والدقيقة
    final clockTime =
        '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';

    return '$elapsed • $clockTime';
  }
}
