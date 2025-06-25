import 'package:easy_localization/easy_localization.dart';


import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';

Widget resultInfoRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Text('$label: '.tr(), style: getBoldTextStyle(fontSize: FontSizeManager.s15, color: ColorsManager.darkBlue)),
        Expanded(child: Text(value, overflow: TextOverflow.ellipsis,style: getRegularTextStyle(fontSize: FontSizeManager.s13, color: ColorsManager.darkBlue,height: HeightManager.h1_1),)),
      ],
    ),
  );
}