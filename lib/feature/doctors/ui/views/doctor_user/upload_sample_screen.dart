import 'package:easy_localization/easy_localization.dart';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/core/widgets/custom_status_dialog.dart';
import 'package:leuko_care/core/widgets/pick_and_crop_image.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
import 'package:leuko_care/feature/doctors/logic/cubit/doctor_cubit.dart';
import 'package:leuko_care/feature/doctors/ui/widgets/doctor_user/upload_sample_screen.dart/analyze_bloc_listener.dart';
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

  Future<void> _processImage() async {
    final cubit = context.read<DoctorCubit>();

    // 1. التحقق من اختيار المريض
    if (selectedPatient == null) {
      showAnimatedStatusDialog(
        context: context,
        statusType: DialogStatusType.warning,
        title: 'Warning'.tr(),
        message: 'Please select a patient first.'.tr(),
      );
      return;
    }

    // 2. إذا تم اختيار صورة جديدة، حلّلها
    if (_image != null) {
      final imageFile = File(_image!.path);
      cubit.analyzeSample(imageFile: imageFile, patient: selectedPatient!);
      return;
    }

    // 3. إذا كان لدى المريض صورة سابقة، أرسل رابطها مباشرة
    final imageUrl = selectedPatient!.latestSampleImageUrl;
    if (imageUrl != null && imageUrl.isNotEmpty) {
      cubit.analyzeSample(imageUrl: imageUrl, patient: selectedPatient!);
      return;
    }

    // 4. لا صورة جديدة ولا قديمة
    showAnimatedStatusDialog(
      context: context,
      statusType: DialogStatusType.warning,
      title: 'Warning'.tr(),
      message:
          'Please select a sample image or choose a patient with an existing sample.'
              .tr(),
    );
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
  @override
Widget build(BuildContext context) {
  return Scaffold(
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
            onChanged: (value) => setState(() {
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

          /// ✅ BlocListener يلتف فقط حول زر التحليل
          AnalyzeBlocListener(
            doctor: widget.doctor,
            selectedPatient: selectedPatient, // يمكن أن تكون null وسندير ذلك داخل الـ BlocListener
            child: AnalyzeButton(onPressed: _processImage),
          ),
        ],
      ),
    ),
    floatingActionButton: selectedPatient != null
        ? SampleFAB(
            patient: selectedPatient!,
            doctor: widget.doctor,
          )
        : null,
  );
}
}