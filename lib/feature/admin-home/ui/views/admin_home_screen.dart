import 'package:flutter/material.dart';
import 'package:leuko_care/core/resourses/colors_manager.dart';
import 'package:leuko_care/core/resourses/fonts_manager.dart';
import 'package:leuko_care/core/resourses/sizes_util_manager.dart';
import 'package:leuko_care/core/resourses/styles_manager.dart';
import 'package:leuko_care/feature/admin-home/ui/widgets/patients_department_list_view.dart';
import 'package:leuko_care/feature/admin-home/ui/widgets/doctor_department_list_view.dart';
import 'package:leuko_care/feature/admin-home/ui/widgets/doctors_blue_container.dart';
import 'package:leuko_care/feature/admin-home/ui/widgets/doctors_department_see_all.dart';
import 'package:leuko_care/feature/admin-home/ui/widgets/home_top_bar.dart';

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
            HeightManager.h28,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeTopBar(),
              const DoctorsBlueContainer(),
              SizedBox(height: HeightManager.h24),
              const DoctorsDepartmentSeeAll(),
              SizedBox(height: HeightManager.h18),
              const DoctorsDepartmentListView(),
              Text(
                'Patients\' Department',
                style: getSemiBoldTextStyle(
                  fontSize: FontSizeManager.s18,
                  color: ColorsManager.darkBlue,
                ),
              ),
              SizedBox(height: HeightManager.h18),
              const PatientsDepartmentListView(),
            ],
          ),
        ),
      ),
    );
  }
}
