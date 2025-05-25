import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/feature/chats/logic/cubit/chat_cubit.dart';
import 'package:leuko_care/feature/chats/ui/widgets/chat_input_field/image_preview_thumbnail.dart';
import 'package:leuko_care/feature/chats/ui/widgets/chat_input_field/message_text_field.dart';

class ChatInputField extends StatefulWidget {
  final String currentUserId;
  final String receiverId;
  final String? initialMessage;
  final String? initialDoctorMessage;
  final Uint8List? initialDoctorImage;

  const ChatInputField({
    super.key,
    required this.currentUserId,
    required this.receiverId,
    this.initialMessage,
    this.initialDoctorMessage,
    this.initialDoctorImage,
  });

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  final TextEditingController _controller = TextEditingController();
  String? _selectedImagePath;
  bool _showEmojiPicker = false;
  Uint8List? _localInitialImage;

@override
void initState() {
  super.initState();
  _localInitialImage = widget.initialDoctorImage;
}

  
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() => _selectedImagePath = pickedFile.path);
    }
  }

void _sendMessage() {
  final text = _controller.text.trim();
  if (text.isEmpty && _selectedImagePath == null && _localInitialImage == null) return;

  context.read<ChatCubit>().sendMessageWithOptionalImageAndText(
    senderId: widget.currentUserId,
    receiverId: widget.receiverId,
    text: text,
    imagePath: _selectedImagePath,
    imageBytes: _localInitialImage,
  );

  _controller.clear();
  setState(() {
    _selectedImagePath = null;
    _localInitialImage = null;
  });
}


  @override
  Widget build(BuildContext context) {
    
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        if (_showEmojiPicker) {
          setState(() => _showEmojiPicker = false);
          return false;
        }
        return true;
      },
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: WidthManager.w10,
            vertical: HeightManager.h8,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_selectedImagePath != null ||
                  _localInitialImage != null)
                ImagePreviewThumbnail(
                  imagePath: _selectedImagePath,
                  initialDoctorImage: widget.initialDoctorImage,
                  onRemove: () => setState(() {
                    _selectedImagePath = null;
                    _localInitialImage = null;
                  } ),
                ),

              Row(
                children: [
                  IconButton(
                    onPressed: () => _showImagePickerDialog(),
                    icon: const Icon(
                      Icons.add,
                      color: ColorsManager.primaryColor,
                    ),
                  ),
                  Expanded(
                    child: MessageTextField(
                      controller: _controller,
                      initialMessage: widget.initialMessage,
                      initialDoctorMessage: widget.initialDoctorMessage,
                      onEmojiToggle: () {
                        setState(() => _showEmojiPicker = !_showEmojiPicker);
                      },
                    ),
                  ),
                  SizedBox(width: WidthManager.w6),
                  IconButton(
                    onPressed: _sendMessage,
                    icon: const Icon(
                      Icons.send,
                      color: ColorsManager.primaryColor,
                    ),
                  ),
                ],
              ),
              if (_showEmojiPicker)
                SizedBox(
                  height: HeightManager.h250,
                  child: EmojiPicker(
                    onEmojiSelected: (category, emoji) {
                      setState(() => _controller.text += emoji.emoji);
                    },
                    textEditingController: _controller,
                    config: Config(
                      height: HeightManager.h250,
                      checkPlatformCompatibility: true,
                      emojiViewConfig: EmojiViewConfig(
                        emojiSizeMax:
                            28 *
                            (foundation.defaultTargetPlatform ==
                                    TargetPlatform.iOS
                                ? 1.20
                                : 1.0),
                      ),
                      viewOrderConfig: const ViewOrderConfig(
                        top: EmojiPickerItem.categoryBar,
                        middle: EmojiPickerItem.emojiView,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _showImagePickerDialog() {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Choose an option'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('Camera'),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.image),
                  title: const Text('Gallery'),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.gallery);
                  },
                ),
              ],
            ),
          ),
    );
  }
}
