import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/core/widgets/info_tile.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
import 'package:leuko_care/feature/doctors/logic/cubit/doctor_cubit.dart';

class DoctorDetailsSection extends StatelessWidget {
  final DoctorModel doctor;
  const DoctorDetailsSection({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
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
            color: ColorsManager.black.withValues(alpha: .2),
            blurRadius: 10,
            offset: const Offset(3, 3),
          ),
        ],
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InfoTile(
              icon: Icons.email,
              label: 'Email'.tr(),
              value: doctor.email,
            ),
            SizedBox(height: HeightManager.h16),

            InfoTile(
              icon: Icons.phone,
              label: 'Phone'.tr(),
              value: doctor.phone,
            ),
            SizedBox(height: HeightManager.h16),

            InfoTile(
              icon: Icons.work_history,
              label: 'Experience'.tr(),
              value: plural(
                'years_count',
                doctor.experience,
                namedArgs: {'count': doctor.experience.toString()},
              ),
            ),
            SizedBox(height: HeightManager.h16),

            _patientCountTile(context, doctor.id!),
            SizedBox(height: HeightManager.h16),

            InfoTile(
              icon: Icons.info_outline,
              label: 'Description'.tr(),
              value: doctor.description,
              isMultiLine: true,
            ),
            SizedBox(height: HeightManager.h16),

            InfoTile(
              icon:
                  doctor.gender.toLowerCase() == 'male'.tr()
                      ? Icons.male
                      : Icons.female,
              label: 'Gender'.tr(),
              value: doctor.gender.tr(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _patientCountTile(BuildContext context, String doctorId) {
    return StreamBuilder<int>(
      stream: context.read<DoctorCubit>().getPatientsCountStream(doctorId),
      builder: (context, snapshot) {
        final count = snapshot.data ?? 0;
        return Container(
          padding: EdgeInsets.symmetric(
            vertical: HeightManager.h12,
            horizontal: WidthManager.w16,
          ),
          decoration: BoxDecoration(
            color: ColorsManager.lightBlue,
            borderRadius: BorderRadius.circular(RadiusManager.r16),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.people,
                color: ColorsManager.primaryColor,
                size: 28,
              ),
              SizedBox(width: WidthManager.w16),
              Text(
                'Patients Count'.tr(),
                style: getSemiBoldTextStyle(
                  fontSize: FontSizeManager.s15,
                  color: ColorsManager.primaryColor,
                ),
              ),
              const Spacer(),
              Text(
                '$count'.tr(),
                style: getBoldTextStyle(
                  fontSize: FontSizeManager.s16,
                  color: ColorsManager.primaryColor,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
