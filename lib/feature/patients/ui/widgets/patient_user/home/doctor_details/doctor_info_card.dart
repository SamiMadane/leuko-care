import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';

class DoctorInfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final bool isMultiline;

  const DoctorInfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    this.isMultiline = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(RadiusManager.r16),
      ),
      elevation: 2,
      margin: EdgeInsets.only(bottom: HeightManager.h16),
      child: Padding(
        padding: EdgeInsets.all(HeightManager.h16),
        child: Row(
          crossAxisAlignment: isMultiline ? CrossAxisAlignment.start : CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(HeightManager.h8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorsManager.primaryColor.withOpacity(0.1),
              ),
              child: Icon(icon, color: ColorsManager.primaryColor, size: FontSizeManager.s20),
            ),
            SizedBox(width: WidthManager.w16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: getSemiBoldTextStyle(
                      fontSize: FontSizeManager.s16,
                      color: ColorsManager.darkBlue,
                    ),
                  ),
                  SizedBox(height: HeightManager.h6),
                  Text(
                    value,
                    style: getRegularTextStyle(
                      fontSize: FontSizeManager.s14,
                      color: ColorsManager.black87,
                    ),
                    maxLines: isMultiline ? null : 1,
                    overflow: isMultiline ? TextOverflow.visible : TextOverflow.ellipsis,
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
