import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/widgets/info_tile.dart';
import 'package:leuko_care/core/widgets/patient_status_widgets.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';
import 'package:leuko_care/feature/patients/logic/cubit/patient_cubit.dart';

class PatientDetailsSection extends StatelessWidget {
  final PatientModel patient;
  final String? userType;

  const PatientDetailsSection({
    super.key,
    required this.patient,
    this.userType,
  });

  @override
  Widget build(BuildContext context) {
    final age = context.read<PatientCubit>().calculateAge(patient.birthDate);

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: HeightManager.h20,
        horizontal: WidthManager.w20,
      ),
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.zero,
          topRight: Radius.circular(RadiusManager.r20),
        ),
        boxShadow: [
          BoxShadow(
            color: ColorsManager.black.withValues(alpha: .15),
            blurRadius: 10,
            offset: const Offset(3, 3),
          ),
        ],
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom:
              userType == 'doctor'
                  ? MediaQuery.of(context).padding.bottom + HeightManager.h30
                  : 0,
        ),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InfoTile(
              icon: Icons.email,
              label: 'Email'.tr(),
              value: patient.email,
            ),
            SizedBox(height: HeightManager.h16),

            InfoTile(
              icon: Icons.phone,
              label: 'Phone'.tr(),
              value: patient.phone,
            ),
            SizedBox(height: HeightManager.h16),

            InfoTile(
              icon: Icons.calendar_today,
              label: 'Age'.tr(),
              value: plural('years_count', age, namedArgs: {'count': age.toString()}),
            ),

            SizedBox(height: HeightManager.h16),

            InfoTile(
              icon: Icons.check_circle_outline,
              label: 'Examined'.tr(),
              valueWidget: ExaminedStatusWidget(isExamined: patient.isExamined),
            ),
            SizedBox(height: HeightManager.h16),

            if (patient.isExamined) ...[
              InfoTile(
                icon: Icons.health_and_safety,
                label: 'Health Status'.tr(),
                valueWidget: HealthStatusWidget(status: patient.healthStatus),
              ),
              SizedBox(height: HeightManager.h16),

              InfoTile(
                icon: Icons.bloodtype,
                label: 'Leukemia Type'.tr(),
                value: patient.leukemiaType.tr(),
              ),
              SizedBox(height: HeightManager.h16),

              InfoTile(
                icon: Icons.percent,
                label: 'Disease Confidence'.tr(),
                value: '${patient.diseaseConfidence.toStringAsFixed(1)}%'.tr(),
              ),
              SizedBox(height: HeightManager.h16),

              InfoTile(
                icon: Icons.medical_services_outlined,
                label: 'Last Exam Date'.tr(),
                value: _formatDate(
                  dateString: patient.lastExamDate!,
                  context: context,
                ),
              ),
              SizedBox(height: HeightManager.h16),
            ],

            InfoTile(
              icon: Icons.date_range,
              label: 'Registration Date'.tr(),
              value: _formatDate(
                dateString: patient.registrationDate,
                context: context,
              ),
            ),
            SizedBox(height: HeightManager.h16),

            InfoTile(
              icon:
                  patient.gender.toLowerCase() == 'male'.tr()
                      ? Icons.male
                      : Icons.female,
              label: 'Gender'.tr(),
              value: patient.gender.tr(),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate({required String dateString, BuildContext? context}) {
    try {
      final date = DateTime.parse(dateString);
      return context?.locale.languageCode == 'ar'
          ? DateFormat.yMMMMd('ar').format(date)
          : DateFormat.yMMMMd().format(date);
    } catch (_) {
      return dateString;
    }
  }
}
