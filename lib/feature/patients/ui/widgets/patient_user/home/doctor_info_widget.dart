import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';

class DoctorInfoWidget extends StatelessWidget {
  final PatientModel patient;
  final DoctorModel doctor; 
  const DoctorInfoWidget({super.key, required  this.patient, required this.doctor});
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
        SizedBox(height: HeightManager.h16),
        InkWell(
          onTap: () {
            // Navigate to Doctor Details screen
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: HeightManager.h16,
              horizontal: WidthManager.w16,
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
                CircleAvatar(
                  radius: RadiusManager.r28,
                  backgroundImage: NetworkImage(doctor.profileImage),
                ),
                SizedBox(width: WidthManager.w12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dr. ${doctor.name}',
                        style: getBoldTextStyle(fontSize: FontSizeManager.s16, color: ColorsManager.darkBlue),
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
}
