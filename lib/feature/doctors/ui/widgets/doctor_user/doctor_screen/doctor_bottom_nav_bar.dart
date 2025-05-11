import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/assets_manager.dart';

class DoctorBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const DoctorBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      elevation: 10,
      color: ColorsManager.moreLighterGray,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                _buildNavIcon(AssetsManager.patientsIcon, 'Patients', 1),
                const SizedBox(width: 20),
                _buildNavIcon(AssetsManager.bloodTest, 'Upload', 2),
              ],
            ),
            Row(
              children: [
                _buildNavIcon(AssetsManager.chatIcon, 'Chat', 3),
                const SizedBox(width: 20),
                _buildNavIcon(AssetsManager.doctorProfileIcon, 'Profile', 4),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () => onTap(0), // Home
      backgroundColor: ColorsManager.primaryColor,
      child: Image.asset(
        AssetsManager.homeIcon,
        width: WidthManager.w26,
        height: HeightManager.h26,
        color: Colors.white,
      ),
    );
  }

  Widget _buildNavIcon(String asset, String label, int index) {
    final isSelected = currentIndex == index;
    final color = isSelected ? ColorsManager.primaryColor : ColorsManager.darkBlue;

    return InkWell(
      onTap: () => onTap(index),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              asset,
              width: isSelected ? WidthManager.w26 : WidthManager.w22,
              height: isSelected ? HeightManager.h26 : HeightManager.h22,
              color: color,
            ),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: FontSizeManager.s12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
