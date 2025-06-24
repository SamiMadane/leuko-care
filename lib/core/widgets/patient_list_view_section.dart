import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/assets_manager.dart';
import 'package:leuko_care/core/widgets/empty_state_widget.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';
import 'package:leuko_care/core/widgets/patient_list_tile.dart';

class PatientListViewSection extends StatelessWidget {
  final List<PatientModel> patients;
  final String doctorId;
  final String doctorName;
  final String? userType;

  const PatientListViewSection({
    super.key,
    required this.patients,
    required this.doctorId,
    required this.doctorName, this.userType,
  });

  @override
  Widget build(BuildContext context) {
    if (patients.isEmpty) {
      return EmptyStateWidget(
        lottiePath:AssetsManager.searchLottie,
        isFullScreen: true,
        title: 'No matching patients'.tr(),
        message: 'Try adjusting your search or filter options'.tr(),
      );
    }

    return ListView.builder(
      itemCount: patients.length,
      itemBuilder: (context, index) {
        final patient = patients[index];
        return PatientListTile(
          patient: patient,
          doctorId: doctorId,
          doctorName: doctorName,
          userType:userType,
        );
      },
    );
  }
}
