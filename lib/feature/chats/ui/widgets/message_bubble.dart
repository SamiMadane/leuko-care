import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import '../../data/models/chat_model.dart';

class MessageBubble extends StatelessWidget {
  final ChatModel message;
  final bool isMe;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isMe,
  });

void _showFullImage(BuildContext context, String imageUrl) {
  showDialog(
    context: context,
    builder: (_) => Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          InteractiveViewer(
            child: Image.network(imageUrl),
          ),
          IconButton(
            icon: Icon(Icons.close, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    final alignment = isMe ? Alignment.centerRight : Alignment.centerLeft;
    final color = isMe ? Colors.blueAccent : Colors.grey[300];
    final textColor = isMe ? Colors.white : Colors.black87;


    return Align(
      alignment: alignment,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),  // زيادة المسافة بين الرسائل
        child: Column(
          crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            // عرض النص في فقاعة إذا كان موجودًا
            if (message.text.isNotEmpty)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                constraints: const BoxConstraints(maxWidth: 280), // لتقييد حجم الفقاعة
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [  // إضافة الظل للفقاعة
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 6,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Text(
                  message.text,
                  style: getMediumTextStyle(fontSize: FontSizeManager.s16, color: textColor),
                ),
              ),
            
            // مسافة بين النص والصورة إذا كان هناك صورة
            if (message.text.isNotEmpty && message.attachmentUrl.isNotEmpty)
              const SizedBox(height: 8), 

            // عرض الصورة إذا كانت موجودة، بدون فقاعة
            if (message.attachmentUrl.isNotEmpty)
              GestureDetector(
                onTap: () => _showFullImage(context, message.attachmentUrl),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container( // لتعديل حجم الصورة والحد من المساحة حولها
                    margin:  EdgeInsets.only(top: 4),  // إضافة هامش أعلى الصورة
                    child: Image.network(
                      message.attachmentUrl,
                      height: HeightManager.h270,
                      width: HeightManager.h200,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.broken_image, size: 100),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
