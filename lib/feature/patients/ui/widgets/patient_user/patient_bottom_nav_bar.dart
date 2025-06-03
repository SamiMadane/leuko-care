import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/assets_manager.dart';

class PatientBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const PatientBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(RadiusManager.r24),
          topRight: Radius.circular(RadiusManager.r24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(RadiusManager.r24),
          topRight: Radius.circular(RadiusManager.r24),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            backgroundColor: ColorsManager.white,
            currentIndex: currentIndex,
            onTap: onTap,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: ColorsManager.primaryColor,
            unselectedItemColor: ColorsManager.darkBlue,
            selectedFontSize: FontSizeManager.s14,
            unselectedFontSize: FontSizeManager.s12,
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            items: [
              _buildNavItem(
                AssetsManager.homeIcon,
                'Home'.tr(),
                0,
              ),
              _buildNavItem(
                AssetsManager.chatIcon,
                'Chat'.tr(),
                1,
              ),
              _buildNavItem(
                AssetsManager.patientProfileIcon,
                'Profile'.tr(),
                2,
              ),
            ],
          ),
        ),
      ),
    );
  }

 BottomNavigationBarItem _buildNavItem(String assetPath, String label, int index) {
  final isSelected = currentIndex == index;
  final color = isSelected ? ColorsManager.primaryColor : ColorsManager.darkBlue;

  return BottomNavigationBarItem(
    icon: Container(
      padding: EdgeInsets.symmetric(
        vertical: isSelected ? HeightManager.h8 : HeightManager.h4,
        horizontal: isSelected ? WidthManager.w8 : WidthManager.w4,
      ),  
      decoration: isSelected
          ? BoxDecoration(
              color: ColorsManager.lightBlue,  // لون خلفية شفاف
              shape: BoxShape.circle,
            )
          : null,
      child: Image.asset(
        assetPath,
        width: isSelected ? WidthManager.w26 : WidthManager.w22,
        height: isSelected ? HeightManager.h26 : HeightManager.h22,
        color: color,
      ),
    ),
    label: label,
  );
}

}