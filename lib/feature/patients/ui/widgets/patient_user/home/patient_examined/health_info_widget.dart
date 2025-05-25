import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';

class HealthInfoWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const HealthInfoWidget({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(WidthManager.w16),
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(RadiusManager.r16),
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,  // لتوسيط المحتوى
        children: [
          Container(
            decoration: BoxDecoration(
              color: ColorsManager.lightBlue,
              shape: BoxShape.circle,
            ),
            padding: EdgeInsets.all(WidthManager.w12),
            child: Icon(
              icon,
              size: IconSizeManager.s28,
              color: ColorsManager.primaryColor,
            ),
          ),
          SizedBox(height: HeightManager.h12),
          Text(
            label,
            style: getSemiBoldTextStyle(
              fontSize: FontSizeManager.s16,
              color: ColorsManager.darkBlue,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: HeightManager.h6),
          Text(
            value,
            style: getMediumTextStyle(
              fontSize: FontSizeManager.s16,
              color: ColorsManager.primaryColor,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
