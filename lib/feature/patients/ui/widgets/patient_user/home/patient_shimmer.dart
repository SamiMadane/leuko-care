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
      
          Shimmer.fromColors(
            baseColor: ColorsManager.lightGray,
            highlightColor: Colors.white,
            child: Container(
              height: HeightManager.h30, // زيادة الارتفاع لملء المساحة
              width: double.infinity, // ملء عرض الشاشة
              margin: EdgeInsets.symmetric(
                vertical: HeightManager.h16,
                horizontal: WidthManager.w16,
              ),
              color: Colors.white,
            ),
          ),
      
          // زيادة المسافة لتناسب المساحة المحجوزة
          SizedBox(height: HeightManager.h20),
      
          // إعادة تكبير الأبعاد لتملأ الشاشة
          _shimmerBox(height: HeightManager.h140),
          SizedBox(height: HeightManager.h20),
          _shimmerBox(height: HeightManager.h190),
          SizedBox(height: HeightManager.h20),
          _shimmerBox(height: HeightManager.h140),
          SizedBox(height: HeightManager.h20),
        ],
      ),
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
