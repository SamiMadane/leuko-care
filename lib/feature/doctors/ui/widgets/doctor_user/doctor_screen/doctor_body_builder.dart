import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/feature/chats/data/models/conversation_model.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
import 'package:leuko_care/feature/doctors/logic/cubit/doctor_cubit.dart';
import 'package:leuko_care/feature/doctors/logic/cubit/doctor_state.dart';
import 'package:leuko_care/feature/doctors/ui/views/doctor_user/doctor_chats_screen.dart';
import 'package:leuko_care/feature/doctors/ui/views/doctor_user/doctor_home_screen.dart';
import 'package:leuko_care/feature/doctors/ui/views/doctor_user/doctor_patients_screen.dart';
import 'package:leuko_care/feature/doctors/ui/views/doctor_user/doctor_profile_screen.dart';
import 'package:leuko_care/feature/doctors/ui/views/doctor_user/upload_sample_screen.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';

class DoctorBodyBuilder extends StatelessWidget {
    final DoctorModel doctor;
  final List<PatientModel> patients;
  final Map<String, ConversationModel> conversationsByPatientId;

  const DoctorBodyBuilder({super.key, required this.doctor, required this.patients, required this.conversationsByPatientId});

  @override
  Widget build(BuildContext context) {
    print('🧩 DoctorBodyBuilder rebuilt with ${patients.length} patients');

    final cubit = context.read<DoctorCubit>();

    final pages = [
      DoctorPatientsScreen(doctor: doctor,patients: patients,),
      UploadSampleScreen(patients: patients,doctor:doctor),
      DoctorHomeScreen(doctor: doctor, patients: patients,),
      DoctorChatsScreen(doctor: doctor,patients: patients, conversationsByPatientId:conversationsByPatientId ,),
      DoctorProfileScreen(doctor: doctor,),
    ];

    return BlocBuilder<DoctorCubit, DoctorState>(
      builder: (context, state) {
        return PageView(
          controller: cubit.pageController,
      onPageChanged: (index) {
        cubit.changeSelectedIndex(index);
      },
          children: pages,
        );
      },
    );  }
}