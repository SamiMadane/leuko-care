import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/helpers/extensions.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
import 'package:leuko_care/feature/doctors/logic/cubit/doctor_cubit.dart';
import 'package:leuko_care/core/widgets/confirmation_dialog.dart';
import 'package:leuko_care/feature/doctors/ui/widgets/admin_user/doctor_details_widgets/delete_doctor_bloc_listener.dart';
import 'package:leuko_care/feature/doctors/ui/widgets/admin_user/doctor_details_widgets/doctor_details_add_patient_button.dart';
import 'package:leuko_care/feature/doctors/ui/widgets/admin_user/doctor_details_widgets/doctor_details_app_bar.dart';
import 'package:leuko_care/feature/doctors/ui/widgets/admin_user/doctor_details_widgets/doctor_details_edit_button.dart';
import 'package:leuko_care/feature/doctors/ui/widgets/admin_user/doctor_details_widgets/doctor_details_info_card.dart';
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
          showDialog(
            context: context,
            builder:
                (context) => ConfirmationDialog(
                  title: 'Confirm Delete',
                  message:
                      'Are you sure you want to delete this doctor and all of their patients?',
                  confirmText: 'Delete',
                  icon: Icons.delete,
                  onConfirmed: () async {
                    doctorCubit.deleteDoctor(doctor.id!);
                    context.pop();
                  },
                ),
          );
        },
      ),
      body: Column(
        children: [
          const DeleteDoctorBlocListener(),
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              vertical: HeightManager.h20,
              horizontal: WidthManager.w22,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ProfileImageWidget(profileImageUrl: doctor.profileImage),
                SizedBox(height: HeightManager.h20),
                Text(
                  doctor.name,
                  style: getBoldTextStyle(
                    fontSize: FontSizeManager.s24,
                    color: ColorsManager.blueGrey,
                  ),
                ),
                SizedBox(height: HeightManager.h20),
                DoctorDetailsInfoCard(doctor: doctor),
                SizedBox(height: HeightManager.h30),
                DoctorDetailsEditButton(doctor: doctor),
                SizedBox(height: HeightManager.h16),
                DoctorDetailsViewPatientsButton(
                  doctorId: doctor.id,
                  doctorName: doctor.name,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
