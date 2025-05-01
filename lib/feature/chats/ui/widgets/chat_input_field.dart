import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/feature/chats/logic/cubit/chat_cubit.dart';
import '../../data/models/chat_model.dart';

class ChatInputField extends StatefulWidget {
  final String currentUserId;
  final String receiverId;

  const ChatInputField({
    super.key,
    required this.currentUserId,
    required this.receiverId,
  });

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    final message = ChatModel(
      id: '', // سيتم إنشاؤه تلقائيًا عند الإضافة
      senderId: widget.currentUserId,
      receiverId: widget.receiverId,
      text: text,
      timestamp: Timestamp.now(),

      attachmentUrl: '', // في حال أردت دعم الصور لاحقًا
    );

    context.read<ChatCubit>().sendMessage(message);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: "Type a message...",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(onPressed: _sendMessage, icon: const Icon(Icons.send)),
          ],
        ),
      ),
    );
  }
}
