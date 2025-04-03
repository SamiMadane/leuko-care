import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leuko_care/core/resourses/colors_manager.dart';
import 'package:leuko_care/core/resourses/sizes_util_manager.dart';
import 'package:leuko_care/core/resourses/styles_manager.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
import 'package:leuko_care/feature/doctors/logic/cubit/doctor_cubit.dart';
import 'package:leuko_care/feature/doctors/ui/widgets/add_update_doctor_bloc_listener.dart';

class AddDoctorScreen extends StatefulWidget {
  final DoctorModel? doctor;
  const AddDoctorScreen({super.key, this.doctor});

  @override
  _AddDoctorScreenState createState() => _AddDoctorScreenState();
}

class _AddDoctorScreenState extends State<AddDoctorScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? profileImageUrl; // مسار الصورة المختارة

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

  @override
  Widget build(BuildContext context) {
    final isEditMode = widget.doctor != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEditMode ? 'Edit Doctor' : 'Add Doctor')),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // ✅ صورة الطبيب + زر تعديل أو إضافة صورة
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: !profileImageUrl!.startsWith('http')
                              ?  Image.file(File(profileImageUrl!)).image
                              :  NetworkImage(profileImageUrl!),
                          backgroundColor: Colors.grey[300],
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: _pickImage,
                            child: CircleAvatar(
                              radius: 18,
                              backgroundColor: ColorsManager.primaryColor,
                              child: Icon(
                                isEditMode
                                    ? Icons.edit
                                    : Icons.add,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                    validator: (value) => value!.isEmpty ? 'Enter a name' : null,
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (value) => value!.isEmpty ? 'Enter an email' : null,
                  ),
                  !isEditMode ? TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter a password';
                      } else if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ): Container(),
                  TextFormField(
                    controller: _phoneController,
                    decoration: const InputDecoration(labelText: 'Phone'),
                    validator: (value) => value!.isEmpty ? 'Enter a phone number' : null,
                  ),
                  TextFormField(
                    controller: _experienceController,
                    decoration: const InputDecoration(labelText: 'Experience'),
                    validator: (value) => value!.isEmpty ? 'Enter an Experience' : null,
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(labelText: 'Description'),
                    validator: (value) => value!.isEmpty ? 'Enter a Description' : null,
                    maxLines: 4,
                  ),

                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final doctor = DoctorModel(
                          id: widget.doctor?.id,
                          name: _nameController.text,
                          email: _emailController.text,
                          phone: _phoneController.text,
                          experience: _experienceController.text,
                          description: _descriptionController.text,
                          profileImage: profileImageUrl ?? '', // استخدام الصورة المختارة
                          userType: '',
                        );

                        if (isEditMode) {
                          context.read<DoctorCubit>().updateDoctor(doctor);
                        } else {
                          context.read<DoctorCubit>().addDoctor(doctor, _passwordController.text);
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorsManager.primaryColor,
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    ),
                    child: Text(
                      isEditMode ? 'Update Doctor' : 'Add Doctor',
                      style: getSemiBoldTextStyle(fontSize: IconSizeManager.s14, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const AddUpdateDoctorBlocListener(),
        ],
      ),
    );
  }
}
