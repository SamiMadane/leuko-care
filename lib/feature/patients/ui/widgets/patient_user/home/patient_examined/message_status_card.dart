import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
class MessageStatusCard extends StatelessWidget {
  final DateTime lastMessageTime;
  final bool hasUnread;
  final String doctorName;

  const MessageStatusCard({
    super.key,
    required this.lastMessageTime,
    required this.hasUnread, required this.doctorName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: WidthManager.w20),
      child: Container(
        decoration: BoxDecoration(
          color: ColorsManager.lightBlue,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: ColorsManager.primaryColor, width: 1),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: WidthManager.w16,
          vertical: HeightManager.h12,
        ),
        child: Row(
          children: [
            const Icon(Icons.chat_bubble_outline, color: ColorsManager.primaryColor),
            SizedBox(width: WidthManager.w12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hasUnread ? 'You have unread messages from Dr.$doctorName' : 'All messages are read',
                    style: getMediumTextStyle(
                      fontSize: FontSizeManager.s14,
                      color: ColorsManager.darkBlue,
                    ),
                  ),
                  SizedBox(height: HeightManager.h4),
                  Text(
                    'Last message: ${_formatDateTime(lastMessageTime)}',
                    style: getRegularTextStyle(
                      fontSize: FontSizeManager.s12,
                      color: ColorsManager.gray
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

String _formatDateTime(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.inSeconds < 60) {
    return 'just now';
  } else if (difference.inMinutes < 60) {
    final m = difference.inMinutes;
    return '$m minute${m == 1 ? '' : 's'} ago';
  } else if (difference.inHours < 24) {
    final h = difference.inHours;
    return '$h hour${h == 1 ? '' : 's'} ago';
  } else if (difference.inDays == 1) {
    return 'yesterday';
  } else if (difference.inDays < 7) {
    final d = difference.inDays;
    return '$d day${d == 1 ? '' : 's'} ago';
  } else {
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }
}


}
