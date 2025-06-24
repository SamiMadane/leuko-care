import 'package:easy_localization/easy_localization.dart';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leuko_care/core/helpers/extensions.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/core/routes/routes.dart';
import 'package:leuko_care/core/widgets/pick_and_crop_image.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
import 'package:leuko_care/feature/doctors/logic/cubit/doctor_cubit.dart';
import 'package:leuko_care/feature/doctors/logic/cubit/doctor_state.dart';
import 'package:leuko_care/feature/doctors/ui/views/doctor_user/analyzing_screen.dart';
import 'package:leuko_care/feature/doctors/ui/widgets/doctor_user/upload_sample_screen.dart/analyze_button.dart';
import 'package:leuko_care/feature/doctors/ui/widgets/doctor_user/upload_sample_screen.dart/image_picker_buttons.dart';
import 'package:leuko_care/feature/doctors/ui/widgets/doctor_user/upload_sample_screen.dart/patient_dropdown.dart';
import 'package:leuko_care/feature/doctors/ui/widgets/doctor_user/upload_sample_screen.dart/sample_fab.dart';
import 'package:leuko_care/feature/doctors/ui/widgets/doctor_user/upload_sample_screen.dart/sample_image_preview.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';

class UploadSampleScreen extends StatefulWidget {
  final List<PatientModel> patients;
  final DoctorModel doctor;
  const UploadSampleScreen({
    super.key,
    required this.patients,
    required this.doctor,
  });

  @override
  State<UploadSampleScreen> createState() => _UploadSampleScreenState();
}

class _UploadSampleScreenState extends State<UploadSampleScreen> {
  File? _image;
  PatientModel? selectedPatient;

  Future<void> _pickImage(ImageSource source) async {
    final cropped = await pickAndCropImage(context, source);
    if (cropped != null) {
      setState(() => _image = cropped);
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = context.read<DoctorCubit>();
      final patient = cubit.preSelectedPatient;

      if (patient != null) {
        try {
          final match = widget.patients.firstWhere(
            (p) => p.equalsById(patient),
            orElse: () => patient,
          );
          setState(() {
            selectedPatient = match;
          });
        } catch (_) {
          // في حال لم يكن المريض موجودًا في القائمة لأي سبب
          setState(() {
            selectedPatient = patient;
          });
        }
        cubit.preSelectedPatient = null;
      }
    });
  }

  Future<void> _processImage() async {
      if (_image == null && (selectedPatient?.latestSampleImageUrl == null || selectedPatient!.latestSampleImageUrl!.isEmpty)) {
    return;
  }



    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AnalyzingScreen()),
    );

    context.pushNamed(
      Routes.sampleResultScreen,
      arguments: {
        'patient': selectedPatient!,
        'doctor': widget.doctor,
        'result': 'sick'.tr(),
        'diseaseType': 'Acute Lymphoblastic Leukemia'.tr(),
        'confidence': 92.5,
        'aiMessage':
            'The AI model detected signs of Acute Lymphoblastic Leukemia with high confidence. Immediate medical attention is recommended.'
                .tr(),
        'sampleImageUrl':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQNbGvhz9FycJFGdB6RGt49lL_T-tRULnYQTw&s',
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocListener<DoctorCubit, DoctorState>(
          listenWhen:
              (previous, current) =>
                  current is DoctorBottomNavChanged && current.index != 1,
          listener: (context, state) {
            setState(() {
              selectedPatient = null;
              _image = null;
            });
          },
          child: Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  SizedBox(width: WidthManager.w8),

                  Text(
                    'Upload Blood Sample'.tr(),
                    style: getMediumTextStyle(
                      fontSize: FontSizeManager.s20,
                      color: ColorsManager.darkBlue,
                    ),
                  ),
                ],
              ),
              backgroundColor: ColorsManager.white,
              elevation: 0,
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.all(HeightManager.h16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PatientDropdown(
                    patients: widget.patients,
                    selected: selectedPatient,
                    onChanged:
                        (value) => setState(() {
                          selectedPatient = value;
                          _image = null;
                        }),
                  ),
                  SizedBox(height: HeightManager.h20),
                  SampleImagePreview(
                    image: _image,
                    networkImageUrl: selectedPatient?.latestSampleImageUrl,
                  ),
                  SizedBox(height: HeightManager.h20),
                  ImagePickerButtons(onPick: _pickImage),
                  SizedBox(height: HeightManager.h20),
                  AnalyzeButton(onPressed: _processImage),
                ],
              ),
            ),
            floatingActionButton: SampleFAB(
              patient: selectedPatient,
              doctor: widget.doctor,
            ),
          ),
        ),
      ],
    );
  }
}
