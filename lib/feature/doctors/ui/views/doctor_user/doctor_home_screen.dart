import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/widgets/home_top_widget.dart';
import 'package:leuko_care/feature/admin-home/ui/widgets/admin_statistics/examination_pie_chart_widget.dart';
import 'package:leuko_care/core/widgets/health_status_bar_chart_widget.dart';
import 'package:leuko_care/feature/admin-home/ui/widgets/admin_statistics/statistic_card.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';
import 'package:fl_chart/fl_chart.dart'; // For Horizontal Bar Chart

class DoctorHomeScreen extends StatelessWidget {
  final DoctorModel doctor;
  final List<PatientModel> patients;

  const DoctorHomeScreen({
    super.key,
    required this.doctor,
    required this.patients,
  });

  @override
  Widget build(BuildContext context) {
    final totalPatients = patients.length;
    final pending = patients.where((p) => p.isExamined == false).length;
    final leukemias = patients.where((p) => p.healthStatus == "sick").length;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Widget with doctor details
            HomeTopWidget(
              name: "Dr. ${doctor.name}",
              imageUrl: doctor.profileImage,
              subMessage: "Your patients at a glance.",
            ),
            const SizedBox(height: 24),

            // Stats Cards (Total and Pending)
            _buildStatsCards(totalPatients, pending),

            const SizedBox(height: 24),

            // Examination Pie Chart (ExaminationPieChart)
            Text(
              "Examination Stats",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ColorsManager.darkBlue,
              ),
            ),
            const SizedBox(height: 12),
            ExaminationPieChart(
              data: {
                "Examined": totalPatients - pending,
                "Unexamined": pending,
              },
            ),

            const SizedBox(height: 24),

            // Health Status Bar Chart (HealthStatusBarChart)
            Text(
              "Health Status",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ColorsManager.darkBlue,
              ),
            ),
            const SizedBox(height: 12),
            HealthStatusBarChart(
              data: {
                'healthy':
                    patients.where((p) => p.healthStatus == "healthy").length,
                'sick':
                    patients.where((p) => p.healthStatus == "sick").length,
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsCards(int total, int pending) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            label: "Total Patients",
            value: "$total",
            icon: Icons.groups,
            color: ColorsManager.primaryColor,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            label: "Pending Samples",
            value: "$pending",
            icon: Icons.hourglass_empty,
            color: Colors.orange,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String label,
    required String value,
    required IconData icon,
    required Color color,
  }) {
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

  Widget _buildHealthStatusBarChart(int leukemias, int healthy) {
    return SizedBox(
      height: 200,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          barGroups: [
            BarChartGroupData(
              x: 0,
              barRods: [
                BarChartRodData(
                  toY: leukemias.toDouble(),
                  width: 20,
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            ),
            BarChartGroupData(
              x: 1,
              barRods: [
                BarChartRodData(
                  toY: healthy.toDouble(),
                  width: 20,
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            ),
          ],
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  switch (value.toInt()) {
                    case 0:
                      return Text(
                        "Leukemia",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    case 1:
                      return Text(
                        "Healthy",
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    default:
                      return const SizedBox.shrink();
                  }
                },
              ),
            ),
          ),
          gridData: FlGridData(show: true),
          borderData: FlBorderData(show: false),
        ),
      ),
    );
  }
}
