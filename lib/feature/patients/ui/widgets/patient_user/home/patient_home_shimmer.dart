import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';

class PatientHomeShimmer extends StatelessWidget {
  const PatientHomeShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HomeTopShimmer(),

        // العنوان تحت الهيدر
        Shimmer.fromColors(
          baseColor: ColorsManager.lightGray,
          highlightColor: Colors.white,
          child: Container(
            height: HeightManager.h24,
            width: 180,
            margin: EdgeInsets.symmetric(
              vertical: HeightManager.h16,
              horizontal: WidthManager.w16,
            ),
            color: Colors.white,
          ),
        ),

        SizedBox(height: HeightManager.h20),

        // العناصر الصحية
        _shimmerBox(height: 100),
        SizedBox(height: HeightManager.h16),
        _shimmerBox(height: 140),
        SizedBox(height: HeightManager.h16),
        _shimmerBox(height: 100),
      ],
    );
  }

  Widget _shimmerBox({required double height}) {
    return Shimmer.fromColors(
      baseColor: ColorsManager.lightGray,
      highlightColor: Colors.white,
      child: Container(
        width: double.infinity,
        height: height,
        margin: EdgeInsets.symmetric(horizontal: WidthManager.w12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(RadiusManager.r16),
        ),
      ),
    );
  }
}

class HomeTopShimmer extends StatelessWidget {
  const HomeTopShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: WidthManager.w16,
            vertical: HeightManager.h20,
          ),
          child: Row(
            children: [
              Shimmer.fromColors(
                baseColor: ColorsManager.lightGray,
                highlightColor: Colors.white,
                child: CircleAvatar(
                  radius: RadiusManager.r34,
                  backgroundColor: Colors.white,
                ),
              ),
              SizedBox(width: WidthManager.w12),

              Expanded(
                child: Shimmer.fromColors(
                  baseColor: ColorsManager.lightGray,
                  highlightColor: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: HeightManager.h16,
                        width: 120,
                        color: Colors.white,
                      ),
                      SizedBox(height: HeightManager.h8),
                      Container(
                        height: HeightManager.h14,
                        width: 180,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),

              Shimmer.fromColors(
                baseColor: ColorsManager.lightGray,
                highlightColor: Colors.white,
                child: Icon(Icons.logout, color: Colors.grey, size: 28),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: WidthManager.w80,
            right: WidthManager.w20,
          ),

          child: Divider(color: ColorsManager.lightGray, thickness: 1),
        ),
      ],
    );
  }
}
