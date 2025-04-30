// file: examination_pending_widget.dart

import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';

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
                    const Text(
                      'Your test result is still pending. Please wait while your doctor reviews your sample.',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    TextButton.icon(
                      onPressed: () {
                        // context.pushNamed(
                        //   Routes.chatScreen,
                        //   arguments: {
                        //     'defaultMessage': 'Hello doctor, I’m still waiting for my blood test results.',
                        //   },
                        // );
                      },
                      icon: const Icon(
                        Icons.chat,
                        color: ColorsManager.primaryColor,
                      ),
                      label: const Text(
                        'Still waiting? Send a message',
                        style: TextStyle(
                          color: ColorsManager.primaryColor,
                          fontWeight: FontWeight.w500,
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
        SizedBox(height: HeightManager.h50),
        Icon(Icons.biotech, size: 300, color: ColorsManager.lightGray),
        // لاحقًا:
        // Lottie.asset('assets/animations/waiting.json', height: 180),
      ],
    );
  }
}
