import 'package:flutter/material.dart';
import 'package:leuko_care/core/helpers/app_regex.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/widgets/app_drobdown_form_field.dart';
import 'package:leuko_care/core/widgets/app_text_form_field.dart';

class AddUpdateDoctorFormFields extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController experienceController;
  final TextEditingController descriptionController;
  final TextEditingController passwordController;
  final bool isEditMode;
  final bool isDoctorUser;
  final TextEditingController genderController;
  final void Function(String)? onGenderChanged;

  const AddUpdateDoctorFormFields({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.experienceController,
    required this.descriptionController,
    required this.passwordController,
    required this.isEditMode,
    required this.isDoctorUser,
    required this.genderController,
    this.onGenderChanged,
  });

  @override
  State<AddUpdateDoctorFormFields> createState() =>
      _AddUpdateDoctorFormFieldsState();
}

class _AddUpdateDoctorFormFieldsState extends State<AddUpdateDoctorFormFields> {
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
    // خيارات الجنس
  String? _selectedGender = "Male"; // القيمة الافتراضية

  @override
  void initState() {
    super.initState();

    // ضبط القيمة الافتراضية في الـ Controller
    if (!widget.isEditMode) {
      widget.genderController.text = _selectedGender!;
    }
  }

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
        if (!widget.isDoctorUser) ...[
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
        ],

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

          // تأكيد كلمة المرور
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
         // إضافة حقل الجنس
        if (!widget.isEditMode) ...[
          SizedBox(height: HeightManager.h10),
          AppDropdownFormField<String>(
            value: _selectedGender,
            labelText: 'Gender',
            items:
                ['Male', 'Female']
                    .map(
                      (gender) => DropdownMenuItem<String>(
                        value: gender,
                        child: Text(gender),
                      ),
                    )
                    .toList(),
            onChanged: (value) {
              setState(() {
                _selectedGender = value;
                widget.genderController.text = value!;
                widget.onGenderChanged?.call(value);
              });
            },
            validator: (value) => value == null ? 'Please select gender' : null,
          ),

          SizedBox(height: HeightManager.h10),
        ],
        AppTextFormField(
          controller: widget.experienceController,
          labelText: 'Experience',
          validator:
              (value) =>
                  value == null || value.isEmpty
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
          validator:
              (value) =>
                  value == null || value.isEmpty
                      ? 'Enter Description'
                      : value.length < 10
                      ? 'Description too short'
                      : null,
        ),
      ],
    );
  }
}
