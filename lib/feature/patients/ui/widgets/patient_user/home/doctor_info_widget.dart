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
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';
import 'package:leuko_care/feature/patients/logic/cubit/patient_cubit.dart';
import 'package:shimmer/shimmer.dart';

class DoctorInfoWidget extends StatelessWidget {
  final PatientModel patient;
  final DoctorModel doctor;
  const DoctorInfoWidget({
    super.key,
    required this.patient,
    required this.doctor,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Doctor Who Examined You:",
          style: getSemiBoldTextStyle(
            fontSize: FontSizeManager.s18,
            color: ColorsManager.darkBlue,
          ),
        ),
        SizedBox(height: HeightManager.h14),
        InkWell(
          onTap: () async{
            final shouldOpenChat = await context.pushNamed(
              Routes.doctorDetailsScreenForPatient,
              arguments: doctor,
            );
            if (shouldOpenChat == true) {
              context.read<PatientCubit>().changeSelectedIndex(1);
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: HeightManager.h14,
              horizontal: WidthManager.w14,
            ),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(RadiusManager.r12),
              border: Border.all(color: ColorsManager.lightBlueAccent),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Material(
                  elevation: 4,
                  shape: const CircleBorder(),
                  shadowColor: ColorsManager.black87,
                  child: CircleAvatar(
                    radius: RadiusManager.r30,
                    backgroundColor: Colors.transparent,
                    backgroundImage: null,
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: doctor.profileImage,
                        width: WidthManager.w60,
                        height: HeightManager.h60,
                        fit: BoxFit.cover,
                        placeholder: (_, __) => _buildShimmerLoading(),
                        errorWidget:
                            (_, __, ___) =>
                                const Icon(Icons.error, color: Colors.red),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: WidthManager.w12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dr. ${doctor.name}',
                        style: getSemiBoldTextStyle(
                          fontSize: FontSizeManager.s16,
                          color: ColorsManager.darkBlue,
                        ),
                      ),
                      SizedBox(height: HeightManager.h4),
                      Text(
                        doctor.email,
                        style: getMediumTextStyle(
                          fontSize: FontSizeManager.s14,
                          color: ColorsManager.darkBlue,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios, color: Colors.blue),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _buildShimmerLoading() {
    return Shimmer.fromColors(
      baseColor: ColorsManager.lightGray,
      highlightColor: Colors.white,
      child: CircleAvatar(
        radius: RadiusManager.r30,
        backgroundColor: Colors.white,
      ),
    );
  }
}
