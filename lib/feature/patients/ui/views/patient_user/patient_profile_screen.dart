import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';
import 'package:leuko_care/feature/patients/logic/cubit/patient_cubit.dart';
import 'package:leuko_care/feature/patients/ui/widgets/admin_user/patient_details_widgets/patient_details_edit_button.dart';
import 'package:leuko_care/feature/patients/ui/widgets/admin_user/patient_details_widgets/patient_details_profile_image.dart';
import 'package:leuko_care/feature/patients/ui/widgets/patient_user/home/info_card.dart';

class PatientProfileScreen extends StatelessWidget {
  final PatientModel patient;

  const PatientProfileScreen({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    final age = context.read<PatientCubit>().calculateAge(patient.birthDate);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Profile',
          style: getMediumTextStyle(
            fontSize: FontSizeManager.s20,
            color: ColorsManager.darkBlue,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: ColorsManager.darkBlue),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: HeightManager.h20,
          horizontal: WidthManager.w22,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            PatientDetailsProfileImage(profileImageUrl: patient.profileImage),
            SizedBox(height: HeightManager.h20),
            Text(
              patient.name,
              style: getBoldTextStyle(
                fontSize: FontSizeManager.s22,
                color: ColorsManager.darkBlue,
              ),
            ),
            SizedBox(height: HeightManager.h30),

            InfoCard(title: 'Email', value: patient.email, icon: Icons.email),
            InfoCard(title: 'Phone', value: patient.phone, icon: Icons.phone),
            InfoCard(
              title: 'Birth Date',
              value: patient.birthDate,
              icon: Icons.date_range,
            ),
            InfoCard(title: 'Age', value: age.toString(), icon: Icons.cake),

            SizedBox(height: HeightManager.h30),
            PatientDetailsEditButton(patient: patient),
          ],
        ),
      ),
    );
  }
}
