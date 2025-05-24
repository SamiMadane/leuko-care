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
import 'package:leuko_care/feature/patients/ui/widgets/admin_user/patient_details_widgets/patient_details_app_bar.dart';
import 'package:leuko_care/feature/patients/ui/widgets/admin_user/patient_details_widgets/patient_details_section.dart';
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
        patientName: 'Patient Details',
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
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: HeightManager.h20),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<PatientModel>(
                stream: patientCubit.getPatientByIdStream(patientId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text('Error loading patient data.'),
                    );
                  } else if (!snapshot.hasData) {
                    return const Center(child: Text('Patient not found.'));
                  }

                  final patient = snapshot.data!;

                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        DeletePatientBlocListener(
                          doctorId: doctorId,
                          doctorName: doctorName,
                        ),
                        ProfileImageWidget(
                          profileImageUrl: patient.profileImage,
                        ),
                        SizedBox(height: HeightManager.h20),
                        Text(
                          patient.name,
                          style: getBoldTextStyle(
                            fontSize: FontSizeManager.s22,
                            color: ColorsManager.darkBlue,
                          ),
                        ),
                        SizedBox(height: HeightManager.h20),
                        PatientDetailsSection(patient: patient),
                      
                      ],
                    ),
                  );
                },
              ),
            ),
            if (userType != 'doctor')
              StreamBuilder<PatientModel>(
                stream: patientCubit.getPatientByIdStream(patientId),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const SizedBox.shrink();
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: WidthManager.w20,vertical: HeightManager.h10),
                    child: Row(
                      children: [
                        Expanded(
                          child: PatientEditButton(
                            patient: snapshot.data!,
                            userType: 'admin',
                            doctorName: doctorName,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
