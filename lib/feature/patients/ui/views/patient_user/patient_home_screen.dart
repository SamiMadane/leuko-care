import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/feature/patients/logic/cubit/patient_cubit.dart';
import 'package:leuko_care/feature/patients/logic/cubit/patient_state.dart';
import 'package:leuko_care/feature/patients/ui/views/patient_user/patient_profile_screen.dart';
import 'package:leuko_care/feature/patients/ui/widgets/patient_user/home/patient_bottom_nav_bar.dart';
import 'package:leuko_care/feature/patients/ui/widgets/patient_user/home/patient_home_shimmer.dart';
import 'package:leuko_care/feature/patients/ui/widgets/patient_user/home/patient_home_success_content.dart';

class PatientHomeScreen extends StatefulWidget {
  const PatientHomeScreen({super.key});

  @override
  State<PatientHomeScreen> createState() => _PatientHomeScreenState();
}

class _PatientHomeScreenState extends State<PatientHomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    PatientHomeScreen(),  // الصفحة الرئيسية
    PatientHomeScreen(), // صفحة الدردشة
    PatientProfileScreen(), // الصفحة الشخصية
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<PatientCubit, PatientState>(
          buildWhen: (previous, current) =>
              current is GetPatientAndDoctorStateLoading ||
              current is GetPatientAndDoctorStateError ||
              current is GetPatientAndDoctorStateSuccess,
          builder: (context, state) {
            return switch (state) {
              GetPatientAndDoctorStateLoading() => const PatientHomeShimmer(),
              GetPatientAndDoctorStateError() => const SizedBox.shrink(),
              GetPatientAndDoctorStateSuccess() => PatientHomeSuccessContent(
                patient: state.patient,
                doctor: state.doctor,
              ),
              _ => const SizedBox.shrink(),
            };
          },
        ),
      ),
      bottomNavigationBar: PatientBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          _pages[index];
        },
      ),
    );
  }
}
