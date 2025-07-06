import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/feature/chats/logic/cubit/chat_cubit.dart';
import 'package:leuko_care/feature/chats/logic/cubit/chat_session_manager.dart';
import 'package:leuko_care/feature/chats/logic/cubit/chat_state.dart';
import 'package:leuko_care/feature/chats/ui/widgets/chat_top_bar.dart';
import 'package:leuko_care/feature/chats/ui/widgets/chat_top_bar_shimmer.dart';
import 'package:leuko_care/feature/chats/ui/widgets/messages_shimmer.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';
import '../widgets/chat_input_field/chat_input_field.dart';
import '../widgets/messages_list.dart';

class ChatScreen extends StatefulWidget {
  final String currentUserId;
  final String otherUserId;
  final String userType; // 'doctor' or 'patient'
  final String? chatId;
  final String? initialMessage;
  final String? initialDoctorMessage;
  final Uint8List? initialDoctorImage;

  const ChatScreen({
    super.key,
    required this.currentUserId,
    required this.otherUserId,
    required this.userType,
    this.initialMessage,
    this.initialDoctorMessage,
    this.initialDoctorImage,
    this.chatId,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  DoctorModel? doctor;
  PatientModel? patient;

  @override
  void initState() {
    super.initState();
    var chatCubit = context.read<ChatCubit>();
    chatCubit.clearChatState();

    chatCubit.getMessages(
      senderId: widget.currentUserId,
      receiverId: widget.otherUserId,
    );
    chatCubit.monitorInternetAndDeletePendingMessages(
      widget.currentUserId,
      widget.otherUserId,
    );
    // chatCubit.clearLocalMessages( widget.currentUserId, widget.otherUserId);

    final chatId =
        widget.chatId ??
        ChatCubit.getChatId(widget.currentUserId, widget.otherUserId);
    chatCubit.setCurrentChatId(chatId);

    // تحديد الطرف الآخر وجلب بياناته
    if (widget.userType == 'patient') {
      chatCubit.getDoctorInfo(widget.otherUserId);
      // in patient screen i will asign chat id  to current chat id
      ChatSessionManager().currentChatId = null;
      chatCubit.markMessagesAsReadForPatient(
        widget.currentUserId,
        widget.otherUserId,
      );
    } else {
      context.read<ChatCubit>().getPatientInfo(widget.otherUserId);
      ChatSessionManager().currentChatId = chatId;
      chatCubit.markMessagesAsReadForDoctor(
        widget.currentUserId,
        widget.otherUserId,
      );
    }
  }

  @override
  void dispose() {
    ChatSessionManager().currentChatId = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            BlocBuilder<ChatCubit, ChatState>(
              buildWhen:
                  (prev, curr) =>
                      curr is ChatDoctorInfoLoaded ||
                      curr is ChatPatientInfoLoaded,
              builder: (context, state) {
                if (state is ChatDoctorInfoLoaded && doctor == null) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    setState(() {
                      doctor = state.doctor;
                    });
                  });
                }

                if (state is ChatPatientInfoLoaded && patient == null) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    setState(() {
                      patient = state.patient;
                    });
                  });
                }

                // إذا لم تكن البيانات جاهزة بعد، نعرض نسخة شيمر
                if ((widget.userType == 'patient' && doctor == null) ||
                    (widget.userType == 'doctor' && patient == null)) {
                  return ChatTopBarShimmer();
                }

                return ChatTopBar(doctor: doctor, patient: patient);
              },
            ),
            Expanded(
              child: BlocBuilder<ChatCubit, ChatState>(
                builder: (context, state) {
                  Widget child;

                  switch (state) {
                    case ChatLoading():
                      child = const MessagesShimmer();
                    case ChatSuccess(:final messages):
                      child = MessagesList(
                        messages: messages,
                        currentUserId: widget.currentUserId,
                      );
                    case ChatError(:final message):
                      child = Center(child: Text(message));
                    default:
                      child = const SizedBox.shrink();
                  }

                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    switchInCurve: Curves.easeOut,
                    switchOutCurve: Curves.easeIn,
                    child: KeyedSubtree(
                      // المفتاح مهم لكي يكتشف AnimatedSwitcher التغيير
                      key: ValueKey(state.runtimeType.toString()),
                      child: child,
                    ),
                  );
                },
              ),
            ),

            ChatInputField(
              currentUserId: widget.currentUserId,
              receiverId: widget.otherUserId,
              initialMessage: widget.initialMessage,
              initialDoctorMessage: widget.initialDoctorMessage,
              initialDoctorImage: widget.initialDoctorImage,
            ),
            SizedBox(height: HeightManager.h4),
          ],
        ),
      ),
    );
  }
}
