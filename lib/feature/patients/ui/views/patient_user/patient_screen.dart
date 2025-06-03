import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/feature/chats/logic/cubit/chat_cubit.dart';
import 'package:leuko_care/feature/chats/logic/cubit/chat_session_manager.dart';
import 'package:leuko_care/feature/chats/ui/views/chat_screen.dart';
import 'package:leuko_care/feature/patients/logic/cubit/patient_cubit.dart';
import 'package:leuko_care/feature/patients/logic/cubit/patient_state.dart';
import 'package:leuko_care/feature/patients/ui/views/patient_user/patient_profile_screen.dart';
import 'package:leuko_care/feature/patients/ui/views/patient_user/patient_home_screen.dart';
import 'package:leuko_care/feature/patients/ui/widgets/patient_user/patient_bottom_nav_bar.dart';
import 'package:leuko_care/feature/patients/ui/widgets/patient_user/patient_shimmer.dart';

class PatientScreen extends StatefulWidget {
  final int? initialIndex;
  const PatientScreen({super.key, this.initialIndex});

  @override
  State<PatientScreen> createState() => _PatientScreenState();
}

class _PatientScreenState extends State<PatientScreen> {
  bool hasHandledInitialIndex = false;

  @override
  Widget build(BuildContext context) {
    final patientId = FirebaseAuth.instance.currentUser?.uid;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<PatientCubit, PatientState>(
            buildWhen: (previous, current) =>
                current is GetPatientAndDoctorStateLoading ||
                current is GetPatientAndDoctorStateError ||
                current is GetPatientAndDoctorStateSuccess,
            builder: (context, state) {
              if (state is GetPatientAndDoctorStateLoading) {
                return const PatientShimmer();
              } else if (state is GetPatientAndDoctorStateError) {
                return _buildErrorWidget(context, patientId);
              } else if (state is GetPatientAndDoctorStateSuccess) {
                // ✅ التعامل مع initialIndex أول مرة فقط
                if (!hasHandledInitialIndex && widget.initialIndex != null) {
                  final chatId = ChatCubit.getChatId(
                    state.patient.id!,
                    state.patient.doctorId,
                  );

                  ChatSessionManager().currentChatId = chatId;
                  context.read<PatientCubit>().changeSelectedIndex(
                        widget.initialIndex!,
                      );

                  hasHandledInitialIndex = true;
                }

                // ✅ عرض المحتوى حسب selectedIndex
                return BlocBuilder<PatientCubit, PatientState>(
                  buildWhen: (previous, current) =>
                      current is PatientBottomNavChanged,
                  builder: (context, _) {
                    final cubit = context.read<PatientCubit>();
                    final selectedIndex = cubit.selectedIndex;
                    final patientId = state.patient.id;
                    final doctorId = state.doctor.id;

                    // تحديث currentChatId حسب التاب الحالي
                    if (selectedIndex == 1 &&
                        patientId != null &&
                        doctorId != null) {
                      final chatId =
                          ChatCubit.getChatId(patientId, doctorId);
                      ChatSessionManager().currentChatId = chatId;
                    } else {
                      ChatSessionManager().currentChatId = null;
                    }

                    final pages = [
                      PatientHomeScreen(
                        patient: state.patient,
                        doctor: state.doctor,
                        conversation: state.conversation,
                      ),
                      ChatScreen(
                        currentUserId: state.patient.id!,
                        otherUserId: state.doctor.id!,
                        userType: 'patient',
                      ),
                      PatientProfileScreen(patient: state.patient),
                    ];

                    return IndexedStack(
                      index: selectedIndex,
                      children: pages,
                    );
                  },
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
        bottomNavigationBar: BlocBuilder<PatientCubit, PatientState>(
          builder: (context, state) {
            final cubit = context.read<PatientCubit>();
            final patientId = cubit.patientId;
            final doctorId = cubit.doctorId;

            return PatientBottomNavBar(
              currentIndex: cubit.selectedIndex,
              onTap: (index) {
                cubit.changeSelectedIndex(index);

                if (index == 1 && patientId != null && doctorId != null) {
                  final chatId = ChatCubit.getChatId(patientId, doctorId);
                  ChatSessionManager().currentChatId = chatId;

                  context.read<ChatCubit>().markMessagesAsReadForPatient(
                        patientId,
                        doctorId,
                      );
                } else {
                  ChatSessionManager().currentChatId = null;
                }
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildErrorWidget(BuildContext context, String? patientId) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Error loading data'.tr()),
          ElevatedButton(
            onPressed: () {
              if (patientId != null) {
                context.read<PatientCubit>().getPatientAndDoctor(patientId);
              }
            },
            child: Text('Retry'.tr()),
          ),
        ],
      ),
    );
  }
}
