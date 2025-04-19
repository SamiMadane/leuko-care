import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';

class AppTextFormField extends StatelessWidget {
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;
  final String labelText;  // فقط labelText بدون hintText
  final TextEditingController? controller;
  final bool? isObscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? backgroundColor;
  final int? maxLines;
  final TextInputType? keyboardType;
  final Function(String?) validator;

  const AppTextFormField({
    super.key,
    this.contentPadding,
    this.focusedBorder,
    this.enabledBorder,
    this.inputTextStyle,
    this.hintStyle,
    required this.labelText,  // تغيير من hintText إلى labelText
    this.isObscureText,
    this.suffixIcon,
    this.prefixIcon,
    this.backgroundColor,
    this.maxLines,
    this.keyboardType,
    required this.validator,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines ?? 1,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: contentPadding ?? EdgeInsets.symmetric(
          horizontal: WidthManager.w20,
          vertical: HeightManager.h18,
        ),
        focusedBorder: focusedBorder ?? OutlineInputBorder(
          borderSide: const BorderSide(
            color: ColorsManager.primaryColor,
            width: 1.3,
          ),
          borderRadius: BorderRadius.circular(RadiusManager.r16),
        ),
        enabledBorder: enabledBorder ?? OutlineInputBorder(
          borderSide: const BorderSide(
            color: ColorsManager.lighterGray,
            width: 1.3,
          ),
          borderRadius: BorderRadius.circular(RadiusManager.r16),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1.3),
          borderRadius: BorderRadius.circular(RadiusManager.r16),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ColorsManager.red, width: 1.3),
          borderRadius: BorderRadius.circular(RadiusManager.r16),
        ),
        labelText: labelText,  // النص المثبت في الأعلى
        labelStyle: getMediumTextStyle(
          fontSize: FontSizeManager.s14,
          color: ColorsManager.primaryColor,  // اللون الأزرق دائمًا
        ),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        fillColor: backgroundColor ?? ColorsManager.moreLightGray,
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.always,  // هذه الخاصية تضمن ظهور الـ label دائمًا فوق الحقل
      ),
      obscureText: isObscureText ?? false,
      style: getMediumTextStyle(
        fontSize: IconSizeManager.s14,
        color: ColorsManager.darkBlue,
      ),
      validator: (value) {
        return validator(value);
      },
    );
  }
}
