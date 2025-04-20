import 'package:flutter/material.dart';
import 'package:leuko_care/core/helpers/app_regex.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/widgets/app_text_form_field.dart';

class AddUpdateDoctorFormFields extends StatefulWidget {
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
  State<AddUpdateDoctorFormFields> createState() =>
      _AddUpdateDoctorFormFieldsState();
}

class _AddUpdateDoctorFormFieldsState extends State<AddUpdateDoctorFormFields> {
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void dispose() {
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTextFormField(
          controller: widget.nameController,
          labelText: 'Name',
          validator: (value) => value == null || value.isEmpty
              ? 'Enter Name'
              : value.length < 3
                  ? 'Name is too short'
                  : null,
        ),
        SizedBox(height: HeightManager.h10),
        AppTextFormField(
          controller: widget.emailController,
          labelText: 'Email',
          validator: (value) => value == null || value.isEmpty
              ? 'Enter Email'
              : !AppRegex.isEmailValid(value)
                  ? 'Invalid email format'
                  : null,
        ),
        SizedBox(height: HeightManager.h10),

        if (!widget.isEditMode) ...[
          // كلمة المرور
          AppTextFormField(
            controller: widget.passwordController,
            labelText: 'Password',
            isObscureText: !_isPasswordVisible,
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
            validator: (value) => value == null || value.isEmpty
                ? 'Password is required'
                : !AppRegex.isPasswordValid(value)
                    ? 'Weak password (min 8 chars, A-Z, a-z, number, special)'
                    : null,
          ),
          SizedBox(height: HeightManager.h10),

          // تأكيد كلمة المرور
          AppTextFormField(
            controller: _confirmPasswordController,
            labelText: 'Confirm Password',
            isObscureText: !_isConfirmPasswordVisible,
            suffixIcon: IconButton(
              icon: Icon(
                _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                });
              },
            ),
            validator: (value) => value == null || value.isEmpty
                ? 'Please confirm password'
                : value != widget.passwordController.text
                    ? 'Passwords do not match'
                    : null,
          ),
          SizedBox(height: HeightManager.h10),
        ],

        AppTextFormField(
          controller: widget.phoneController,
          labelText: 'Phone',
          validator: (value) => value == null || value.isEmpty
              ? 'Enter Phone'
              : !AppRegex.isPhoneNumberValid(value)
                  ? 'Invalid phone number'
                  : null,
        ),
        SizedBox(height: HeightManager.h10),
        AppTextFormField(
          controller: widget.experienceController,
          labelText: 'Experience',
          validator: (value) => value == null || value.isEmpty
              ? 'Enter Experience'
              : int.tryParse(value) == null
                  ? 'Must be a number'
                  : null,
        ),
        SizedBox(height: HeightManager.h10),
        AppTextFormField(
          controller: widget.descriptionController,
          labelText: 'Description',
          maxLines: 4,
          validator: (value) => value == null || value.isEmpty
              ? 'Enter Description'
              : value.length < 10
                  ? 'Description too short'
                  : null,
        ),
      ],
    );
  }
}
