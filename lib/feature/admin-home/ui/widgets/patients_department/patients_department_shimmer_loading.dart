import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:shimmer/shimmer.dart';

class PatientsDepartmentShimmerLoading extends StatelessWidget {
  const PatientsDepartmentShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(bottom: WidthManager.w16),
            child: Row(
              children: [
                Shimmer.fromColors(
                  baseColor: ColorsManager.lightGray,
                  highlightColor: Colors.white,
                  child: Container(
                    width: WidthManager.w110,
                    height: HeightManager.h120,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(12.0),
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: WidthManager.w16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Shimmer.fromColors(
                        baseColor: ColorsManager.lightGray,
                        highlightColor: Colors.white,
                        child: Container(
                          height: HeightManager.h18,
                          width: WidthManager.w180,
                          decoration: BoxDecoration(
                            color: ColorsManager.lightGray,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      SizedBox(height: HeightManager.h12),
                      Shimmer.fromColors(
                        baseColor: ColorsManager.lightGray,
                        highlightColor: Colors.white,
                        child: Container(
                          height: HeightManager.h14,
                          width: WidthManager.w160,
                          decoration: BoxDecoration(
                            color: ColorsManager.lightGray,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      SizedBox(height: HeightManager.h12),
                      Shimmer.fromColors(
                        baseColor: ColorsManager.lightGray,
                        highlightColor: Colors.white,
                        child: Container(
                          height: HeightManager.h14,
                          width: WidthManager.w160,
                          decoration: BoxDecoration(
                            color: ColorsManager.lightGray,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
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