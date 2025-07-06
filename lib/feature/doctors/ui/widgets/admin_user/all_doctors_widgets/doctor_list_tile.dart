import 'package:easy_localization/easy_localization.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/helpers/extensions.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
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
      color: ColorsManager.moreLighterGray,
      child: InkWell(
        onTap: () {
          context.pushNamed(Routes.doctorDetailsScreen, arguments: doctor);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: HeightManager.h18,
            horizontal: WidthManager.w18,
          ),
          child: Row(
            children: [
              DoctorImage(profileImage: doctor.profileImage),
              SizedBox(width: WidthManager.w16),
              DoctorDetails(doctor: doctor),
            ],
          ),
        ),
      ),
    );
  }
}

class DoctorImage extends StatelessWidget {
  final String profileImage;
  const DoctorImage({super.key, required this.profileImage});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: RadiusManager.r35,
      backgroundColor: ColorsManager.profileBackGroundColor,
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: profileImage,
          height: HeightManager.h70,
          width: WidthManager.w70,
          fit: BoxFit.cover,
          placeholder: (context, url) => _buildShimmerLoading(),
          errorWidget: (context, url, error) => Image.asset('assets/images/default_avatar.png'),
        ),
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return Shimmer.fromColors(
      baseColor: ColorsManager.lightGray,
      highlightColor: Colors.white,
      child: CircleAvatar(
        radius: RadiusManager.r35,
        backgroundColor: Colors.white,
      ),
    );
  }
}

class DoctorDetails extends StatelessWidget {
  final DoctorModel doctor;
  const DoctorDetails({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tr('doctor_name', namedArgs: {'name': doctor.name}),
            style: TextStyle(
              fontSize: FontSizeManager.s18,
              fontWeight: FontWeight.bold,
              color: ColorsManager.darkBlue,
            ),
          ),
          SizedBox(height: HeightManager.h6),
          _EmailRow(email: doctor.email),
          SizedBox(height: HeightManager.h6),
          _buildPatientCount(context, doctor.id!),
        ],
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
            Icon(Icons.group, color: ColorsManager.primaryColor, size: IconSizeManager.s22),
            SizedBox(width: WidthManager.w4),
            Text(
              tr('number_of_patients', namedArgs: {'count': (count?.toString() ?? '...')}),
              style: getBoldTextStyle(fontSize: FontSizeManager.s15, color: ColorsManager.primaryColor)
            ),
          ],
        );
      },
    );
  }
}
class _EmailRow extends StatelessWidget {
  final String email;

  const _EmailRow({
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.email,
          size: IconSizeManager.s16,
          color: ColorsManager.gray,
        ),
        SizedBox(width: WidthManager.w6),
        Expanded(
          child: Text(
            email,
            style: getMediumTextStyle(
              fontSize: FontSizeManager.s14,
              color: ColorsManager.gray,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
