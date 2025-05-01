import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/feature/patients/logic/cubit/patient_cubit.dart';
import 'package:leuko_care/feature/patients/logic/cubit/patient_state.dart';
import 'package:leuko_care/feature/patients/ui/widgets/admin_user/patient_details_widgets/patient_details_profile_image.dart';

class PatientProfileScreen extends StatelessWidget {
  const PatientProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: BlocBuilder<PatientCubit, PatientState>(
        builder: (context, state) {
          if (state is GetPatientStateLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is GetPatientStateSuccess) {
            var patient = state.patients.first;

            return SingleChildScrollView(
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

                  _buildInfoCard(title: 'Email', value: patient.email),
                  _buildInfoCard(title: 'Phone', value: patient.phone),
                  _buildInfoCard(title: 'Birth Date', value: patient.birthDate),

                  SizedBox(height: HeightManager.h30),
                ],
              ),
            );
          } else if (state is GetPatientStateError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget _buildInfoCard({required String title, required String value}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(RadiusManager.r16),
      ),
      elevation: 2,
      margin: EdgeInsets.only(bottom: HeightManager.h16),
      child: Padding(
        padding: EdgeInsets.all(HeightManager.h16),
        child: Row(
          children: [
            Icon(Icons.info_outline, color: ColorsManager.primaryColor),
            SizedBox(width: WidthManager.w12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: getSemiBoldTextStyle(
                      fontSize: FontSizeManager.s14,
                      color: ColorsManager.darkBlue,
                    ),
                  ),
                  SizedBox(height: HeightManager.h6),
                  Text(
                    value,
                    style: getRegularTextStyle(
                      fontSize: FontSizeManager.s14,
                      color: ColorsManager.black87,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
