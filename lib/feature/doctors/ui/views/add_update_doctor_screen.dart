import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/core/widgets/app_text_button.dart';
import 'package:leuko_care/core/widgets/app_text_form_field.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
import 'package:leuko_care/feature/doctors/logic/cubit/doctor_cubit.dart';
import 'package:leuko_care/feature/doctors/ui/widgets/add_update_doctor_widgets/add_update_doctor_bloc_listener.dart';
import 'package:leuko_care/feature/doctors/ui/widgets/add_update_doctor_widgets/add_update_doctor_profile_image_picker.dart';

class AddUpdateDoctorScreen extends StatefulWidget {
  final DoctorModel? doctor;
  const AddUpdateDoctorScreen({super.key, this.doctor});

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

  String? profileImageUrl;

  @override
  void initState() {
    super.initState();
    if (widget.doctor != null) {
      _nameController.text = widget.doctor!.name;
      _emailController.text = widget.doctor!.email;
      _phoneController.text = widget.doctor!.phone;
      _experienceController.text = widget.doctor!.experience;
      _descriptionController.text = widget.doctor!.description;
      profileImageUrl = widget.doctor!.profileImage;
    } else {
      profileImageUrl =
          'https://static.vecteezy.com/system/resources/previews/041/408/858/non_2x/ai-generated-a-smiling-doctor-with-glasses-and-a-white-lab-coat-isolated-on-transparent-background-free-png.png';
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

  @override
  Widget build(BuildContext context) {
    final isEditMode = widget.doctor != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditMode ? 'Edit Doctor' : 'Add Doctor'),
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
                // صورة الطبيب
                AddUpdateDoctorProfileImagePicker(
                  profileImageUrl: profileImageUrl!,
                  isEditMode: isEditMode,
                  onPickImage: _pickImage,
                ),

                SizedBox(height: HeightManager.h20),

                // الحقول الخاصة بمعلومات الطبيب
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
                    validator:
                        (value) => value!.isEmpty ? 'Enter Password' : null,
                  ),
                SizedBox(height: HeightManager.h10),
                AppTextFormField(
                  controller: _phoneController,
                  labelText: 'Phone',
                  validator: (value) => value!.isEmpty ? 'Enter Phone' : null,
                ),
                SizedBox(height: HeightManager.h10),
                AppTextFormField(
                  controller: _experienceController,
                  labelText: 'Experience',
                  validator:
                      (value) => value!.isEmpty ? 'Enter Experience' : null,
                ),
                SizedBox(height: HeightManager.h10),
                AppTextFormField(
                  controller: _descriptionController,
                  labelText: 'Description',
                  maxLines: 4,
                  validator:
                      (value) => value!.isEmpty ? 'Enter Description' : null,
                ),

                const SizedBox(height: 30),

                // زر الإضافة أو التحديث
                AppTextButton(
                  buttonText: isEditMode ? 'Update Doctor' : 'Add Doctor',
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
      bottomNavigationBar: AddUpdateDoctorBlocListener(),
    );
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      final doctor = DoctorModel(
        id: widget.doctor?.id,
        name: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        experience: _experienceController.text,
        description: _descriptionController.text,
        profileImage: profileImageUrl ?? '',
        userType: '',
      );

      if (widget.doctor != null) {
        context.read<DoctorCubit>().updateDoctor(doctor);
      } else {
        context.read<DoctorCubit>().addDoctor(doctor, _passwordController.text);
      }
    }
  }
}
