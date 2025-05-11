import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/feature/chats/logic/cubit/chat_cubit.dart';
import 'package:leuko_care/feature/chats/ui/views/chat_screen.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';
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
    required this.sampleImageUrl, required this.doctor,
  });

  @override
  State<SampleResultScreen> createState() => _SampleResultScreenState();
}

class _SampleResultScreenState extends State<SampleResultScreen> {
  final ScreenshotController _screenshotController = ScreenshotController();
  bool _hideButtons = false;

  String _getInitialDoctorMessage() {
    // تحديد الرسالة بناءً على نوع المرض أو النتيجة
    if (widget.result == 'sick') {
      return 'Important: Your test result shows signs of leukemia. Please visit the hospital for further examination as soon as possible.';
    } else {
      return 'Congratulations! Your test result is clear. Please continue maintaining a healthy lifestyle.';
    }
  }

  Future<void> _captureAndPreview() async {
    setState(() => _hideButtons = true);
    await Future.delayed(const Duration(milliseconds: 300)); // لانتظار الإخفاء

    Uint8List? image = await _screenshotController.capture();

    setState(() => _hideButtons = false);

    if (image != null) {
      _showPreviewDialog(image);
    }
  }

  void _showPreviewDialog(Uint8List image) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text('Preview Before Sending'),
            content: Image.memory(image),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                   Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (_) => BlocProvider.value(
                    value: context.read<ChatCubit>(),
                    child: ChatScreen(
                      currentUserId: widget.doctor.id!,
                      otherUserId: widget.patient.id!,
                      patient: widget.patient,
                      initialDoctorMessage: _getInitialDoctorMessage(),
                      initialDoctorImage: image,
                    ),
                  ),
            ),
          );
                },
                icon: Icon(Icons.send, color: ColorsManager.white),
                label: Text(
                  'Send',
                  style: getMediumTextStyle(
                    fontSize: FontSizeManager.s14,
                    color: ColorsManager.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsManager.primaryColor,
                ),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Result for ${widget.patient.name}',
          style: getBoldTextStyle(
            fontSize: FontSizeManager.s20,
            color: ColorsManager.darkBlue,
          ),
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
                    _buildSectionTitle("Patient Info"),
                    SizedBox(height: 8),
                    _buildInfoRow("Name", widget.patient.name),
                    _buildInfoRow("Email", widget.patient.email),
                    _buildInfoRow("Phone", widget.patient.phone),
                    SizedBox(height: 16),

                    _buildSectionTitle("AI Analysis Result"),
                    SizedBox(height: 8),
                    _buildInfoRow("Result", widget.result),
                    _buildInfoRow(
                      "Type",
                      widget.diseaseType.isEmpty
                          ? "Unknown"
                          : widget.diseaseType,
                    ),
                    _buildInfoRow(
                      "Confidence",
                      widget.confidence == null
                          ? "-"
                          : "${widget.confidence!.toStringAsFixed(1)}%",
                    ),
                    _buildInfoRow(
                      "Message",
                      widget.aiMessage.isEmpty ? "-" : widget.aiMessage,
                    ),
                    SizedBox(height: 16),

                    if (widget.sampleImageUrl.isNotEmpty) ...[
                      _buildSectionTitle("Sample Image"),
                      SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          widget.sampleImageUrl,
                          height: 200,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),

            if (!_hideButtons) ...[
              SizedBox(height: HeightManager.h20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      // تحديث بيانات المريض
                    },
                    icon: Icon(Icons.check, color: ColorsManager.white),
                    label: Text(
                      "Confirm Diagnosis",
                      style: getMediumTextStyle(
                        fontSize: FontSizeManager.s14,
                        color: ColorsManager.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorsManager.primaryColor,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.cancel, color: ColorsManager.white),
                    label: Text(
                      "Cancel",
                      style: getMediumTextStyle(
                        fontSize: FontSizeManager.s14,
                        color: ColorsManager.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorsManager.red,
                    ),
                  ),
                ],
              ),
              SizedBox(height: HeightManager.h20),
              ElevatedButton.icon(
                onPressed: _captureAndPreview,
                icon: Icon(Icons.send, color: ColorsManager.white),
                label: Text(
                  "Send to Patient",
                  style: getMediumTextStyle(
                    fontSize: FontSizeManager.s14,
                    color: ColorsManager.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsManager.primaryColor,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text("$label: ", style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value, overflow: TextOverflow.ellipsis)),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: ColorsManager.primaryColor,
      ),
    );
  }
}
