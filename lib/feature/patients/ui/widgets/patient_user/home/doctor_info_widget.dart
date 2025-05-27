import 'package:easy_localization/easy_localization.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/helpers/extensions.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/core/routes/routes.dart';
import 'package:leuko_care/feature/chats/data/models/conversation_model.dart';
import 'package:leuko_care/feature/chats/logic/cubit/chat_cubit.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';
import 'package:leuko_care/feature/patients/logic/cubit/patient_cubit.dart';
import 'package:shimmer/shimmer.dart';

class DoctorInfoWidget extends StatelessWidget {
  final PatientModel patient;
  final DoctorModel doctor;
  final ConversationModel? conversation;

  const DoctorInfoWidget({
    super.key,
    required this.patient,
    required this.doctor,
    this.conversation,
  });

  @override
  Widget build(BuildContext context) {
    final hasUnread = conversation?.hasUnreadMessagesFor(patient.id!) ?? false;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Doctor Who Examined You'.tr(),
          style: getSemiBoldTextStyle(
            fontSize: FontSizeManager.s18,
            color: ColorsManager.darkBlue,
          ),
        ),
         SizedBox(height: HeightManager.h12),
        _DoctorCard(
          doctor: doctor,
          patient: patient,
          hasUnread: hasUnread,
          conversation: conversation,
        ),
      ],
    );
  }
}

class _DoctorCard extends StatelessWidget {
  final DoctorModel doctor;
  final PatientModel patient;
  final ConversationModel? conversation;
  final bool hasUnread;

  const _DoctorCard({
    required this.doctor,
    required this.patient,
    required this.conversation,
    required this.hasUnread,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final shouldOpenChat = await context.pushNamed(
          Routes.doctorDetailsScreenForPatient,
          arguments: {
            'doctor': doctor,
            'patient': patient,
            'conversation': conversation,
          },
        );
        if (shouldOpenChat == true) {
          context.read<ChatCubit>().markMessagesAsReadForPatient(
            patient.id!,
            doctor.id!,
          );
          context.read<PatientCubit>().changeSelectedIndex(1);
        }
      },
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: HeightManager.h12,
              horizontal: WidthManager.w16,
            ),
            decoration: BoxDecoration(
              color: ColorsManager.white,
              borderRadius: BorderRadius.circular(RadiusManager.r16),
              boxShadow: [
                BoxShadow(
                  color: ColorsManager.lightBlue,
                  blurRadius: 5,
                  offset: Offset(1, 1),
                ),
              ],
              border: Border.all(
                color: ColorsManager.primaryColor.withValues(alpha: .3),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                _DoctorAvatar(imageUrl: doctor.profileImage),
                const SizedBox(width: 16),
                _DoctorInfo(name: doctor.name, email: doctor.email),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                  color: ColorsManager.primaryColor,
                ),
              ],
            ),
          ),

          if (hasUnread)
            Positioned(
              top: HeightManager.h10,
              left:context.locale.languageCode == 'ar'? WidthManager.w14 : null,
              right: context.locale.languageCode == 'ar' ? null : WidthManager.w14,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(Icons.mark_chat_unread, color: Colors.white, size: 12),
                    SizedBox(width: 4),
                    Text(
                      'New'.tr(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _DoctorAvatar extends StatelessWidget {
  final String imageUrl;

  const _DoctorAvatar({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: RadiusManager.r32,
      backgroundColor: Colors.grey.shade200,
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          width: WidthManager.w64,
          height: HeightManager.h64,
          fit: BoxFit.cover,
          placeholder: (_, __) => _buildShimmerLoading(),
          errorWidget:
              (_, __, ___) => const Icon(Icons.error, color: Colors.red),
        ),
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: CircleAvatar(
        radius: RadiusManager.r32,
        backgroundColor: Colors.white,
      ),
    );
  }
}

class _DoctorInfo extends StatelessWidget {
  final String name;
  final String email;

  const _DoctorInfo({required this.name, required this.email});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
             tr('doctor_name', namedArgs: {'name': name}),
            style: getSemiBoldTextStyle(
              fontSize: FontSizeManager.s16,
              color: ColorsManager.darkBlue,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            email,
            style: getRegularTextStyle(
              fontSize: FontSizeManager.s14,
              color: ColorsManager.gray,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
