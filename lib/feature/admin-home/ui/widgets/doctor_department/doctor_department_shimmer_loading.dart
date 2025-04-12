import 'package:flutter/material.dart';
import 'package:leuko_care/core/resourses/colors_manager.dart';
import 'package:leuko_care/core/resourses/sizes_util_manager.dart';
import 'package:shimmer/shimmer.dart';

class DoctorDepartmentShimmerLoading extends StatelessWidget {
  const DoctorDepartmentShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: HeightManager.h100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 8,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsetsDirectional.only(start: index == 0 ? 0 : WidthManager.w24),
            child: Column(
              children: [
                Shimmer.fromColors(
                  baseColor: ColorsManager.lightGray,
                  highlightColor: Colors.white,
                  child: CircleAvatar(
                    radius: RadiusManager.r28,
                    backgroundColor: Colors.white,
                  ),
                ),
                SizedBox(height: HeightManager.h14),
                Shimmer.fromColors(
                  baseColor: ColorsManager.lightGray,
                  highlightColor: Colors.white,
                  child: Container(
                    height: HeightManager.h14,
                    width: WidthManager.w50,
                    decoration: BoxDecoration(
                      color: ColorsManager.lightGray,
                      borderRadius: BorderRadius.circular(RadiusManager.r12),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}