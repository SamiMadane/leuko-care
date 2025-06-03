import 'package:easy_localization/easy_localization.dart';

// patient_chat_card.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:leuko_care/core/helpers/time_formatter.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/feature/chats/data/models/conversation_model.dart';
import 'package:leuko_care/feature/chats/logic/cubit/chat_cubit.dart';
import 'package:leuko_care/feature/chats/ui/views/chat_screen.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class PatientChatCard extends StatelessWidget {
  final PatientModel patient;
  final ConversationModel conversation;
  final DoctorModel doctor;

  const PatientChatCard({
    super.key,
    required this.patient,
    required this.conversation,
    required this.doctor,
  });

  @override
  Widget build(BuildContext context) {
    final hasUnreadForDoctor = conversation.hasUnreadMessagesFor(doctor.id!);
    final hasUnreadForPatient = conversation.hasUnreadMessagesFor(patient.id!);
    final lastMessage = conversation.lastMessage;
    final isImageMessage = lastMessage.startsWith('https://res.cloudinary.com');
    final isLastMessageFromDoctor = conversation.lastMessageSenderId == doctor.id ;

    final lastMessageTime = conversation.lastMessageTime?.toDate();
    final bool hasValidTime = lastMessageTime != null && lastMessageTime.year > 1970;

    return Material(
        color: hasUnreadForDoctor 
      ? ColorsManager.moreLighterGray
      : Colors.white,
  borderRadius: BorderRadius.circular(RadiusManager.r16),
      child: InkWell(
        onTap: () {
          context.read<ChatCubit>().markMessagesAsReadForDoctor(doctor.id!, patient.id!);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: context.read<ChatCubit>(),
                child: ChatScreen(
                  currentUserId: doctor.id!,
                  otherUserId: patient.id!,
                  userType: 'doctor',
                ),
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(RadiusManager.r16),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: HeightManager.h12, horizontal: WidthManager.w16),
          child: Row(
            children: [
              _buildAvatar(),
              SizedBox(width: WidthManager.w12),
              _buildMessageInfo(hasUnreadForDoctor,hasUnreadForPatient, isLastMessageFromDoctor, isImageMessage, lastMessage),
              SizedBox(width: WidthManager.w12),
              _buildTrailing(hasUnreadForDoctor, hasValidTime, lastMessageTime),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return ClipOval(
      child: CachedNetworkImage(
        width: HeightManager.h60,
        height: HeightManager.h60,
        fit: BoxFit.cover,
        imageUrl: patient.profileImage,
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: ColorsManager.lightGray,
          highlightColor: Colors.white,
          child: CircleAvatar(
            radius: RadiusManager.r34,
            backgroundColor: Colors.white,
          ),
        ),
        errorWidget: (context, url, error) => Icon(Icons.person, size: HeightManager.h56),
      ),
    );
  }

  Widget _buildMessageInfo(bool hasUnreadForDoctor,bool hasUnreadForPatient, bool isLastMessageFromDoctor, bool isImageMessage, String lastMessage) {
    return Expanded(
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
                  color: hasUnreadForPatient
                      ? ColorsManager.gray
                      : ColorsManager.primaryColor,
                ),
              if (isLastMessageFromDoctor) SizedBox(width: WidthManager.w4),
              isImageMessage
                  ? Row(
                      children: [
                        Icon(Icons.image, size: HeightManager.h16, color: ColorsManager.gray),
                        SizedBox(width: WidthManager.w4),
                        Text(
                          'Photo'.tr(),
                          style: TextStyle(
                            fontSize: FontSizeManager.s14,
                            fontWeight: hasUnreadForDoctor ? FontWeight.bold : FontWeight.normal,
                            color: hasUnreadForDoctor ? ColorsManager.primaryColor : ColorsManager.gray,
                          ),
                        ),
                      ],
                    )
                  : Expanded(
                    child: Text(
                        lastMessage,
                        style: TextStyle(
                          fontSize: FontSizeManager.s14,
                          fontWeight: hasUnreadForDoctor ? FontWeight.bold : FontWeight.normal,
                          color: hasUnreadForDoctor ? ColorsManager.primaryColor : ColorsManager.gray,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTrailing(bool hasUnreadForDoctor, bool hasValidTime, DateTime? time) {
    return Column(
  crossAxisAlignment: CrossAxisAlignment.end,
  children: [
    Row(
      children: [
        if (hasUnreadForDoctor)
          Container(
            width: 10,
            height: 10,
            margin: const EdgeInsets.only(right: 6),
            decoration: const BoxDecoration(color: Colors.redAccent, shape: BoxShape.circle),
          ),
          SizedBox(width: WidthManager.w8,),
        if (hasValidTime)
          Text(
            formatTimestampWithElapsed(time!),
            style: getRegularTextStyle(
              fontSize: FontSizeManager.s12,
              color: ColorsManager.gray,
            ),
          ),
      ],
    ),
    SizedBox(height: HeightManager.h6),
    Icon(Icons.arrow_forward_ios, size: HeightManager.h16, color: ColorsManager.gray),
  ],
);

  }



}
