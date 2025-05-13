import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';

class PatientShimmer extends StatelessWidget {
  const PatientShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HomeTopShimmer(),
          SizedBox(height: HeightManager.h20),

          _shimmerBox(height: HeightManager.h26, width: WidthManager.w260),
          SizedBox(height: HeightManager.h12),
          _shimmerBox(height: HeightManager.h26, width: WidthManager.w180),
      
          SizedBox(height: HeightManager.h30),
      
          // إعادة تكبير الأبعاد لتملأ الشاشة
          _shimmerBox(height: HeightManager.h80, width: double.infinity),
          SizedBox(height: HeightManager.h14),
          _shimmerBox(height: HeightManager.h54, width: double.infinity),
          SizedBox(height: HeightManager.h14),
          _shimmerBox(height: HeightManager.h54, width: double.infinity),
          SizedBox(height: HeightManager.h14),
           _shimmerBox(height: HeightManager.h54, width: double.infinity),
          SizedBox(height: HeightManager.h14),
           _shimmerBox(height: HeightManager.h54, width: double.infinity),
          SizedBox(height: HeightManager.h30),
          _shimmerBox(height: HeightManager.h28, width: WidthManager.w260),
          SizedBox(height: HeightManager.h12),
           _shimmerBox(height: HeightManager.h80, width: double.infinity),
  SizedBox(height: HeightManager.h30),
          _shimmerBox(height: HeightManager.h28, width: WidthManager.w260),
          SizedBox(height: HeightManager.h12),
           _shimmerBox(height: HeightManager.h300, width: double.infinity),

          
        ],
      ),
    );
  }

  Widget _shimmerBox({required double height,required double width}) {
    return Shimmer.fromColors(
      baseColor: ColorsManager.lightGray,
      highlightColor: Colors.white,
      child: Container(
        width: width,
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
                  radius: RadiusManager.r30,
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
                        width: WidthManager.w130, 
                        color: Colors.white,
                      ),
                      SizedBox(height: HeightManager.h8),
                      Container(
                        height: HeightManager.h14,
                        width: WidthManager.w200, 
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
