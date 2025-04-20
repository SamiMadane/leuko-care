import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/widgets/app_text_form_field.dart';

class AddUpdateDoctorFormFields extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController experienceController;
  final TextEditingController descriptionController;
  final TextEditingController passwordController;
  final bool isEditMode;

  const AddUpdateDoctorFormFields({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.experienceController,
    required this.descriptionController,
    required this.passwordController,
    required this.isEditMode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTextFormField(
          controller: nameController,
          labelText: 'Name',
          validator: (value) => value!.isEmpty ? 'Enter Name' : null,
        ),
        SizedBox(height: HeightManager.h10),
        AppTextFormField(
          controller: emailController,
          labelText: 'Email',
          validator: (value) => value!.isEmpty ? 'Enter Email' : null,
        ),
        SizedBox(height: HeightManager.h10),
        if (!isEditMode)
          AppTextFormField(
            controller: passwordController,
            labelText: 'Password',
            isObscureText: true,
            validator: (value) => value!.isEmpty ? 'Enter Password' : null,
          ),
        SizedBox(height: HeightManager.h10),
        AppTextFormField(
          controller: phoneController,
          labelText: 'Phone',
          validator: (value) => value!.isEmpty ? 'Enter Phone' : null,
        ),
        SizedBox(height: HeightManager.h10),
        AppTextFormField(
          controller: experienceController,
          labelText: 'Experience',
          validator: (value) => value!.isEmpty ? 'Enter Experience' : null,
        ),
        SizedBox(height: HeightManager.h10),
        AppTextFormField(
          controller: descriptionController,
          labelText: 'Description',
          maxLines: 4,
          validator: (value) => value!.isEmpty ? 'Enter Description' : null,
        ),
      ],
    );
  }
}
