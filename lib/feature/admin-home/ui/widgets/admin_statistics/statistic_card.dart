import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';

class StatisticCard extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;

  const StatisticCard({
    super.key,
    required this.text,
    this.icon = Icons.info_outline,
    this.iconColor = Colors.blue,
    this.backgroundColor = const Color(0xFFE3F2FD), // Colors.blue[50]
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      elevation: 8,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: WidthManager.w16),
        leading: Icon(icon, color: iconColor),
        title: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}
