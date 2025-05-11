import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/core/widgets/confirmation_dialog.dart';
import 'package:leuko_care/core/widgets/profile_image_widget.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';
import 'package:leuko_care/feature/patients/logic/cubit/patient_cubit.dart';
import 'package:leuko_care/feature/patients/ui/widgets/admin_user/patient_details_widgets/delete_patient_bloc_listener.dart';
import 'package:leuko_care/core/widgets/patient_details_app_bar.dart';
import 'package:leuko_care/feature/patients/ui/widgets/admin_user/patient_details_widgets/patient_details_info_card.dart';
import 'package:leuko_care/feature/patients/ui/widgets/shared/patient_edit_button.dart';

class PatientDetailsScreen extends StatelessWidget {
  final String patientId;
  final String doctorId;
  final String doctorName;
  final String? userType;
  const PatientDetailsScreen({
    super.key,
    required this.patientId,
    required this.doctorId,
    required this.doctorName,
    this.userType,
  });

  @override
  Widget build(BuildContext context) {
    final patientCubit = context.read<PatientCubit>();

    return Scaffold(
      appBar: PatientDetailsAppBar(
        patientName: 'PatientDetails',
        userType: userType,
        onDeletePressed: () {
          showDialog(
            context: context,
            builder:
                (context) => ConfirmationDialog(
                  title: 'Confirm Delete',
                  message: 'Are you sure you want to delete this patient?',
                  confirmText: 'Delete',
                  icon: Icons.delete,
                  onConfirmed: () {
                    patientCubit.deletePatient(patientId);
                  },
                ),
          );
        },
      ),
      body: Column(
        children: [
          DeletePatientBlocListener(doctorId: doctorId, doctorName: doctorName),

          StreamBuilder<PatientModel>(
            stream: patientCubit.getPatientByIdStream(patientId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const SizedBox.shrink();
              } else if (snapshot.hasData) {
                final patient = snapshot.data!;

                return Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      vertical: HeightManager.h20,
                      horizontal: WidthManager.w22,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ProfileImageWidget(
                          profileImageUrl: patient.profileImage,
                        ),
                        SizedBox(height: HeightManager.h20),
                        Text(
                          patient.name,
                          style: getBoldTextStyle(
                            fontSize: FontSizeManager.s24,
                            color:
                                userType == 'doctor'
                                    ? ColorsManager.darkBlue
                                    : ColorsManager.blueGrey,
                          ),
                        ),
                        SizedBox(height: HeightManager.h20),
                        PatientDetailsInfoCard(patient: patient),
                        SizedBox(height: HeightManager.h30),
                        userType == 'doctor'
                            ? SizedBox.shrink()
                            : PatientEditButton(
                              patient: patient,
                              userType: 'admin',
                            ),
                      ],
                    ),
                  ),
                );
              } else {
                return const Center(child: Text('Patient not found'));
              }
            },
          ),
        ],
      ),
    );
  }
}
