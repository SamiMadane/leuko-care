import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/helpers/extensions.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/core/routes/routes.dart';
import 'package:leuko_care/core/widgets/custom_confirmation_dialog.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
import 'package:leuko_care/feature/doctors/logic/cubit/doctor_cubit.dart';
import 'package:leuko_care/feature/doctors/ui/widgets/admin_user/doctor_details_widgets/delete_doctor_bloc_listener.dart';
import 'package:leuko_care/feature/doctors/ui/widgets/admin_user/doctor_details_widgets/doctor_details_app_bar.dart';
import 'package:leuko_care/feature/doctors/ui/widgets/admin_user/doctor_details_widgets/doctor_details_section.dart';
import 'package:leuko_care/core/widgets/profile_image_widget.dart';

class DoctorDetailsScreen extends StatelessWidget {
  final DoctorModel doctor;

  const DoctorDetailsScreen({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    final doctorCubit = context.read<DoctorCubit>();

    return Scaffold(
      appBar: DoctorDetailsAppBar(
        doctorName: doctor.name,
        onDeletePressed: () {
          showAnimatedConfirmationDialog(
            context: context,
            title: 'Confirm Delete'.tr(),
            message:
                'Are you sure you want to delete this doctor and all of their patients?'
                    .tr(),
            confirmText: 'Delete'.tr(),
            type: ConfirmationType.delete,
            onConfirmed: () async {
              doctorCubit.deleteDoctor(doctor.id!);
              context.pop();
            },
          );
        },
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: HeightManager.h20),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const DeleteDoctorBlocListener(),
                    ProfileImageWidget(profileImageUrl: doctor.profileImage),
                    SizedBox(height: HeightManager.h20),
                    Text(
                      tr('doctor_name', namedArgs: {'name': doctor.name}),
                      style: getBoldTextStyle(
                        fontSize: FontSizeManager.s24,
                        color: ColorsManager.darkBlue,
                      ),
                    ),
                    SizedBox(height: HeightManager.h20),
                    DoctorDetailsSection(doctor: doctor),
                  ],
                ),
              ),
            ),
            SizedBox(height: HeightManager.h20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: WidthManager.w20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // زر تعديل الدكتور
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        context.pushNamed(
                          Routes.addUpdateDoctorScreen,
                          arguments: {
                            'doctorModel': doctor,
                            'userType': 'admin',
                          },
                        );
                      },
                      icon: const Icon(Icons.edit, color: ColorsManager.white),
                      label: Text(
                        'Edit Doctor'.tr(),
                        style: getSemiBoldTextStyle(
                          fontSize: FontSizeManager.s14,
                          color: ColorsManager.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsManager.primaryColor,
                        padding: EdgeInsets.symmetric(
                          vertical: HeightManager.h14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            RadiusManager.r12,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: WidthManager.w16),
                  // زر عرض المرضى
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        context.pushNamed(
                          Routes.allPatientsScreen,
                          arguments: {
                            'doctorId': doctor.id,
                            'doctorName': doctor.name,
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.people,
                        color: ColorsManager.white,
                      ),
                      label: Text(
                        'View Patients'.tr(),
                        style: getSemiBoldTextStyle(
                          fontSize: FontSizeManager.s14,
                          color: ColorsManager.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsManager.primaryColor,
                        padding: EdgeInsets.symmetric(
                          vertical: HeightManager.h14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            RadiusManager.r12,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: HeightManager.h10),
          ],
        ),
      ),
    );
  }
}
