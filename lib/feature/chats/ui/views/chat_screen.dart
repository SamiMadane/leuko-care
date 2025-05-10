import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/feature/chats/logic/cubit/chat_cubit.dart';
import 'package:leuko_care/feature/chats/logic/cubit/chat_state.dart';
import 'package:leuko_care/feature/chats/ui/widgets/chat_top_bar.dart';
import 'package:leuko_care/feature/chats/ui/widgets/messages_shimmer.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';
import '../widgets/chat_input_field/chat_input_field.dart';
import '../widgets/messages_list.dart';

class ChatScreen extends StatefulWidget {
  final String currentUserId;
  final String otherUserId;
  final DoctorModel? doctor;
  final PatientModel? patient;
  final String? initialMessage;
  final Uint8List? initialImage;

  const ChatScreen({
    super.key,
    required this.currentUserId,
    required this.otherUserId,
    this.doctor,
    this.initialMessage,
    this.patient, this.initialImage,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ChatCubit>().getMessages(
      senderId: widget.currentUserId,
      receiverId: widget.otherUserId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ChatTopBar(doctor: widget.doctor, patient: widget.patient),
            Expanded(
              child: BlocBuilder<ChatCubit, ChatState>(
                builder: (context, state) {
                  return switch (state) {
                    ChatLoading() => MessagesShimmer(),
                    ChatSuccess(:final messages) => MessagesList(
                      messages: messages,
                      currentUserId: widget.currentUserId,
                    ),
                    ChatError(:final message) => Center(child: Text(message)),
                    _ => const SizedBox(),
                  };
                },
              ),
            ),
            ChatInputField(
              currentUserId: widget.currentUserId,
              receiverId: widget.otherUserId,
              initialMessage: widget.initialMessage,
              initialImage: widget.initialImage,
            ),
            SizedBox(height: HeightManager.h4),
          ],
        ),
      ),
    );
  }
}
