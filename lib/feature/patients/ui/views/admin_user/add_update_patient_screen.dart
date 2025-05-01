import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/core/widgets/app_text_button.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';
import 'package:leuko_care/feature/patients/logic/cubit/patient_cubit.dart';
import 'package:leuko_care/feature/patients/ui/widgets/shared/add_update_patient_bloc_listener.dart';
import 'package:leuko_care/feature/patients/ui/widgets/shared/add_update_patient_form_field.dart';
import 'package:leuko_care/core/widgets/add_update_profile_image_picker.dart';

class AddUpdatePatientScreen extends StatefulWidget {
  final PatientModel? patient;
  final String? doctorId;
  final String? doctorName;
  final String? userType;

  const AddUpdatePatientScreen({
    super.key,
    this.patient,
    this.doctorId,
    this.doctorName,
    this.userType,
  });

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
      profileImageUrl =
          'https://res.cloudinary.com/dmhmhyigi/image/upload/patient_profile_osluzn.png';
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      setState(() {
        profileImageUrl = pickedImage.path;
      });
    }
  }

  Future<void> _selectBirthDate() async {
    final DateTime initialDate =
        _birthDateController.text.isNotEmpty
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
    final isPatientUser = widget.userType == 'patient';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditMode
              ? (isPatientUser ? 'Edit Profile' : 'Edit Patient')
              : 'Add Patient',
          style: getMediumTextStyle(
            fontSize: FontSizeManager.s20,
            color: ColorsManager.darkBlue,
          ),
        ),
        elevation: 0,
        backgroundColor: isPatientUser ? Colors.white : null,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: WidthManager.w20,
          vertical: HeightManager.h16,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AddUpdateProfileImagePicker(
                  profileImageUrl: profileImageUrl!,
                  isEditMode: isEditMode,
                  onPickImage: _pickImage,
                ),
                SizedBox(height: HeightManager.h20),
                AddUpdatePatientFormFields(
                  nameController: _nameController,
                  emailController: _emailController,
                  phoneController: _phoneController,
                  passwordController: _passwordController,
                  birthDateController: _birthDateController,
                  isEditMode: isEditMode,
                  selectBirthDate: _selectBirthDate,
                  isPatientUser: isPatientUser,
                ),
                SizedBox(height: HeightManager.h30),
                AppTextButton(
                  buttonText:
                      isEditMode
                          ? (isPatientUser
                              ? 'Update Profile'
                              : 'Update Patient')
                          : 'Add Patient',
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
      bottomNavigationBar: AddUpdatePatientBlocListener(
        isPatientUser: isPatientUser,
      ),
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
        isExamined: widget.patient?.isExamined ?? false,
        registrationDate:
            widget.patient?.registrationDate ??
            DateFormat('yyyy-MM-dd').format(DateTime.now()),
        healthStatus: widget.patient?.healthStatus ?? 'unknown',
        birthDate: _birthDateController.text,
        leukemiaType: widget.patient?.leukemiaType ?? 'unknown',
      );

      if (widget.patient != null) {
        context.read<PatientCubit>().updatePatient(patient);
      } else {
        context.read<PatientCubit>().addPatient(
          patient,
          _passwordController.text,
        );
      }
    }
  }
}
