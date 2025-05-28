import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/feature/doctors/logic/cubit/doctor_cubit.dart';
import 'package:leuko_care/feature/doctors/logic/cubit/doctor_state.dart';
import 'package:leuko_care/feature/doctors/ui/widgets/doctor_user/doctor_shimmer.dart';
import 'package:leuko_care/feature/doctors/ui/widgets/doctor_user/doctor_screen/doctor_bottom_nav_bar.dart';
import 'package:leuko_care/feature/doctors/ui/widgets/doctor_user/doctor_screen/doctor_body_builder.dart';
import 'package:leuko_care/feature/doctors/ui/widgets/doctor_user/doctor_screen/doctor_error_widget.dart';
import 'package:leuko_care/feature/doctors/ui/widgets/doctor_user/doctor_screen/doctor_fab.dart';

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
            buildWhen:
                (previous, current) =>
                    current is GetDoctorAndPatientsStateLoading ||
                    current is GetDoctorAndPatientsStateError ||
                    current is GetDoctorAndPatientsStateSuccess,
            builder: (context, state) {
              if (state is GetDoctorAndPatientsStateLoading) {
                return DoctorShimmer();
              } else if (state is GetDoctorAndPatientsStateError) {
                return DoctorErrorWidget(doctorId: doctorId);
              } else if (state is GetDoctorAndPatientsStateSuccess) {
                final doctor = state.doctor;
                final patients = state.patients;
                final conversationsByPatientId = state.conversationsByPatientId;
              
                return DoctorBodyBuilder(
                  doctor: doctor,
                  patients: patients,
                  conversationsByPatientId: conversationsByPatientId,
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),

        floatingActionButton: DoctorFab(),
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
