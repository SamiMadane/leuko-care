import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/helpers/extensions.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/core/routes/routes.dart';
import 'package:leuko_care/core/widgets/profile_image_widget.dart';
import 'package:leuko_care/core/widgets/profile_info_row.dart';
import 'package:leuko_care/core/widgets/section_title.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';
import 'package:leuko_care/feature/patients/logic/cubit/patient_cubit.dart';

class PatientProfileScreen extends StatelessWidget {
  final PatientModel patient;

  const PatientProfileScreen({super.key, required this.patient});
  @override
  Widget build(BuildContext context) {
    final age = context.read<PatientCubit>().calculateAge(patient.birthDate);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(width: WidthManager.w8),
            Text(
              'My Profile'.tr(),
              style: getMediumTextStyle(
                fontSize: FontSizeManager.s20,
                color: ColorsManager.darkBlue,
              ),
            ),
          ],
        ),
        backgroundColor: ColorsManager.appBarColor,
        iconTheme: const IconThemeData(color: ColorsManager.darkBlue),
        actions: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.edit, color: ColorsManager.primaryColor),
                onPressed: () {
                  context.pushNamed(
                    Routes.addUpdatePatientScreen,
                    arguments: {
                      'patientModel': patient,
                      'userType': 'patient'.tr(),
                      'doctorId': patient.doctorId,
                      'doctorName': '',
                    },
                  );
                },
              ),
              SizedBox(width: WidthManager.w4,)
            ],
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              padding: EdgeInsets.symmetric(vertical: HeightManager.h24),
              child: Column(
                children: [
                  ProfileImageWidget(profileImageUrl: patient.profileImage),
                  SizedBox(height: HeightManager.h12),
                  Text(
                    patient.name,
                    style: getBoldTextStyle(
                      fontSize: FontSizeManager.s20,
                      color: ColorsManager.darkBlue,
                    ),
                  ),
                ],
              ),
            ),

            SectionTitle(title: 'Contact Info'.tr()),
            ProfileInfoRow(
              icon: Icons.email,
              title: 'Email'.tr(),
              value: patient.email,
            ),
            ProfileInfoRow(
              icon: Icons.phone,
              title: 'Phone'.tr(),
              value: patient.phone,
            ),

            SectionTitle( title: 'Personal Info'.tr(),),
            ProfileInfoRow(
              icon: Icons.date_range,
              title: 'Birth Date'.tr(),
              value: patient.birthDate,
            ),
            ProfileInfoRow(
              icon: Icons.cake,
              title: 'Age'.tr(),
              value: age.toString(),
            ),
            ProfileInfoRow(
              icon:
                  patient.gender.toLowerCase() == 'male'.tr()
                      ? Icons.male
                      : Icons.female,
              title: 'Gender'.tr(),
              value: patient.gender.tr(),
            ),

            SizedBox(height: HeightManager.h24),
          ],
        ),
      ),
    );
  }
}
