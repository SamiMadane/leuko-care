import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:shimmer/shimmer.dart';

class MessagesShimmer extends StatelessWidget {
  const MessagesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final itemCount = 10;

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(
              horizontal: WidthManager.w16,
              vertical: HeightManager.h12,
            ),
            itemCount: itemCount,
            itemBuilder: (_, index) {
              final isSender = index % 2 != 0;
              final isLast = index == itemCount - 1;
              final width = 100.0 + (index % 3) * 50;
              final height = isLast ? HeightManager.h220 : HeightManager.h26;

              return Padding(
                padding: EdgeInsets.symmetric(vertical: HeightManager.h6),
                child: Shimmer.fromColors(
                  baseColor: ColorsManager.lightGray,
                  highlightColor: Colors.white,
                  child: Align(
                    alignment:
                        isSender ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      width: isLast ? WidthManager.w200 : width,
                      height: height,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(RadiusManager.r10),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        // ✅ النص أسفل الشيمر
        Padding(
          padding: EdgeInsets.only(
            bottom: HeightManager.h10,
            top: HeightManager.h10,
          ),
          child: Text(
            "Loading messages ...".tr(),
            style: getRegularTextStyle(fontSize: FontSizeManager.s13, color: ColorsManager.gray)
          ),
        ),
      ],
    );
  }
}
