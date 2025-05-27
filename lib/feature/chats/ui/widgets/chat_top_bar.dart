import 'package:easy_localization/easy_localization.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';
import 'package:shimmer/shimmer.dart';

class ChatTopBar extends StatelessWidget {
  final DoctorModel? doctor;
  final PatientModel? patient;

  const ChatTopBar({super.key, required this.doctor, this.patient});

  @override
  Widget build(BuildContext context) {
    final imageUrl = patient?.profileImage ?? doctor?.profileImage;
    final name = patient?.name ?? tr('doctor_name', namedArgs: {'name': doctor?.name ?? ''});
    final canPop = Navigator.canPop(context);

    return Container(
      padding: EdgeInsets.symmetric(vertical: HeightManager.h8),
      child: Row(
        children: [
          if (canPop)
            IconButton(
              icon: const Icon(Icons.arrow_back),
              color: ColorsManager.darkBlue,
              onPressed: () => Navigator.pop(context),
            ),

          if (!canPop) SizedBox(width: WidthManager.w20),

          CircleAvatar(
            radius: RadiusManager.r28,
            backgroundColor: Colors.transparent,
            backgroundImage: null,
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: imageUrl!,
                width: WidthManager.w56,
                height: HeightManager.h56,
                fit: BoxFit.cover,
                placeholder: (_, __) => _buildShimmerLoading(),
                errorWidget:
                    (_, __, ___) => const Icon(Icons.error, color: Colors.red),
              ),
            ),
          ),
          SizedBox(width: WidthManager.w12),
          Expanded(
            child: Text(
              name,
              style: getMediumTextStyle(
                fontSize: FontSizeManager.s20,
                color: ColorsManager.darkBlue,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return Shimmer.fromColors(
      baseColor: ColorsManager.lightGray,
      highlightColor: Colors.white,
      child: CircleAvatar(
        radius: RadiusManager.r28,
        backgroundColor: Colors.white,
      ),
    );
  }
}
