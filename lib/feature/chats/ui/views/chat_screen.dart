import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/feature/chats/logic/cubit/chat_cubit.dart';
import 'package:leuko_care/feature/chats/logic/cubit/chat_state.dart';
import '../widgets/chat_input_field.dart';
import '../widgets/messages_list.dart';

class ChatScreen extends StatefulWidget {
  final String currentUserId;
  final String otherUserId;

  const ChatScreen({
    super.key,
    required this.currentUserId,
    required this.otherUserId,
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
      appBar: AppBar(title: const Text("Chat")),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                return switch (state) {
                  ChatLoading() =>  CustomLoader(),
                  ChatSuccess(:final messages) =>
                    MessagesList(messages: messages, currentUserId: widget.currentUserId),
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
        ],
      ),
    );
  }
  CustomLoader() {
    return  Center(
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
