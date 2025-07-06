import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:leuko_care/core/helpers/time_formatter.dart';
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
              color: ColorsManager.white,
              borderRadius: BorderRadius.circular(RadiusManager.r12),
              boxShadow: [
                BoxShadow(
                  color: ColorsManager.lightBlue,
                  blurRadius: 5,
                  offset: Offset(1, 1),
                ),
              ],
              border: Border.all(
                color: ColorsManager.primaryColor.withValues(alpha: .3),
                width: 1,
              ),
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
                    hasUnread ? tr('unread_messages_from_doctor',namedArgs:{'doctorName': doctorName} ) : 'All messages are read'.tr(),
                    style: getMediumTextStyle(
                      fontSize: FontSizeManager.s14,
                      color: ColorsManager.darkBlue,
                    ),
                  ),
                  SizedBox(height: HeightManager.h4),
                  Text(
                    '${'last_message_was'.tr()} ${formatTimestampWithElapsed(lastMessageTime)}',
                    style: getRegularTextStyle(
                      fontSize: FontSizeManager.s13,
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


}