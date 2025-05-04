import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:leuko_care/core/helpers/extensions.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/routes/routes.dart';
import 'package:leuko_care/feature/chats/data/models/chat_model.dart';
import 'package:shimmer/shimmer.dart';

class ImageBubble extends StatelessWidget {
  final ChatModel message;
  final bool isMe;
  final VoidCallback onDelete;

  const ImageBubble({
    super.key,
    required this.message,
    required this.isMe,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(
          Routes.imagePreviewScreen,
          arguments: message.attachmentUrl,
        );
      },
      onLongPress: onDelete,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(RadiusManager.r18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 6,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(RadiusManager.r16),
          child: CachedNetworkImage(
            imageUrl: message.attachmentUrl,
            width: HeightManager.h200,
            height: HeightManager.h250,
            fit: BoxFit.cover,
            placeholder: (context, url) => _buildShimmerLoading(),
            errorWidget:
                (context, url, error) =>
                    const Icon(Icons.broken_image, size: 100),
          ),
        ),
      ),
    );
  }

  _buildShimmerLoading() {
    return Shimmer.fromColors(
      baseColor: ColorsManager.lightGray,
      highlightColor: ColorsManager.white,
      child: Container(
        width: HeightManager.h200,
        height: HeightManager.h250,
        color: Colors.white,
      ),
    );
  }
}
