import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/feature/chats/logic/cubit/chat_cubit.dart';
import 'package:leuko_care/feature/chats/logic/cubit/chat_state.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
import '../widgets/chat_input_field/chat_input_field.dart';
import '../widgets/messages_list.dart';

class ChatScreen extends StatefulWidget {
  final String currentUserId;
  final String otherUserId;
  final DoctorModel doctor;

  const ChatScreen({
    super.key,
    required this.currentUserId,
    required this.otherUserId,
    required this.doctor,
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
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Row(
              children: [
                CircleAvatar(
                  radius: RadiusManager.r28,
                  backgroundImage: NetworkImage(widget.doctor.profileImage),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Dr. ${widget.doctor.name}',
                    style: TextStyle(
                      color: ColorsManager.darkBlue,
                      fontSize: FontSizeManager.s20,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                return switch (state) {
                  ChatLoading() => CustomLoader(),
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
          ),
          SizedBox(height: HeightManager.h4),
        ],
      ),
    );
  }

  CustomLoader() {
    return Center(
      child: SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 3,
          valueColor: AlwaysStoppedAnimation<Color>(
            Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
