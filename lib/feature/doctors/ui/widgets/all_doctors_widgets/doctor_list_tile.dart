import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/helpers/extensions.dart';
import 'package:leuko_care/core/resourses/colors_manager.dart';
import 'package:leuko_care/core/resourses/fonts_manager.dart';
import 'package:leuko_care/core/resourses/sizes_util_manager.dart';
import 'package:leuko_care/core/routes/routes.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
import 'package:leuko_care/feature/doctors/logic/cubit/doctor_cubit.dart';
import 'package:shimmer/shimmer.dart';

class DoctorListTile extends StatelessWidget {
  final DoctorModel doctor;
  const DoctorListTile({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        vertical: HeightManager.h8,
        horizontal: WidthManager.w16,
      ),
      elevation: 4,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          vertical: HeightManager.h18,
          horizontal: WidthManager.w18,
        ),
        title: Text(
          ' Dr.${doctor.name}',
          style: TextStyle(
            fontSize: FontSizeManager.s18,
            fontWeight: FontWeight.bold,
            color: ColorsManager.darkBlue,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: HeightManager.h6),
            Row(
              children: [
                Icon(
                  Icons.email,
                  color: ColorsManager.primaryColor,
                  size: IconSizeManager.s18,
                ),
                SizedBox(width: WidthManager.w4),
                Text(doctor.email),
              ],
            ),
            SizedBox(height: HeightManager.h4),
            _buildPatientCount(context, doctor.id!),
          ],
        ),
        leading: CircleAvatar(
          radius: RadiusManager.r40,
          backgroundColor: Colors.grey[300],
          child: ClipOval(
            child: CachedNetworkImage(
              imageUrl: doctor.profileImage,
              height: 60,
              width: 60,
              fit: BoxFit.cover,
              placeholder: (context, url) => _buildShimmerLoading(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),

        onTap: () {
          context.pushNamed(Routes.doctorDetailsScreen, arguments: doctor);
        },
      ),
    );
  }

  Widget _buildPatientCount(BuildContext context, String doctorId) {
    return StreamBuilder<int>(
      stream: context.read<DoctorCubit>().getPatientsCountStream(doctorId),
      builder: (context, snapshot) {
        final count = snapshot.data;
        return Row(
          children: [
            Icon(Icons.group, color: ColorsManager.primaryColor, size: 18),
            SizedBox(width: WidthManager.w4),
            Text(
              'Number of patients: ${count ?? "..."}',
              style: const TextStyle(color: ColorsManager.primaryColor),
            ),
          ],
        );
      },
    );
  }

  Widget _buildShimmerLoading() {
    return Shimmer.fromColors(
      baseColor: ColorsManager.lightGray,
      highlightColor: Colors.white,
      child: CircleAvatar(
        radius: RadiusManager.r40,
        backgroundColor: Colors.white,
      ),
    );
  }
}
