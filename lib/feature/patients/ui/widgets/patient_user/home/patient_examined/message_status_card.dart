import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';

class MessageStatusCard extends StatelessWidget {
  final DateTime lastMessageTime;
  final bool hasUnread;

  const MessageStatusCard({
    super.key,
    required this.lastMessageTime,
    required this.hasUnread,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: HeightManager.h12),
      padding: EdgeInsets.symmetric(
        horizontal: WidthManager.w14,
        vertical: HeightManager.h10,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(RadiusManager.r12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Icon(Icons.chat_bubble_outline, size: 20, color: ColorsManager.primaryColor),
          SizedBox(width: WidthManager.w10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Last message: ${_formatElapsedTime(lastMessageTime)}',
                  style: getRegularTextStyle(
                    fontSize: FontSizeManager.s14,
                    color: ColorsManager.darkBlue,
                  ),
                ),
                if (hasUnread)
                  Padding(
                    padding: EdgeInsets.only(top: HeightManager.h6),
                    child: Row(
                      children: [
                        Icon(Icons.circle, color: Colors.red, size: 8),
                        SizedBox(width: WidthManager.w6),
                        Text(
                          'You have unread messages',
                          style: getRegularTextStyle(
                            fontSize: FontSizeManager.s12,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 🔧 Elapsed time formatting logic
  String _formatElapsedTime(DateTime dt) {
    final now = DateTime.now();
    final diff = now.difference(dt);

    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes} min ago';
    if (diff.inHours < 24) return '${diff.inHours} hours ago';
    if (diff.inDays < 7) return '${diff.inDays} days ago';
    return DateFormat('d MMM y, h:mm a').format(dt);
  }
}