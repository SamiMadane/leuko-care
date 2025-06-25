import 'package:easy_localization/easy_localization.dart';

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
import 'package:leuko_care/feature/doctors/ui/widgets/doctor_user/sample_result_screen/ai_analysis_widget.dart';
import 'package:leuko_care/feature/doctors/ui/widgets/doctor_user/sample_result_screen/confirmation_buttons_widget.dart';
import 'package:leuko_care/feature/doctors/ui/widgets/doctor_user/sample_result_screen/patient_info_widget.dart';
import 'package:leuko_care/feature/doctors/ui/widgets/doctor_user/sample_result_screen/preview_dialog.dart';
import 'package:leuko_care/feature/doctors/ui/widgets/doctor_user/sample_result_screen/sample_image_widget.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:screenshot/screenshot.dart';

class SampleResultScreen extends StatefulWidget {
  final PatientModel patient;
  final DoctorModel doctor;
  final String result;
  final String diseaseType;
  final double? confidence;
  final String aiMessage;
  final String sampleImageUrl;

  const SampleResultScreen({
    super.key,
    required this.patient,
    required this.result,
    required this.diseaseType,
    required this.confidence,
    required this.aiMessage,
    required this.sampleImageUrl,
    required this.doctor,
  });

  @override
  State<SampleResultScreen> createState() => _SampleResultScreenState();
}

class _SampleResultScreenState extends State<SampleResultScreen> {
  final ScreenshotController _screenshotController = ScreenshotController();
  bool _hideButtons = false;

  String _getInitialDoctorMessage() {
    if (widget.result == 'sick'.tr()) {
      return 'Important: Your test result shows signs of leukemia. Please visit the hospital for further examination as soon as possible.'
          .tr();
    } else {
      return 'Congratulations! Your test result is clear. Please continue maintaining a healthy lifestyle.'
          .tr();
    }
  }

  Future<void> _captureAndPreview() async {
    setState(() => _hideButtons = true);
    await Future.delayed(const Duration(milliseconds: 300));
    Uint8List? image = await _screenshotController.capture();
    setState(() => _hideButtons = false);

    if (image != null) {
      showPreviewDialog(
        context,
        image,
        widget.doctor,
        widget.patient,
        _getInitialDoctorMessage(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(width: WidthManager.w8),

            Text(
              'Result for ${widget.patient.name}'.tr(),
              style: getMediumTextStyle(
                fontSize: FontSizeManager.s20,
                color: ColorsManager.darkBlue,
              ),
            ),
          ],
        ),
        backgroundColor: ColorsManager.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(HeightManager.h16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Screenshot(
              controller: _screenshotController,
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: ColorsManager.primaryColor,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    patientInfoWidget(widget.patient),
                    aiAnalysisWidget(
                      widget.result,
                      widget.diseaseType,
                      widget.confidence,
                      widget.aiMessage,
                    ),
                    sampleImageWidget(widget.sampleImageUrl),
                  ],
                ),
              ),
            ),
            if (!_hideButtons) ...[
              SizedBox(height: HeightManager.h20),
              confirmationButtonsWidget(
                () {
                  // Update patient data
                },
                () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: HeightManager.h20),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: WidthManager.w14),
                child: SizedBox(
                  width: double.infinity,
                  height: HeightManager.h44,
                  child: ElevatedButton.icon(
                    onPressed: _captureAndPreview,
                    icon: Icon(Icons.send, color: ColorsManager.white),
                    label: Text(
                      'Send to Patient'.tr(),
                      style: getMediumTextStyle(
                        fontSize: FontSizeManager.s14,
                        color: ColorsManager.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorsManager.primaryColor,
                      padding: EdgeInsets.symmetric(
                        vertical: HeightManager.h12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(RadiusManager.r16),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
