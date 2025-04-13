import 'package:flutter/material.dart';
import 'package:leuko_care/core/resourses/sizes_util_manager.dart';
import 'package:leuko_care/feature/admin-home/ui/widgets/doctor_department/doctor_department_bloc_builder.dart';
import 'package:leuko_care/feature/admin-home/ui/widgets/patients_department/patients_department_bloc_builder.dart';
import 'package:leuko_care/feature/admin-home/ui/widgets/doctors_blue_container.dart';
import 'package:leuko_care/feature/admin-home/ui/widgets/doctors_department_see_all.dart';
import 'package:leuko_care/feature/admin-home/ui/widgets/home_top_bar.dart';
import 'package:leuko_care/feature/admin-home/ui/widgets/patients_department_see_all.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.fromLTRB(
            WidthManager.w20,
            HeightManager.h16,
            WidthManager.w20,
            HeightManager.h16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeTopBar(),
              const DoctorsBlueContainer(),
              SizedBox(height: HeightManager.h24),
              const DoctorsDepartmentSeeAll(),
              SizedBox(height: HeightManager.h18),
              const DoctorsDepartmentBlocBuilder(),
              SizedBox(height: HeightManager.h10),
              const PatientsDepartmentSeeAll(),
              SizedBox(height: HeightManager.h18),
              const PatientsDepartmentBlocBuilder(),
            ],
          ),
        ),
      ),
    );
  }
}
