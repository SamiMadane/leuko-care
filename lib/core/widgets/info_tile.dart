import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';

class InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? value;
  final Widget? valueWidget;
  final bool isMultiLine;

  const InfoTile({
    super.key,
    required this.icon,
    required this.label,
    this.value,
    this.valueWidget,
    this.isMultiLine = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: HeightManager.h12,
        horizontal: WidthManager.w16,
      ),
      decoration: BoxDecoration(
        color: ColorsManager.moreLighterGray,
        borderRadius: BorderRadius.circular(RadiusManager.r16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment:
            isMultiLine || valueWidget != null ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          Icon(icon, color: ColorsManager.primaryColor, size: 26),
          SizedBox(width: WidthManager.w16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: getSemiBoldTextStyle(
                    fontSize: FontSizeManager.s15,
                    color: ColorsManager.darkBlue,
                  ),
                ),
                SizedBox(height: HeightManager.h4),
                valueWidget ??
                    Text(
                      value ?? '',
                      style: getRegularTextStyle(
                        fontSize: FontSizeManager.s13,
                        color: ColorsManager.black87,
                      ),
                      maxLines: isMultiLine ? null : 1,
                      overflow: isMultiLine
                          ? TextOverflow.visible
                          : TextOverflow.ellipsis,
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
