import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/feature/chats/ui/views/chat_screen.dart';
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

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),

      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<PatientCubit, PatientState>(
            buildWhen:
                (previous, current) =>
                    current is GetPatientAndDoctorStateLoading ||
                    current is GetPatientAndDoctorStateError ||
                    current is GetPatientAndDoctorStateSuccess,
            builder: (context, state) {
              if (state is GetPatientAndDoctorStateLoading) {
                return const PatientHomeShimmer();
              } else if (state is GetPatientAndDoctorStateError) {
                return const Center(child: Text("Error loading data"));
              } else if (state is GetPatientAndDoctorStateSuccess) {
                final pages = [
                  PatientHomeSuccessContent(
                    patient: state.patient,
                    doctor: state.doctor,
                  ),
                  ChatScreen(
                    currentUserId: state.patient.id!,
                    otherUserId: state.doctor.id!,
                    doctor: state.doctor,
                  ),
                  PatientProfileScreen(patient: state.patient),
                ];

                return IndexedStack(index: _selectedIndex, children: pages);
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
        bottomNavigationBar: PatientBottomNavBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
