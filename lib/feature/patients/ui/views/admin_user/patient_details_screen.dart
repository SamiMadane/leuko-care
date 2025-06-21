import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/helpers/extensions.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/core/widgets/custom_confirmation_dialog.dart';
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
        patientName: 'Patient Details'.tr(),
        userType: userType,
        onDeletePressed: () {
          showAnimatedConfirmationDialog(
            context: context,
            title: 'Confirm Delete'.tr(),
            message: 'Are you sure you want to delete this patient?'.tr(),
            confirmText: 'Delete'.tr(),
            type: ConfirmationType.delete,
            onConfirmed: () {
              patientCubit.deletePatient(patientId);
              context.pop(); // لإغلاق الديالوج بعد التأكيد
            },
          );
        },
      ),
      body: DeletePatientBlocListener(
        // ⬅️ انقله هنا
        doctorId: doctorId,
        doctorName: doctorName,
        child: Padding(
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
                      return Center(
                        child: Text('Error loading patient data.'.tr()),
                      );
                    } else if (!snapshot.hasData) {
                      return Center(child: Text('Patient not found.'.tr()));
                    }

                    final patient = snapshot.data!;

                    return SingleChildScrollView(
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
                              fontSize: FontSizeManager.s22,
                              color: ColorsManager.darkBlue,
                            ),
                          ),
                          SizedBox(height: HeightManager.h20),
                          PatientDetailsSection(
                            patient: patient,
                            userType: userType,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              if (userType != 'doctor'.tr())
                StreamBuilder<PatientModel>(
                  stream: patientCubit.getPatientByIdStream(patientId),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return const SizedBox.shrink();
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: WidthManager.w20,
                        vertical: HeightManager.h10,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: PatientEditButton(
                              patient: snapshot.data!,
                              userType: 'admin'.tr(),
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
      ),
    );
  }
}
