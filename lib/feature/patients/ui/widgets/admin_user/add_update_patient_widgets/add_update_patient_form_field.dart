import 'package:flutter/material.dart';
import 'package:leuko_care/core/helpers/app_regex.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/widgets/app_text_form_field.dart';

class AddUpdatePatientFormFields extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final TextEditingController birthDateController;
  final bool isEditMode;
  final VoidCallback selectBirthDate;

  const AddUpdatePatientFormFields({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.passwordController,
    required this.birthDateController,
    required this.isEditMode,
    required this.selectBirthDate,
  });

  @override
  State<AddUpdatePatientFormFields> createState() =>
      _AddUpdateDoctorFormFieldsState();
}

class _AddUpdateDoctorFormFieldsState
    extends State<AddUpdatePatientFormFields> {
  final TextEditingController _confirmPasswordController =
      TextEditingController();
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
          validator:
              (value) =>
                  value == null || value.isEmpty
                      ? 'Enter Name'
                      : !AppRegex.isNameValid(value)
                      ? 'Name must be at least 3 letters and contain letters only'
                      : null,
        ),
        SizedBox(height: HeightManager.h10),
        AppTextFormField(
          controller: widget.emailController,
          labelText: 'Email',
          validator:
              (value) =>
                  value == null || value.isEmpty
                      ? 'Enter Email'
                      : !AppRegex.isEmailValid(value)
                      ? 'Invalid email format'
                      : null,
        ),
        SizedBox(height: HeightManager.h10),

        if (!widget.isEditMode) ...[
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
            validator:
                (value) =>
                    value == null || value.isEmpty
                        ? 'Password is required'
                        : !AppRegex.isPasswordValid(value)
                        ? 'Weak password (min 8 chars, A-Z, a-z, number, special)'
                        : null,
          ),
          SizedBox(height: HeightManager.h10),

          AppTextFormField(
            controller: _confirmPasswordController,
            labelText: 'Confirm Password',
            isObscureText: !_isConfirmPasswordVisible,
            suffixIcon: IconButton(
              icon: Icon(
                _isConfirmPasswordVisible
                    ? Icons.visibility
                    : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                });
              },
            ),
            validator:
                (value) =>
                    value == null || value.isEmpty
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
          validator:
              (value) =>
                  value == null || value.isEmpty
                      ? 'Enter Phone'
                      : !AppRegex.isPhoneNumberValid(value)
                      ? 'Invalid phone number'
                      : null,
        ),
        SizedBox(height: HeightManager.h10),
        GestureDetector(
          onTap: widget.selectBirthDate,
          child: AbsorbPointer(
            child: AppTextFormField(
              controller: widget.birthDateController,
              labelText: 'Birth Date',
              validator:
                  (value) =>
                      value == null || value.isEmpty
                          ? 'Enter Birth Date'
                          : !AppRegex.isBirthDateValid(value)
                          ? 'Invalid Birth Date'
                          : null,
              keyboardType: TextInputType.datetime,
              suffixIcon: Icon(Icons.calendar_today, color: Colors.blue),
            ),
          ),
        ),
      ],
    );
  }
}
