import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';

class StatsCardsSection extends StatelessWidget {
  final int total;
  final int pending;

  const StatsCardsSection({super.key, required this.total, required this.pending});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            label: "Total Patients",
            value: "$total",
            icon: Icons.groups,
            color: ColorsManager.primaryColor,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatCard(
            label: "Pending Samples",
            value: "$pending",
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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 8),
          Text(label, style: TextStyle(fontSize: 14, color: color)),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}