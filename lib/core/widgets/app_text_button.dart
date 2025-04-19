import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';

class AppTextButton extends StatelessWidget {
  final double? borderRadius;
  final String? backgroundImage; // المسار إلى الصورة
  final Color? backgroundColor;
  final double? horizontalPadding;
  final double? verticalPadding;
  final double? buttonWidth;
  final double? buttonHeight;
  final String buttonText;
  final TextStyle textStyle;
  final VoidCallback onPressed;

  const AppTextButton({
    super.key,
    this.borderRadius,
    this.backgroundImage,
    this.backgroundColor,
    this.horizontalPadding,
    this.verticalPadding,
    this.buttonHeight,
    this.buttonWidth,
    required this.buttonText,
    required this.textStyle,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(borderRadius ?? RadiusManager.r16),
      onTap: onPressed,
      child: Container(
        width: buttonWidth?.w ?? double.infinity,
        height: buttonHeight ?? HeightManager.h50,
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding?.w ?? WidthManager.w12,
          vertical: verticalPadding?.h ?? HeightManager.h14,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? RadiusManager.r16),
          color: backgroundImage == null ? backgroundColor ?? ColorsManager.primaryColor : null,
          image: backgroundImage != null
              ? DecorationImage(
                  image: AssetImage(backgroundImage!),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        alignment: Alignment.center,
        child: Text(
          buttonText,
          style: textStyle,
        ),
      ),
    );
  }
}
