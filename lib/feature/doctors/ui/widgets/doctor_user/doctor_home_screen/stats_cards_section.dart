import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';

class StatsCardsSection extends StatelessWidget {
  final int total;
  final int pending;

  const StatsCardsSection({
    super.key,
    required this.total,
    required this.pending,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            label: 'Total Patients'.tr(),
            value: '$total'.tr(),
            icon: Icons.groups,
            color: ColorsManager.primaryColor,
          ),
        ),
        SizedBox(width: WidthManager.w12),
        Expanded(
          child: _StatCard(
            label: 'Pending Samples'.tr(),
            value: '$pending'.tr(),
            icon: Icons.hourglass_empty,
            color: Colors.orange,
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: WidthManager.w16,
        vertical: HeightManager.h26,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(RadiusManager.r16),
        border: Border.all(color: color),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 28),
          SizedBox(height: HeightManager.h10),
          Text('$label : $value', style: getBoldTextStyle(fontSize: FontSizeManager.s13, color: color)),
        ],
      ),
    );
  }
}
