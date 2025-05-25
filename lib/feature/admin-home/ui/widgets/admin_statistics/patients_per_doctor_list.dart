import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/feature/patients/ui/widgets/patient_user/home/patient_examined/health_tips_widget.dart';

class PatientsPerDoctorList extends StatelessWidget {
  final Map<String, int> data;

  const PatientsPerDoctorList({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: data.entries.mapIndexed((index, entry) {
        final isLast = index == data.length - 1;
        return Container(
          margin: EdgeInsets.only(
            bottom: isLast ? 0 : HeightManager.h10,
          ),
          padding: EdgeInsets.symmetric(
            vertical: HeightManager.h12,
            horizontal: WidthManager.w16,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
            border: Border.all(color: ColorsManager.lightGray),
          ),
          child: Row(
            children: [
              Container(
                width: WidthManager.w40,
                height: WidthManager.w40,
                decoration: BoxDecoration(
                  color: ColorsManager.lightBlue,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.person_outline, color: ColorsManager.primaryColor, size: 24),
              ),
              SizedBox(width: WidthManager.w14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Dr. ${entry.key}",
                      style: getBoldTextStyle(
                        fontSize: FontSizeManager.s15,
                        color: ColorsManager.darkBlue,
                      ),
                    ),
                    SizedBox(height: HeightManager.h6),
                    Text(
                      "${entry.value} patients",
                      style: getMediumTextStyle(
                        fontSize: FontSizeManager.s13,
                        color: ColorsManager.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
