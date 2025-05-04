import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:leuko_care/core/helpers/extensions.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/core/routes/routes.dart';
import 'package:leuko_care/feature/chats/data/models/chat_model.dart';
import 'package:shimmer/shimmer.dart';

class TextAndImageBubble extends StatelessWidget {
  final ChatModel message;
  final bool isMe;
  final VoidCallback onDelete;

  const TextAndImageBubble({
    super.key,
    required this.message,
    required this.isMe,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final color = isMe ? ColorsManager.primaryColor : Colors.grey[300];
    final textColor = isMe ? ColorsManager.white : ColorsManager.darkBlue;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: HeightManager.h4,
        horizontal: WidthManager.w4,
      ),
      constraints: BoxConstraints(maxWidth: WidthManager.w260),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(RadiusManager.r18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 6,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              context.pushNamed(Routes.imagePreviewScreen, arguments: message.attachmentUrl);
            },
            onLongPress: onDelete,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(RadiusManager.r14),
              child: CachedNetworkImage(
                imageUrl: message.attachmentUrl,
                width: double.infinity,
                height: HeightManager.h170,
                fit: BoxFit.cover,
                placeholder: (context, url) => _buildShimmerLoading(),
                errorWidget: (context, url, error) => const Icon(Icons.broken_image, size: 100),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: WidthManager.w10,
              vertical: HeightManager.h8,
            ),
            child: Text(
              message.text,
              style: getMediumTextStyle(
                fontSize: FontSizeManager.s15,
                color: textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  _buildShimmerLoading() {
    return Shimmer.fromColors(
      baseColor: ColorsManager.lightGray,
      highlightColor: ColorsManager.white,
      child: Container(
        height: HeightManager.h170,
        color: Colors.white,
      ),
    );
  }
}
