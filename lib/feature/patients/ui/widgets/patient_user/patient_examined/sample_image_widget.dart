import 'package:easy_localization/easy_localization.dart';

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
        padding: EdgeInsets.symmetric(
          vertical: HeightManager.h12,
          horizontal: WidthManager.w16,
        ),
        decoration: BoxDecoration(
          color: ColorsManager.white,
          borderRadius: BorderRadius.circular(RadiusManager.r16),
          boxShadow: [
            BoxShadow(
              color: ColorsManager.primaryColor.withValues(alpha: .2),
              blurRadius: 5,
              offset: Offset(1, 1),
            ),
          ],
          border: Border.all(
            color: ColorsManager.primaryColor.withValues(alpha: .3),
            width: 1,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: WidthManager.w8),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Latest Sample Image'.tr(),
                  style: getSemiBoldTextStyle(
                    fontSize: FontSizeManager.s15,
                    color: ColorsManager.darkBlue,
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(RadiusManager.r12),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => _buildShimmerPlaceholder(),
                  errorWidget: (context, url, error) => Container(
                    width: 80,
                    height: 80,
                    color: ColorsManager.primaryColor.withValues(alpha: .1),
                    child: const Icon(
                      Icons.broken_image,
                      size: 40,
                      color: ColorsManager.primaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(width: WidthManager.w16),
              Icon(Icons.touch_app_outlined, color: ColorsManager.primaryColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerPlaceholder() {
    return Container(
      width: 80,
      height: 80,
      color: ColorsManager.primaryColor.withValues(alpha: .1),
    );
  }
}