import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/feature/chats/logic/cubit/chat_cubit.dart';
import 'package:leuko_care/feature/chats/ui/views/chat_screen.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';
import 'package:shimmer/shimmer.dart';

class DoctorChatsScreen extends StatelessWidget {
  final DoctorModel doctor;
  final List<PatientModel> patients;

  const DoctorChatsScreen({
    super.key,
    required this.patients,
    required this.doctor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(width: WidthManager.w8),
            Text(
              'Your Patients',
              style: getBoldTextStyle(
                fontSize: FontSizeManager.s20,
                color: ColorsManager.darkBlue,
              ),
            ),
          ],
        ),
        elevation: 0,
        backgroundColor: ColorsManager.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(HeightManager.h16),
        child:
            patients.isEmpty
                ? const Center(child: Text('No patients available for chat'))
                : ListView.separated(
                  itemCount: patients.length,
                  separatorBuilder:
                      (_, __) => SizedBox(height: HeightManager.h12),
                  itemBuilder: (context, index) {
                    final patient = patients[index];
                    return _buildPatientCard(patient, context);
                  },
                ),
      ),
    );
  }

  Widget _buildPatientCard(PatientModel patient, BuildContext context) {
    return Material(
      color: ColorsManager.moreLighterGray,
      elevation: 4,
      borderRadius: BorderRadius.circular(RadiusManager.r16),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (_) => BlocProvider.value(
                    value: context.read<ChatCubit>(),
                    child: ChatScreen(
                      currentUserId: doctor.id!,
                      otherUserId: patient.id!,
                      patient: patient,
                    ),
                  ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(RadiusManager.r16),
        child: Padding(
          padding: EdgeInsets.all(HeightManager.h16),
          child: Row(
            children: [
              ClipOval(
                child: CachedNetworkImage(
                  width: HeightManager.h60,
                  height: HeightManager.h60,
                  fit: BoxFit.cover,
                  imageUrl: patient.profileImage,
                  placeholder:
                      (context, url) => Shimmer.fromColors(
                        baseColor: ColorsManager.lightGray,
                        highlightColor: Colors.white,
                        child: CircleAvatar(
                          radius: RadiusManager.r34,
                          backgroundColor: Colors.white,
                        ),
                      ),
                  errorWidget:
                      (context, url, error) =>
                          Icon(Icons.person, size: HeightManager.h56),
                ),
              ),
              SizedBox(width: WidthManager.w12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      patient.name,
                      style: getBoldTextStyle(
                        fontSize: FontSizeManager.s16,
                        color: ColorsManager.darkBlue,
                      ),
                    ),
                    SizedBox(height: HeightManager.h6),
                    Text(
                      patient.email,
                      style: getRegularTextStyle(
                        fontSize: FontSizeManager.s14,
                        color: ColorsManager.gray,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Icon(
                    Icons.chat_outlined,
                    color: ColorsManager.primaryColor,
                    size: HeightManager.h24,
                  ),
                  SizedBox(height: HeightManager.h6),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: HeightManager.h16,
                    color: ColorsManager.gray,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
