import 'package:dropdown_button2/dropdown_button2.dart';
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
    return DropdownButtonFormField2<T>(
      value: value,
      items: items,
      onChanged: onChanged,
      validator: validator,
      isExpanded: true,
      style:
          textStyle ??
          getMediumTextStyle(
            fontSize: FontSizeManager.s14,
            color: ColorsManager.darkBlue,
          ),

      // القائمة المنسدلة
      dropdownStyleData: DropdownStyleData(
        maxHeight: 250,
        offset: const Offset(0, 5),
        padding: EdgeInsets.symmetric(vertical: HeightManager.h8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(RadiusManager.r12),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
      ),
     
      // المدخل النصي (label + borders)
      decoration: InputDecoration(
        isDense: true,
        labelText: labelText,
        labelStyle: getMediumTextStyle(
          fontSize: FontSizeManager.s14,
          color: ColorsManager.primaryColor,
        ),

        floatingLabelBehavior: FloatingLabelBehavior.always,
        fillColor: backgroundColor ?? ColorsManager.moreLightGray,
        filled: true,
        contentPadding:
            contentPadding ??
            EdgeInsets.symmetric(
              horizontal: WidthManager.w20,
              vertical: HeightManager.h16,
            ),
        enabledBorder:
            enabledBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(
                color: ColorsManager.lighterGray,
                width: 1.3,
              ),
              borderRadius: BorderRadius.circular(RadiusManager.r16),
            ),
        focusedBorder:
            focusedBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(
                color: ColorsManager.primaryColor,
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
      ),
    );
  }
}
