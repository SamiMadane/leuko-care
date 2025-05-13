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
      margin: EdgeInsets.only(bottom: HeightManager.h12),
      padding: EdgeInsets.symmetric(
        vertical: HeightManager.h16,
        horizontal: WidthManager.w16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(RadiusManager.r12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, size: 24, color: ColorsManager.primaryColor),
          SizedBox(width: WidthManager.w12),
          Expanded(
            child: Text(
              label,
              style: getSemiBoldTextStyle(
                fontSize: FontSizeManager.s15,
                color: ColorsManager.darkBlue,
              ),
            ),
          ),
          Text(
            value,
            style: getMediumTextStyle(
              fontSize: FontSizeManager.s15,
              color: ColorsManager.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
