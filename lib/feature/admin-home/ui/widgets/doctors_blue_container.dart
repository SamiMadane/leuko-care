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
      height: HeightManager.h195,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: double.infinity,
            height: HeightManager.h165,
            padding: EdgeInsets.symmetric(
              horizontal: WidthManager.w16,
              vertical: HeightManager.h16,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(RadiusManager.r24),
              image:  DecorationImage(
                image: AssetImage(AssetsManager.homeBluePattern),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Book and\nschedule with\nnearest doctor',
                  style: getMediumTextStyle(fontSize: FontSizeManager.s18, color: ColorsManager.white,height: HeightManager.h1_3),
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: HeightManager.h16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(48.0),
                      ),
                    ),
                    child: Text(
                      'Find Nearby',
                      style:  getRegularTextStyle(fontSize: FontSizeManager.s12, color: ColorsManager.primaryColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: WidthManager.w2,
            top: HeightManager.h0,
            child: Image.asset(
              AssetsManager.doctor,
              height: HeightManager.h200,
            ),
          ),
        ],
      ),
    );
  }
}