import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
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
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: HeightManager.h2,
            vertical: HeightManager.h16,
          ),
          child: DropdownButton2<PatientModel>(
            underline: const SizedBox(),
            isExpanded: true,
            value: selected,
            hint: Text('Choose patient'.tr()),
            onChanged: onChanged,
            items:
                patients.map((patient) {
                  return DropdownMenuItem(
                    value: patient,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(patient.name),
                        if (patient.isExamined == true)
                          Text(
                            'Tested'.tr(),
                            style:  getSemiBoldTextStyle(fontSize: FontSizeManager.s14,color: ColorsManager.green),
                          ),
                      ],
                    ),
                  );
                }).toList(),
            // ✅ التحكم بمكان القائمة المعروضة:
            dropdownStyleData: DropdownStyleData(
              offset: const Offset(0, 5), // المسافة من الزر إلى القائمة
              padding: EdgeInsets.symmetric(horizontal: WidthManager.w12,vertical: HeightManager.h10),
              width:
                  MediaQuery.of(context).size.width *
                  0.9, // تحكم بعرض القائمة
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(RadiusManager.r12),
                color: Colors.white,
              ),
            ),
            buttonStyleData: ButtonStyleData(
              padding: EdgeInsets.symmetric(horizontal: WidthManager.w12),
              height: HeightManager.h50,
              decoration: BoxDecoration(
                border: Border.all(color: ColorsManager.primaryColor),
                borderRadius: BorderRadius.circular(RadiusManager.r12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
