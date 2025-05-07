import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/resources/assets_manager.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
import 'package:leuko_care/feature/doctors/logic/cubit/doctor_cubit.dart';
import 'package:leuko_care/feature/doctors/logic/cubit/doctor_state.dart';
import 'package:leuko_care/feature/doctors/ui/views/doctor_user/doctor_chats_screen.dart';
import 'package:leuko_care/feature/doctors/ui/views/doctor_user/doctor_home_screen.dart';
import 'package:leuko_care/feature/doctors/ui/views/doctor_user/doctor_patients_screen.dart';
import 'package:leuko_care/feature/doctors/ui/views/doctor_user/doctor_profile_screen.dart';
import 'package:leuko_care/feature/doctors/ui/views/doctor_user/upload_sample_screen.dart';
import 'package:leuko_care/feature/doctors/ui/widgets/doctor_user/doctor_bottom_nav_bar.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';

class DoctorScreen extends StatelessWidget {
  const DoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final doctorId = FirebaseAuth.instance.currentUser?.uid;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<DoctorCubit, DoctorState>(
            buildWhen: (previous, current) =>
                current is GetDoctorAndPatientsStateLoading ||
                current is GetDoctorAndPatientsStateError ||
                current is GetDoctorAndPatientsStateSuccess,
            builder: (context, state) {
              if (state is GetDoctorAndPatientsStateLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is GetDoctorAndPatientsStateError) {
                return _DoctorErrorWidget(doctorId: doctorId);
              } else if (state is GetDoctorAndPatientsStateSuccess) {
                final doctor = state.doctor;
                final patients = state.patients;
                return _DoctorBodyBuilder(doctor,patients);
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),

        floatingActionButton: const _DoctorFAB(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

        bottomNavigationBar: BlocBuilder<DoctorCubit, DoctorState>(
          builder: (context, state) {
            final cubit = context.watch<DoctorCubit>();
            return DoctorBottomNavBar(
              currentIndex: cubit.selectedIndex,
              onTap: cubit.changeSelectedIndex,
            );
          },
        ),
      ),
    );
  }
}

// ==========================
// ✅ Private Widgets Section
// ==========================

class _DoctorBodyBuilder extends StatelessWidget {
  final DoctorModel doctor;
  final List<PatientModel> patients;
  const _DoctorBodyBuilder(this.doctor, this.patients);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DoctorCubit>();

    final pages = [
      DoctorHomeScreen(doctor: doctor, patients: patients,),
      DoctorPatientsScreen(doctor: doctor,patients: patients,),
      UploadSampleScreen(),
      DoctorChatsScreen(patients: patients),
      DoctorProfileScreen(doctor: doctor,),
    ];

    return BlocBuilder<DoctorCubit, DoctorState>(
      builder: (context, state) {
        return IndexedStack(
          index: cubit.selectedIndex,
          children: pages,
        );
      },
    );
  }
}

class _DoctorFAB extends StatelessWidget {
  const _DoctorFAB();

  @override
  Widget build(BuildContext context) {
    final selectedIndex = context.watch<DoctorCubit>().selectedIndex;

    return AnimatedScale(
      scale: selectedIndex == 0 ? 1.2 : 1.0,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      child: FloatingActionButton(
        onPressed: () {
          if (selectedIndex != 0) {
            context.read<DoctorCubit>().changeSelectedIndex(0);
          }
        },
        backgroundColor: selectedIndex == 0
            ? ColorsManager.primaryColor.withOpacity(0.8)
            : ColorsManager.primaryColor,
        shape: const CircleBorder(),
        child: AnimatedOpacity(
          opacity: selectedIndex == 0 ? 0.8 : 1.0,
          duration: const Duration(milliseconds: 200),
          child: Image.asset(
            AssetsManager.homeIcon,
            width: WidthManager.w26,
            height: HeightManager.h26,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class _DoctorErrorWidget extends StatelessWidget {
  final String? doctorId;

  const _DoctorErrorWidget({required this.doctorId});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Error loading data"),
          ElevatedButton(
            onPressed: () {
              if (doctorId != null) {
                context.read<DoctorCubit>().getDoctorAndPatients(doctorId!);
              }
            },
            child: const Text("Retry"),
          ),
        ],
      ),
    );
  }
}
