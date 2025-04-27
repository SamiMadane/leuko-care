import 'package:flutter/material.dart';
import 'package:leuko_care/core/helpers/extensions.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/core/routes/routes.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';

class PatientDetailsEditButton extends StatelessWidget {
  final PatientModel patient;

  const PatientDetailsEditButton({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          context.pushNamed(Routes.addUpdatePatientScreen, arguments: {
            'patientModel': patient,
          });
        },
        icon: const Icon(Icons.edit, color: ColorsManager.white),
        label: Text(
          'Edit Patient',
          style: getSemiBoldTextStyle(
            fontSize: FontSizeManager.s14,
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorsManager.primaryColor,
          padding: EdgeInsets.symmetric(vertical: HeightManager.h14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(RadiusManager.r12),
          ),
        ),
      ),
    );
  }
}
