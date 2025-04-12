import 'package:flutter/material.dart';
import 'package:leuko_care/core/resourses/assets_manager.dart';
import 'package:leuko_care/core/resourses/colors_manager.dart';
import 'package:leuko_care/core/resourses/fonts_manager.dart';
import 'package:leuko_care/core/resourses/sizes_util_manager.dart';
import 'package:leuko_care/core/resourses/styles_manager.dart';

class DoctorsBlueContainer extends StatelessWidget {
  const DoctorsBlueContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: HeightManager.h200,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: double.infinity,
            height: HeightManager.h170,
            padding: EdgeInsets.symmetric(
              horizontal: WidthManager.w16,
              vertical: HeightManager.h16,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(RadiusManager.r24),
              image: DecorationImage(
                image: AssetImage(AssetsManager.homeBluePattern),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: HeightManager.h6),
                Text(
                  'Admin Dashboard',
                  style: getBoldTextStyle(
                    fontSize: FontSizeManager.s18,
                    color: ColorsManager.white,
                  ),
                ),
                SizedBox(height: HeightManager.h10),
                Text(
                  'Full access\nTo manage\nDoctors & Patients.',
                  style: getSemiBoldTextStyle(
                    fontSize: FontSizeManager.s17,
                    color: ColorsManager.white,
                    height: HeightManager.h1_5,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: WidthManager.w1,
            top: HeightManager.h20,
            child: Image.asset(
              AssetsManager.admin1,
              height: HeightManager.h180,
            ),
          ),
        ],
      ),
    );
  }
}
