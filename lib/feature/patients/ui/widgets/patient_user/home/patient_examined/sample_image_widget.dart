import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/core/widgets/image_preview_screen.dart';

class SampleImageWidget extends StatelessWidget {
  final String imageUrl;

  const SampleImageWidget({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ImagePreviewScreen(imageUrl: imageUrl),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: HeightManager.h12),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(RadiusManager.r12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            SizedBox(width: WidthManager.w16),
            Expanded(
              child: Text(
                "Latest Sample Image",
                style: getSemiBoldTextStyle(
                  fontSize: FontSizeManager.s15,
                  color: ColorsManager.darkBlue,
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(RadiusManager.r8),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.contain,
                placeholder: (context, url) => _buildShimmerPlaceholder(),
                errorWidget: (context, url, error) => const Icon(
                  Icons.broken_image,
                  size: 40,
                  color: ColorsManager.white,
                ),
              ),
            ),
            SizedBox(width: WidthManager.w16),
            Icon(Icons.touch_app_outlined, color: ColorsManager.primaryColor),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerPlaceholder() {
    return Container(
      width: 80,
      height: 80,
      color: ColorsManager.lightGray,
    );
  }
}
