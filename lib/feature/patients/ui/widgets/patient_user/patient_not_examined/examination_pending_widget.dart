import 'package:easy_localization/easy_localization.dart';

// file: examination_pending_widget.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/feature/patients/logic/cubit/patient_cubit.dart';

class ExaminationPendingWidget extends StatelessWidget {
  const ExaminationPendingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            vertical: HeightManager.h20,
            horizontal: WidthManager.w20,
          ),
          decoration: BoxDecoration(
            color: Colors.orange.shade50,
            borderRadius: BorderRadius.circular(RadiusManager.r16),
            border: Border.all(color: Colors.orangeAccent),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: HeightManager.h3),
                child: Icon(Icons.hourglass_top, color: Colors.orange),
              ),
              SizedBox(width: WidthManager.w12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your test result is still pending. Please wait while your doctor reviews your sample.'.tr(),
                      style: getMediumTextStyle(
                        fontSize: FontSizeManager.s14,
                        color: ColorsManager.darkBlue,
                        height: HeightManager.h1_3,
                      ),
                    ),
                    SizedBox(height: HeightManager.h6),
                    TextButton.icon(
                      onPressed: () {
                        context.read<PatientCubit>().setInitialMessage(
                          'Hello doctor, I’m still waiting for my test result. Could you please update me?'.tr(),
                        );
                        context.read<PatientCubit>().changeSelectedIndex(1);

                      },
                      icon: Icon(Icons.chat, color: ColorsManager.primaryColor),
                      label: Text(
                        'Still waiting? Send a message'.tr(),
                        style: getMediumTextStyle(
                          fontSize: FontSizeManager.s13,
                          color: ColorsManager.primaryColor,
                        ),
                      ),
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: HeightManager.h48),
        Icon(
          Icons.biotech,
          size: HeightManager.h270,
          color: ColorsManager.lightGray,
        ),
      ],
    );
  }
}