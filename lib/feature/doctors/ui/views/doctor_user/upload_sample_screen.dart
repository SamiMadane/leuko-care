import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leuko_care/core/resources/assets_manager.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/feature/doctors/logic/cubit/doctor_cubit.dart';
import 'package:leuko_care/feature/doctors/logic/cubit/doctor_state.dart';
import 'package:leuko_care/feature/doctors/ui/views/doctor_user/sample_result_screen.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';

class UploadSampleScreen extends StatefulWidget {
  final List<PatientModel> patients;
  const UploadSampleScreen({super.key, required this.patients});

  @override
  State<UploadSampleScreen> createState() => _UploadSampleScreenState();
}

class _UploadSampleScreenState extends State<UploadSampleScreen> {
  File? _image;
  bool _isLoading = false;
  PatientModel? selectedPatient;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final picked = await _picker.pickImage(source: source);
    if (picked != null) {
      setState(() => _image = File(picked.path));
    }
  }

  Future<void> _processImage() async {
    if (_image == null || selectedPatient == null) return;

    setState(() => _isLoading = true);

    await Future.delayed(Duration(seconds: 3)); // simulate AI delay

    setState(() => _isLoading = false);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (_) => SampleResultScreen(
              patient: selectedPatient!,
              result: 'Positive',
              diseaseType: 'Acute Lymphoblastic Leukemia',
              confidence: 92.5,
              aiMessage:
                  'The AI model detected signs of Acute Lymphoblastic Leukemia with high confidence. Immediate medical attention is recommended.',
              sampleImageUrl:
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQNbGvhz9FycJFGdB6RGt49lL_T-tRULnYQTw&s',
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocListener<DoctorCubit, DoctorState>(
          listenWhen: (previous, current) {
            return current is DoctorBottomNavChanged && current.index != 2;
          },
          listener: (context, state) {
            setState(() {
              _image = null;
              selectedPatient = null;
            });
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                'Upload Blood Sample',
                style: getBoldTextStyle(
                  fontSize: FontSizeManager.s20,
                  color: ColorsManager.darkBlue,
                ),
              ),
              backgroundColor: ColorsManager.white,
              elevation: 0,
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.all(HeightManager.h16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Dropdown - Select patient
                  Text(
                    'Select Patient',
                    style: getMediumTextStyle(
                      fontSize: FontSizeManager.s16,
                      color: ColorsManager.darkBlue,
                    ),
                  ),
                  DropdownButton<PatientModel>(
                    isExpanded: true,
                    value: selectedPatient,
                    hint: Text("Choose patient"),
                    items:
                        widget.patients.map((patient) {
                          return DropdownMenuItem(
                            value: patient,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(patient.name),
                                if (patient.isExamined == true)
                                  Text(
                                    'Tested',
                                    style: TextStyle(color: Colors.green),
                                  ),
                              ],
                            ),
                          );
                        }).toList(),
                    onChanged: (value) {
                      setState(() => selectedPatient = value);
                    },
                  ),

                  SizedBox(height: HeightManager.h24),

                  /// Image preview
                  Center(
                    child: Container(
                      width: double.infinity,
                      height: HeightManager.h200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.grey[200],
                        image:
                            _image != null
                                ? DecorationImage(
                                  image: FileImage(_image!),
                                  fit: BoxFit.cover,
                                )
                                : null,
                      ),
                      child:
                          _image == null
                              ? Center(
                                child: Icon(
                                  Icons.image_outlined,
                                  size: 60,
                                  color: Colors.grey,
                                ),
                              )
                              : null,
                    ),
                  ),

                  SizedBox(height: HeightManager.h16),

                  /// Buttons to pick image or take photo
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () => _pickImage(ImageSource.gallery),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorsManager.primaryColor,
                        ),
                        icon: Icon(
                          Icons.image_outlined,
                          color: ColorsManager.white,
                        ),
                        label: Text(
                          "From Gallery",
                          style: getMediumTextStyle(
                            fontSize: FontSizeManager.s14,
                            color: ColorsManager.white,
                          ),
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () => _pickImage(ImageSource.camera),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorsManager.primaryColor,
                        ),
                        icon: Icon(
                          Icons.camera_alt,
                          color: ColorsManager.white,
                        ),
                        label: Text(
                          "Use Camera",
                          style: getMediumTextStyle(
                            fontSize: FontSizeManager.s14,
                            color: ColorsManager.white,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: HeightManager.h24),

                  /// Analyze Button
                  Center(
                    child: ElevatedButton(
                      onPressed: _processImage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsManager.primaryColor,
                        padding: EdgeInsets.symmetric(
                          horizontal: WidthManager.w40,
                          vertical: HeightManager.h12,
                        ),
                      ),
                      child: Text(
                        "Analyze Sample",
                        style: getMediumTextStyle(
                          fontSize: FontSizeManager.s14,
                          color: ColorsManager.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// FAB if patient already has result
            floatingActionButton:
                selectedPatient != null && selectedPatient!.isExamined == true
                    ? ClipOval(
                      child: FloatingActionButton(
                        backgroundColor: ColorsManager.primaryColor,
                        child: Image.asset(
                          AssetsManager.chemicalAnalysisIcon,
                          width: WidthManager.w30,
                          height: HeightManager.h30,
                          color: ColorsManager.white,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (_) => SampleResultScreen(
                                    patient: selectedPatient!,
                                    result: 'Positive',
                                    diseaseType: 'Acute Lymphoblastic Leukemia',
                                    confidence: 92.5,
                                    aiMessage:
                                        'The AI model detected signs of Acute Lymphoblastic Leukemia with high confidence. Immediate medical attention is recommended.',
                                    sampleImageUrl:
                                        'https://upload.wikimedia.org/wikipedia/commons/0/0e/Acute_leukemia-ALL.jpg',
                                  ),
                            ),
                          );
                        },
                      ),
                    )
                    : null,
          ),
        ),

        /// Loading overlay
        if (_isLoading)
          Container(
            color: Colors.white.withOpacity(0.8),
            child: Center(
              child: CircularProgressIndicator(
                color: ColorsManager.primaryColor,
              ),
            ),
          ),
      ],
    );
  }
}
