import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:shimmer/shimmer.dart';

class MessagesShimmer extends StatelessWidget {
  const MessagesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final itemCount = 10;

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: WidthManager.w16, vertical: HeightManager.h10),
      itemCount: itemCount,
      itemBuilder: (_, index) {
        final isSender = index % 2 != 0;
        final isLast = index == itemCount - 1;
        final width = 100.0 + (index % 3) * 50;

        final height = isLast ? HeightManager.h250 : HeightManager.h24;

        return Padding(
          padding: EdgeInsets.symmetric(vertical: HeightManager.h4),
          child: Shimmer.fromColors(
            baseColor: ColorsManager.lightGray,
            highlightColor: Colors.white,
            child: Align(
              alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: isLast ? WidthManager.w200 : width,
                height: height,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(RadiusManager.r12),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
