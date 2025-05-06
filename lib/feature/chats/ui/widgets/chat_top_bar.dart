import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
import 'package:shimmer/shimmer.dart';

class ChatTopBar extends StatelessWidget {
  final DoctorModel doctor;

  const ChatTopBar({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: WidthManager.w20,
        vertical: HeightManager.h16,
      ),
      child: Row(
        children: [
           CircleAvatar(
                radius: RadiusManager.r25,
                backgroundColor: Colors.transparent,
                backgroundImage: null,
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: doctor.profileImage,
                    width: WidthManager.w50,
                    height: HeightManager.h50,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => _buildShimmerLoading(),
                    errorWidget:
                        (_, __, ___) =>
                            const Icon(Icons.error, color: Colors.red),
                  ),
                ),
              ),
          SizedBox(width: WidthManager.w12),
          Expanded(
            child: Text(
              'Dr. ${doctor.name}',
              style: getSemiBoldTextStyle(
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
        radius: RadiusManager.r25,
        backgroundColor: Colors.white,
      ),
    );
  }
}
