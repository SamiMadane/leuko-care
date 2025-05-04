import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';

class ChatTopBar extends StatelessWidget {
  final DoctorModel doctor;

  const ChatTopBar({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: WidthManager.w20,
        vertical: HeightManager.h6,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: RadiusManager.r26,
            backgroundImage: NetworkImage(doctor.profileImage),
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
}
