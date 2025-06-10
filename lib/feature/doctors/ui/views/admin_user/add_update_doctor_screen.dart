import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/core/widgets/add_update_profile_image_picker.dart';
import 'package:leuko_care/core/widgets/app_text_button.dart';
import 'package:leuko_care/core/widgets/pick_and_crop_image.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
import 'package:leuko_care/feature/doctors/logic/cubit/doctor_cubit.dart';
import 'package:leuko_care/feature/doctors/ui/widgets/shared/add_update_doctor_bloc_listener.dart';
import 'package:leuko_care/feature/doctors/ui/widgets/shared/add_update_doctor_form_fields.dart';

class AddUpdateDoctorScreen extends StatefulWidget {
  final DoctorModel? doctor;
  final String? userType;
  const AddUpdateDoctorScreen({super.key, this.doctor, this.userType});

  @override
  _AddUpdateDoctorScreenState createState() => _AddUpdateDoctorScreenState();
}

class _AddUpdateDoctorScreenState extends State<AddUpdateDoctorScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();

  String? profileImageUrl;

  @override
  void initState() {
    super.initState();

    if (widget.doctor != null) {
      _nameController.text = widget.doctor!.name;
      _emailController.text = widget.doctor!.email;
      _phoneController.text = widget.doctor!.phone;
      _experienceController.text = widget.doctor!.experience.toString(); 
      _descriptionController.text = widget.doctor!.description;
      _genderController.text = widget.doctor!.gender;

      profileImageUrl = widget.doctor!.profileImage;
    } else {
      profileImageUrl =
          'https://res.cloudinary.com/dmhmhyigi/image/upload/doctor_profile_wnyo6c.png';
    }
  }

Future<void> _pickImage() async {
  final croppedFile = await pickAndCropImage(context,ImageSource.gallery);
  if (croppedFile != null) {
    setState(() {
      profileImageUrl = croppedFile.path;
    });
    debugPrint('✅ New image path: ${croppedFile.path}');
  } else {
    debugPrint('❌ No image selected or crop cancelled');
  }
}



  void _handleGenderChanged(String gender) {
    setState(() {
      _genderController.text = gender;
      profileImageUrl =
          gender == 'Male'
              ? 'https://res.cloudinary.com/dmhmhyigi/image/upload/doctor_profile_wnyo6c.png'
              : 'https://res.cloudinary.com/dmhmhyigi/image/upload/doctor_profile_femail_rq9yqv';
    });
  }

  @override
  Widget build(BuildContext context) {
    final isEditMode = widget.doctor != null;
    final isDoctorUser = widget.userType == 'doctor'.tr();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditMode
              ? (isDoctorUser ? 'Edit Profile'.tr() : 'Edit Doctor'.tr())
              : 'Add Doctor'.tr(),
              style: getMediumTextStyle(fontSize: FontSizeManager.s20, color: ColorsManager.darkBlue),
        ),
        backgroundColor: ColorsManager.appBarColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
                AddUpdateDoctorFormFields(
                  isEditMode: isEditMode,
                  nameController: _nameController,
                  emailController: _emailController,
                  phoneController: _phoneController,
                  experienceController: _experienceController,
                  descriptionController: _descriptionController,
                  passwordController: _passwordController,
                  isDoctorUser: isDoctorUser,
                  genderController: _genderController,
                  onGenderChanged: _handleGenderChanged,
                ),
                SizedBox(height: HeightManager.h30),
                AppTextButton(
                  buttonText:
                      isEditMode
                          ? (isDoctorUser ? 'Update Profile'.tr() : 'Update Doctor'.tr())
                          : 'Add Doctor'.tr(),
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
      bottomNavigationBar: AddUpdateDoctorBlocListener(
        isDoctorUser: isDoctorUser,
      ),
    );
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      final doctor = DoctorModel(
        id: widget.doctor?.id,
        name: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        experience: int.tryParse(_experienceController.text) ?? 0,
        description: _descriptionController.text,
        profileImage: profileImageUrl ?? '',
        userType: '',
        gender: _genderController.text,
        fcmToken: widget.doctor?.fcmToken,
      );

      if (widget.doctor != null) {
        context.read<DoctorCubit>().updateDoctor(doctor);
      } else {
        context.read<DoctorCubit>().addDoctor(doctor, _passwordController.text);
      }
    }
  }
}
