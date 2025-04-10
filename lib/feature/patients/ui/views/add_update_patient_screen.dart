import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:leuko_care/core/resourses/fonts_manager.dart';
import 'package:leuko_care/core/resourses/sizes_util_manager.dart';
import 'package:leuko_care/core/resourses/styles_manager.dart';
import 'package:leuko_care/core/widgets/app_text_button.dart';
import 'package:leuko_care/core/widgets/app_text_form_field.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';
import 'package:leuko_care/feature/patients/logic/cubit/patient_cubit.dart';
import 'package:leuko_care/feature/patients/ui/widgets/add_patient_widgets/add_update_patient_bloc_listener.dart';
import 'package:leuko_care/feature/patients/ui/widgets/add_patient_widgets/add_update_patient_profile_image_picker.dart';

class AddUpdatePatientScreen extends StatefulWidget {
  final PatientModel? patient;
  final String? doctorId;

  const AddUpdatePatientScreen({super.key, this.patient, this.doctorId});

  @override
  _AddUpdatePatientScreenState createState() => _AddUpdatePatientScreenState();
}

class _AddUpdatePatientScreenState extends State<AddUpdatePatientScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();

  String? profileImageUrl;

  @override
  void initState() {
    super.initState();
    if (widget.patient != null) {
      _nameController.text = widget.patient!.name;
      _emailController.text = widget.patient!.email;
      _phoneController.text = widget.patient!.phone;
      _birthDateController.text = widget.patient!.birthDate;
      profileImageUrl = widget.patient!.profileImage;
    } else {
      profileImageUrl = 'https://static.vecteezy.com/system/resources/previews/041/408/858/non_2x/ai-generated-a-smiling-doctor-with-glasses-and-a-white-lab-coat-isolated-on-transparent-background-free-png.png';
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        profileImageUrl = pickedImage.path;
      });
    }
  }

  Future<void> _selectBirthDate() async {
     final DateTime initialDate = _birthDateController.text.isNotEmpty
      ? DateFormat('yyyy-MM-dd').parse(_birthDateController.text)
      : DateTime(2000);
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      _birthDateController.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditMode = widget.patient != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditMode ? 'Edit Patient' : 'Add Patient'),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: WidthManager.w20, vertical: HeightManager.h16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AddUpdatePatientProfileImagePicker(
                  profileImageUrl: profileImageUrl!,
                  isEditMode: isEditMode,
                  onPickImage: _pickImage,
                ),
                SizedBox(height: HeightManager.h20),
                AppTextFormField(
                  controller: _nameController,
                  labelText: 'Name',
                  validator: (value) => value!.isEmpty ? 'Enter Name' : null,
                ),
                SizedBox(height: HeightManager.h10),
                AppTextFormField(
                  controller: _emailController,
                  labelText: 'Email',
                  validator: (value) => value!.isEmpty ? 'Enter Email' : null,
                ),
                SizedBox(height: HeightManager.h10),
                if (!isEditMode)
                  AppTextFormField(
                    controller: _passwordController,
                    labelText: 'Password',
                    isObscureText: true,
                    validator: (value) => value!.isEmpty ? 'Enter Password' : null,
                  ),
                SizedBox(height: HeightManager.h10),
                AppTextFormField(
                  controller: _phoneController,
                  labelText: 'Phone',
                  validator: (value) => value!.isEmpty ? 'Enter Phone' : null,
                ),
                SizedBox(height: HeightManager.h10),
                GestureDetector(
                  onTap: _selectBirthDate,
                  child: AbsorbPointer(
                    child: AppTextFormField(
                      controller: _birthDateController,
                      labelText: 'Birth Date',
                      validator: (value) => value!.isEmpty ? 'Enter Birth Date' : null,
                      keyboardType: TextInputType.datetime,
                      suffixIcon: Icon(Icons.calendar_today, color: Colors.blue),

                    ),
                  ),
                ),
                const SizedBox(height: 30),
                AppTextButton(
                  buttonText: isEditMode ? 'Update Patient' : 'Add Patient',
                  textStyle: getBoldTextStyle(
                    fontSize: FontSizeManager.s18,
                    color: Colors.white,
                  ),
                  onPressed: _handleSubmit,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const AddUpdatePatientBlocListener(),
    );
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      final patient = PatientModel(
        id: widget.patient?.id,
        name: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        profileImage: profileImageUrl ?? '',
        doctorId: widget.patient?.doctorId ?? widget.doctorId!,
        userType: 'patient',
        isExamined: false,
        registrationDate: DateFormat('yyyy-MM-dd').format(DateTime.now()),
        healthStatus: 'unknown', // سيتم تحديده بعد رفع العينة
        birthDate: _birthDateController.text,
      );

      if (widget.patient != null) {
        context.read<PatientCubit>().updatePatient(patient);
      } else {
        context.read<PatientCubit>().addPatient(patient, _passwordController.text);
      }
    }
  }
}
