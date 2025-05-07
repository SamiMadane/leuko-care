import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/feature/admin-home/data/model/admin_statistics_model.dart';
import 'package:leuko_care/feature/admin-home/logic/cubit/admin_home_cubit.dart';
import 'package:leuko_care/feature/admin-home/logic/cubit/admin_home_state.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/widgets/examined_status_progress_widget.dart';
import 'package:leuko_care/core/widgets/health_status_bar_chart_widget.dart';
import 'package:leuko_care/feature/admin-home/ui/widgets/admin_statistics/patients_per_doctor_list.dart';
import 'package:leuko_care/feature/admin-home/ui/widgets/admin_statistics/statistic_card.dart';

class AdminStatisticsScreen extends StatelessWidget {
  const AdminStatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Statistics')),
      body: BlocBuilder<AdminHomeCubit, AdminHomeState>(
        builder: (context, state) {
          switch (state) {
            case GetStatisticsStateLoading _:
              return const Center(child: CircularProgressIndicator());
            case GetStatisticsStateError _:
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            case GetStatisticsStateSuccess _:
              return _buildStatisticsUI(state.statistics);
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }

  Widget _buildStatisticsUI(AdminStatisticsModel stats) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: WidthManager.w16,
        vertical: HeightManager.h16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StatisticCard(text: "Total Patients: ${stats.totalPatients}"),
          StatisticCard(text: "Total Doctors: ${stats.totalDoctors}"),
          SizedBox(height: HeightManager.h20),
          _buildSectionTitle("Examination Status:"),
          SizedBox(height: HeightManager.h14),
          ExaminedStatusProgressWidget(
            data: {
              "Examined": stats.examinedCount,
              "Unexamined": stats.unexaminedCount,
            },
          ),
          SizedBox(height: HeightManager.h20),
          _buildSectionTitle("Health Status Distribution:"),
          SizedBox(height: HeightManager.h20),
          HealthStatusBarChart(data: stats.healthStatusCounts),
          SizedBox(height: HeightManager.h20),
          _buildSectionTitle("Patients Per Doctor:"),
          SizedBox(height: HeightManager.h14),
          PatientsPerDoctorList(data: stats.patientsPerDoctor),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: getBoldTextStyle(
        fontSize: IconSizeManager.s18,
        color: ColorsManager.darkBlue,
      ),
    );
  }
}
