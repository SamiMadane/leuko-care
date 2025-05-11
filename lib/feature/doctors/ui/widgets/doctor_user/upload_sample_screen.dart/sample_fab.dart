import 'package:flutter/material.dart';
import 'package:leuko_care/core/helpers/extensions.dart';
import 'package:leuko_care/core/resources/assets_manager.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/routes/routes.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';

class SampleFAB extends StatelessWidget {
  final PatientModel? patient;
  final DoctorModel doctor;

  const SampleFAB({
    super.key,
    required this.patient,
    required this.doctor,
  });

  @override
  Widget build(BuildContext context) {
    if (patient == null || patient!.isExamined != true) return SizedBox.shrink();

    return ClipOval(
      child: FloatingActionButton(
        backgroundColor: ColorsManager.primaryColor,
        child: Image.asset(
          AssetsManager.chemicalAnalysisIcon,
          width: WidthManager.w30,
          height: HeightManager.h30,
          color: ColorsManager.white,
        ),
        onPressed: () {
          context.pushNamed(
            Routes.sampleResultScreen,
            arguments: {
              'patient': patient!,
              'doctor': doctor,
              'result': 'sick',
              'diseaseType': 'Acute Lymphoblastic Leukemia',
              'confidence': 92.5,
              'aiMessage':
                  'The AI model detected signs of Acute Lymphoblastic Leukemia with high confidence. Immediate medical attention is recommended.',
              'sampleImageUrl':
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQNbGvhz9FycJFGdB6RGt49lL_T-tRULnYQTw&s',
            },
          );
        },
      ),
    );
  }
}
