import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';

class PatientDropdown extends StatelessWidget {
  final List<PatientModel> patients;
  final PatientModel? selected;
  final ValueChanged<PatientModel?> onChanged;

  const PatientDropdown({
    super.key,
    required this.patients,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Patient'.tr(),
          style: getMediumTextStyle(
            fontSize: FontSizeManager.s16,
            color: ColorsManager.darkBlue,
          ),
        ),
        DropdownButton<PatientModel>(
          isExpanded: true,
          value: selected,
          hint: Text('Choose patient'.tr()),
          items: patients.map((patient) {
            return DropdownMenuItem(
              value: patient,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(patient.name),
                  if (patient.isExamined == true)
                    Text('Tested'.tr(), style: TextStyle(color: Colors.green)),
                ],
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
