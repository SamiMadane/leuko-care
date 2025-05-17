import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
import 'package:leuko_care/feature/doctors/logic/cubit/doctor_cubit.dart';

class DoctorDetailsInfoCard extends StatelessWidget {
  final DoctorModel doctor;
  const DoctorDetailsInfoCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(RadiusManager.r16),
      ),
      color: ColorsManager.moreLighterGray,
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: HeightManager.h16,
          horizontal: WidthManager.w16,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildRowInfo(Icons.email, 'Email', doctor.email),
              const Divider(),
              _buildRowInfo(Icons.phone, 'Phone', doctor.phone),
              const Divider(),
              _buildRowInfo(
                Icons.work,
                'Experience',
                '${doctor.experience} years',
              ),
              const Divider(),
              _buildPatientCount(context, doctor.id!),

              const Divider(),
              _buildRowInfo(
                Icons.info_outline,
                'Description',
                doctor.description,
              ),
              const Divider(),
              _buildRowInfo(doctor.gender.toLowerCase() == 'male' ?Icons.male : Icons.female, 'Gender', doctor.gender),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPatientCount(BuildContext context, String doctorId) {
    return StreamBuilder<int>(
      stream: context.read<DoctorCubit>().getPatientsCountStream(doctorId),
      builder: (context, snapshot) {
        final count = snapshot.data;
        return _buildRowInfo(
          Icons.people,
          'Patients Count',
          '${count ?? '...'}',
        );
      },
    );
  }

  Widget _buildRowInfo(IconData icon, String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: HeightManager.h2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: ColorsManager.primaryColor),
          SizedBox(width: WidthManager.w12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: getSemiBoldTextStyle(
                    fontSize: FontSizeManager.s16,
                    color: ColorsManager.darkBlue,
                  ),
                ),
                SizedBox(height: HeightManager.h6),
                Text(
                  value,
                  style: getRegularTextStyle(
                    fontSize: FontSizeManager.s14,
                    color: ColorsManager.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
