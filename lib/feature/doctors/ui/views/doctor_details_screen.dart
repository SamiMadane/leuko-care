import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/resourses/colors_manager.dart';
import 'package:leuko_care/core/resourses/fonts_manager.dart';
import 'package:leuko_care/core/resourses/sizes_util_manager.dart';
import 'package:leuko_care/core/resourses/styles_manager.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
import 'package:leuko_care/feature/doctors/logic/cubit/doctor_cubit.dart';
import 'package:leuko_care/feature/doctors/ui/widgets/doctor_details_widgets/confirmation_dialog.dart';
import 'package:leuko_care/feature/doctors/ui/widgets/doctor_details_widgets/delete_doctor_bloc_listener.dart';
import 'package:leuko_care/feature/doctors/ui/widgets/doctor_details_widgets/doctor_details_app_bar.dart';
import 'package:leuko_care/feature/doctors/ui/widgets/doctor_details_widgets/doctor_details_edit_button.dart';
import 'package:leuko_care/feature/doctors/ui/widgets/doctor_details_widgets/doctor_details_info_card.dart';
import 'package:leuko_care/feature/doctors/ui/widgets/doctor_details_widgets/doctor_details_profile_image.dart';

class DoctorDetailsScreen extends StatelessWidget {
  final DoctorModel doctor;
  final int patientsCount;

  const DoctorDetailsScreen({
    super.key,
    required this.doctor,
    required this.patientsCount,
  });

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
                  message: 'Are you sure you want to delete this doctor?',
                  onConfirmed: () async {
                    doctorCubit.deleteDoctor(doctor.id!);
                    Navigator.of(context).pop();
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
                DoctorDetailsProfileImage(profileImageUrl: doctor.profileImage),
                SizedBox(height: HeightManager.h20),
                Text(
                  doctor.name,
                  style: getBoldTextStyle(
                    fontSize: FontSizeManager.s24,
                    color: ColorsManager.blueGrey,
                  ),
                ),
                const SizedBox(height: 20),
                DoctorDetailsInfoCard(
                  doctor: doctor,
                  patientsCount: patientsCount,
                ),
                const SizedBox(height: 30),
                DoctorDetailsEditButton(doctor: doctor),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
