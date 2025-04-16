import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/resourses/colors_manager.dart';
import 'package:leuko_care/core/resourses/fonts_manager.dart';
import 'package:leuko_care/core/resourses/sizes_util_manager.dart';
import 'package:leuko_care/core/resourses/styles_manager.dart';
import 'package:leuko_care/feature/doctors/ui/widgets/doctor_details_widgets/doctor_details_profile_image.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';
import 'package:leuko_care/feature/patients/logic/cubit/patient_cubit.dart';
import 'package:leuko_care/feature/patients/ui/widgets/patient_details_widgets/confirmation_dialog.dart';
import 'package:leuko_care/feature/patients/ui/widgets/patient_details_widgets/delete_patient_bloc_listener.dart';
import 'package:leuko_care/feature/patients/ui/widgets/patient_details_widgets/patient_details_app_bar.dart';
import 'package:leuko_care/feature/patients/ui/widgets/patient_details_widgets/patient_details_info_card.dart';
import 'package:leuko_care/feature/patients/ui/widgets/patient_details_widgets/patient_details_edit_button.dart';

class PatientDetailsScreen extends StatelessWidget {
  final PatientModel patient;
  final String doctorId;
  final String doctorName;

  const PatientDetailsScreen({
    super.key,
    required this.patient,
    required this.doctorId,
    required this.doctorName,
  });

  @override
  Widget build(BuildContext context) {
    final patientCubit = context.read<PatientCubit>();

    return Scaffold(
      appBar: PatientDetailsAppBar(
        patientName: patient.name,
        onDeletePressed: () {
          showDialog(
            context: context,
            builder:
                (context) => ConfirmationDialog(
                  title: 'Confirm Delete',
                  message: 'Are you sure you want to delete this patient?',
                  onConfirmed: () {
                    patientCubit.deletePatient(patient.id!);
                  },
                ),
          );
        },
      ),
      body: Column(
        children: [
          DeletePatientBlocListener(doctorId: doctorId, doctorName: doctorName),
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              vertical: HeightManager.h20,
              horizontal: WidthManager.w22,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DoctorDetailsProfileImage(
                  profileImageUrl: patient.profileImage,
                ),
                SizedBox(height: HeightManager.h20),
                Text(
                  patient.name,
                  style: getBoldTextStyle(
                    fontSize: FontSizeManager.s24,
                    color: ColorsManager.blueGrey,
                  ),
                ),
                SizedBox(height: HeightManager.h20),
                PatientDetailsInfoCard(patient: patient),
                SizedBox(height: HeightManager.h30),
                PatientDetailsEditButton(patient: patient),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
