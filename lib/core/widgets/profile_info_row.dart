import 'package:flutter/widgets.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';

class ProfileInfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  const ProfileInfoRow({super.key, required this.icon, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: WidthManager.w20,
        vertical: HeightManager.h10,
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: HeightManager.h8,
              horizontal: WidthManager.w8,
            ),
            decoration: BoxDecoration(
              color: ColorsManager.primaryColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: ColorsManager.primaryColor,
              size: FontSizeManager.s20,
            ),
          ),
          SizedBox(width: WidthManager.w16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: getMediumTextStyle(
                    fontSize: FontSizeManager.s14,
                    color: ColorsManager.darkBlue,
                  ),
                ),
                SizedBox(height: HeightManager.h6),
                Text(
                  value,
                  style: getRegularTextStyle(
                    fontSize: FontSizeManager.s14,
                    color: ColorsManager.gray,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
