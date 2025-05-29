import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';

class AppDropdownFormField<T> extends StatelessWidget {
  final T? value;
  final String labelText;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?) onChanged;
  final String? Function(T?)? validator;
  final EdgeInsetsGeometry? contentPadding;
  final Color? backgroundColor;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextStyle? textStyle;

  const AppDropdownFormField({
    super.key,
    required this.value,
    required this.labelText,
    required this.items,
    required this.onChanged,
    this.validator,
    this.contentPadding,
    this.backgroundColor,
    this.focusedBorder,
    this.enabledBorder,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      items: items,
      onChanged: onChanged,
      validator: validator,
      style: textStyle ?? getMediumTextStyle(fontSize: FontSizeManager.s14, color: ColorsManager.darkBlue), 
          
      decoration: InputDecoration(
        isDense: true,
        contentPadding: contentPadding ??
            EdgeInsets.symmetric(
              horizontal: WidthManager.w20,
              vertical: HeightManager.h18,
            ),
        focusedBorder: focusedBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(
                color: ColorsManager.primaryColor,
                width: 1.3,
              ),
              borderRadius: BorderRadius.circular(RadiusManager.r16),
            ),
        enabledBorder: enabledBorder ??
            OutlineInputBorder(
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
        labelText: labelText,
        labelStyle: getMediumTextStyle(
          fontSize: FontSizeManager.s14,
          color: ColorsManager.primaryColor,
        ),
        fillColor: backgroundColor ?? ColorsManager.moreLightGray,
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      dropdownColor: Colors.white,
      iconEnabledColor: ColorsManager.primaryColor,
    );
  }
}
