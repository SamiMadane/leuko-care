import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:leuko_care/core/helpers/extensions.dart';
import 'package:leuko_care/core/resources/assets_manager.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/core/routes/routes.dart';

class DoctorsBlueContainer extends StatelessWidget {
  const DoctorsBlueContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: HeightManager.h220,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: double.infinity,
            height: HeightManager.h190,
            padding: EdgeInsets.symmetric(
              horizontal: WidthManager.w16,
              vertical: HeightManager.h16,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(RadiusManager.r24),
              image: DecorationImage(
                image: AssetImage(AssetsManager.homeBluePatternImage),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: HeightManager.h6),
                Text(
                  'Admin Dashboard'.tr(),
                  style: getBoldTextStyle(
                    fontSize: FontSizeManager.s16,
                    color: ColorsManager.white,
                  ),
                ),
                SizedBox(height: HeightManager.h10),
                Text(
                  'admin_dashboard_description'.tr(),
                  style: getSemiBoldTextStyle(
                    fontSize: FontSizeManager.s15,
                    color: ColorsManager.white,
                    height: HeightManager.h1_5,
                  ),
                ),
                Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsManager.white,
                    foregroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(RadiusManager.r12),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: WidthManager.w18,
                      vertical: HeightManager.h10,
                    ),
                  ),
                  onPressed: () {
                    context.pushNamed(Routes.adminStatisticsScreen);
                  },
                  child: Text(
                    'View Statistics'.tr(),
                    style: getMediumTextStyle(
                      fontSize: FontSizeManager.s14,
                      color: ColorsManager.darkBlue,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            // عيّن الموضع حسب اتجاه اللغة
            right:
                context.locale.languageCode == 'ar' ? null : WidthManager.wm16,
            left: context.locale.languageCode == 'ar' ? WidthManager.wm16 : null,
            top: HeightManager.h20,
            child: Image.asset(
              AssetsManager.homeAdminImage,
              height: HeightManager.h200,
            ),
          ),
        ],
      ),
    );
  }
}
