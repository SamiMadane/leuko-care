import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';

TextStyle _getTextStyle(
  double fontSize,
  FontWeight fontWeight,
  Color color,
  TextDecoration decoration,
  dynamic overflow,
  double height,
  String? fontFamily,
) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: fontFamily ?? FontFamilyManager.getFontFamily(),
    fontWeight: fontWeight,
    color: color,
    decoration: decoration,
    overflow: overflow,
    height: height,
  );
}


// Regular TextStyle
TextStyle getRegularTextStyle({
  required double fontSize,
  required Color color,
  String? fontFamily,
  dynamic overflow = TextOverflow.visible,
  TextDecoration decoration = TextDecoration.none,
  double? height,
}) {
  return _getTextStyle(
    fontSize,
    FontWeightManager.regular,
    color,
    decoration,
    overflow,
    height ?? 1.0,
    fontFamily,
  );
}

TextStyle getMediumTextStyle({
  required double fontSize,
  required Color color,
  String? fontFamily,
  TextDecoration decoration = TextDecoration.none,
  dynamic overflow = TextOverflow.visible,
  double? height,
}) {
  return _getTextStyle(
    fontSize,
    FontWeightManager.medium,
    color,
    decoration,
    overflow,
    height ?? 1.0,
    fontFamily,
  );
}

TextStyle getSemiBoldTextStyle({
  required double fontSize,
  required Color color,
  String? fontFamily,
  TextDecoration decoration = TextDecoration.none,
  dynamic overflow = TextOverflow.visible,
  double? height,
}) {
  return _getTextStyle(
    fontSize,
    FontWeightManager.semiBold,
    color,
    decoration,
    overflow,
    height ?? 1.0,
    fontFamily,
  );
}

TextStyle getBoldTextStyle({
  required double fontSize,
  required Color color,
  String? fontFamily,
  TextDecoration decoration = TextDecoration.none,
  dynamic overflow = TextOverflow.visible,
  double? height,
}) {
  return _getTextStyle(
    fontSize,
    FontWeightManager.bold,
    color,
    decoration,
    overflow,
    height ?? 1.0,
    fontFamily,
  );
}
