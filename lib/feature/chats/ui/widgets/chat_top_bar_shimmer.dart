import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:shimmer/shimmer.dart';

class ChatTopBarShimmer extends StatelessWidget {
  const ChatTopBarShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.canPop(context);

    return Container(
      padding: EdgeInsets.symmetric(vertical: HeightManager.h8),
      child: Row(
        children: [
          if (canPop)
            IconButton(
              icon: const Icon(Icons.arrow_back),
              color: ColorsManager.darkBlue,
              onPressed: () => Navigator.pop(context),
            )
          else
            SizedBox(width: WidthManager.w20),

          Shimmer.fromColors(
            baseColor: ColorsManager.lightGray,
            highlightColor: Colors.white,
            child: CircleAvatar(
              radius: RadiusManager.r26,
              backgroundColor: Colors.white,
            ),
          ),
          SizedBox(width: WidthManager.w12),
          Shimmer.fromColors(
            baseColor: ColorsManager.lightGray,
            highlightColor: Colors.white,
            child: Container(
              height: HeightManager.h20,
              width: WidthManager.w100,
              color: Colors.white,
            ),
          ),

        ],
      ),
    );
  }
}
