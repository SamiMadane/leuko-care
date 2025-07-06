import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:leuko_care/core/helpers/app_regex.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/widgets/app_drobdown_form_field.dart';
import 'package:leuko_care/core/widgets/app_text_form_field.dart';

class AddUpdatePatientFormFields extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final TextEditingController birthDateController;
  final bool isEditMode;
  final VoidCallback selectBirthDate;
  final bool isPatientUser;
  final TextEditingController genderController;
  final void Function(String)? onGenderChanged;

  const AddUpdatePatientFormFields({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.passwordController,
    required this.birthDateController,
    required this.isEditMode,
    required this.selectBirthDate,
    required this.isPatientUser,
    required this.genderController,
    this.onGenderChanged,
  });

  @override
  State<AddUpdatePatientFormFields> createState() =>
      _AddUpdatePatientFormFieldsState();
}

class _AddUpdatePatientFormFieldsState
    extends State<AddUpdatePatientFormFields> {
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  // خيارات الجنس
  String? _selectedGender = 'Male'; // القيمة الافتراضية
  final genderOptions = {'Male': 'Male'.tr(), 'Female': 'Female'.tr()};

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
          labelText: 'Name'.tr(),
          validator:
              (value) =>
                  value == null || value.isEmpty
                      ? 'Enter Name'.tr()
                      : !AppRegex.isNameValid(value)
                      ? 'Name must be at least 3 letters and contain letters only'.tr()
                      : null,
        ),

        if (!widget.isPatientUser) ...[
          SizedBox(height: HeightManager.h10),
          AppTextFormField(
            controller: widget.emailController,
            labelText: 'Email'.tr(),
            validator:
                (value) =>
                    value == null || value.isEmpty
                        ? 'Enter Email'.tr()
                        : !AppRegex.isEmailValid(value)
                        ? 'Invalid email format'.tr()
                        : null,
          ),
        ],

        SizedBox(height: HeightManager.h10),

        if (!widget.isEditMode) ...[
          AppTextFormField(
            controller: widget.passwordController,
            labelText: 'Password'.tr(),
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
                        ? 'Password is required'.tr()
                        : !AppRegex.isPasswordValid(value)
                        ? 'Weak password (min 8 chars, A-Z, a-z, number, special)'.tr()
                        : null,
          ),
          SizedBox(height: HeightManager.h10),

          AppTextFormField(
            controller: _confirmPasswordController,
            labelText: 'Confirm Password'.tr(),
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
                        ? 'Please confirm password'.tr()
                        : value != widget.passwordController.text
                        ? 'Passwords do not match'.tr()
                        : null,
          ),
          SizedBox(height: HeightManager.h10),
        ],

        AppTextFormField(
          controller: widget.phoneController,
          labelText: 'Phone'.tr(),
          validator:
              (value) =>
                  value == null || value.isEmpty
                      ? 'Enter Phone'.tr()
                      : !AppRegex.isPhoneNumberValid(value)
                      ? 'Invalid phone number'.tr()
                      : null,
        ),

        // إضافة حقل الجنس
        if (!widget.isEditMode) ...[
          SizedBox(height: HeightManager.h10),
          AppDropdownFormField<String>(
            value: _selectedGender,
            labelText: 'Gender'.tr(),
            items:genderOptions.entries
                    .map(
                      (entry) => DropdownMenuItem<String>(
                        value: entry.key,
                        child: Text(entry.value),
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
            validator: (value) => value == null ? 'Please select gender'.tr() : null,
          ),

          SizedBox(height: HeightManager.h10),
        ],

        if (!widget.isPatientUser) ...[
          SizedBox(height: HeightManager.h10),
          GestureDetector(
            onTap: widget.selectBirthDate,
            child: AbsorbPointer(
              child: AppTextFormField(
                controller: widget.birthDateController,
                labelText: 'Birth Date'.tr(),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Enter Birth Date'.tr()
                            : !AppRegex.isBirthDateValid(value)
                            ? 'Invalid Birth Date'.tr()
                            : null,
                keyboardType: TextInputType.datetime,
                suffixIcon: Icon(Icons.calendar_today, color: Colors.blue),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
