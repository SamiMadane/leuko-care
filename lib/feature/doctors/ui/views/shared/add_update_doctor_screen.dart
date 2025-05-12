import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/core/widgets/add_update_profile_image_picker.dart';
import 'package:leuko_care/core/widgets/app_text_button.dart';
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
          'https://res.cloudinary.com/dmhmhyigi/image/upload/doctor_profile_wnyo6c.png';
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
    final isDoctorUser = widget.userType == 'doctor';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditMode
              ? (isDoctorUser ? 'Edit Profile' : 'Edit Doctor')
              : 'Add Doctor',
        ),
        backgroundColor: isDoctorUser ? Colors.white : null,  
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
                ),
                SizedBox(height: HeightManager.h30),
                AppTextButton(
                  buttonText:isEditMode
                          ? (isDoctorUser
                              ? 'Update Profile'
                              : 'Update Doctor')
                          : 'Add Doctor',
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
