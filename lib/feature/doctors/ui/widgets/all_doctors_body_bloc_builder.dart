import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/helpers/extensions.dart';
import 'package:leuko_care/core/resourses/colors_manager.dart';
import 'package:leuko_care/core/resourses/fonts_manager.dart';
import 'package:leuko_care/core/resourses/sizes_util_manager.dart';
import 'package:leuko_care/core/resourses/styles_manager.dart';
import 'package:leuko_care/core/routes/routes.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
import 'package:leuko_care/feature/doctors/data/repository/doctor_repo.dart';
import 'package:leuko_care/feature/doctors/logic/cubit/doctor_cubit.dart';
import 'package:leuko_care/feature/doctors/logic/cubit/doctor_state.dart';

class AllDoctorsBodyBlocBuilder extends StatelessWidget {
  const AllDoctorsBodyBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorCubit, DoctorState>(
      buildWhen:
          (previous, current) =>
              current is GetDoctorStateLoading ||
              current is GetDoctorStateSuccess ||
              current is GetDoctorStateError,
      builder: (context, state) {
        return state.whenOrNull(
              getDoctorStateLoading: () => _buildDoctorsLoadingWidget(),
              getDoctorStateSuccess:
                  (doctors) => _buildDoctorsSuccessWidget(doctors),
              getDoctorStateError:
                  (message) => _buildDoctorsErrorWidget(message: message),
            ) ??
            const SizedBox.shrink(); // fallback إذا لم تكن أي حالة
      },
    );
  }

  Widget _buildDoctorsLoadingWidget() {
    return Center(
      child: CircularProgressIndicator(color: ColorsManager.primaryColor),
    );
  }

  Widget _buildDoctorsSuccessWidget(List<DoctorModel> doctors) {
    if (doctors.isEmpty) {
      return const Center(child: Text('No doctors available.'));
    }

    return ListView.builder(
      itemCount: doctors.length,
      itemBuilder: (context, index) {
        final doctor = doctors[index];
        return Card(
          margin: EdgeInsets.symmetric(
            vertical: HeightManager.h8,
            horizontal: WidthManager.w16,
          ),
          elevation: 4,
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(
              vertical: HeightManager.h18,
              horizontal: WidthManager.w18,
            ),
            title: Text(
              doctor.name,
              style: getBoldTextStyle(
                fontSize: FontSizeManager.s18,
                color: ColorsManager.darkBlue,
              ),
            ),

            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: HeightManager.h6),
                Text(doctor.email),
                SizedBox(height: HeightManager.h4),
                FutureBuilder<int>(
                  future: context.read<DoctorCubit>().getPatientsCountForDoctor(
                    doctor.id!,
                  ),
                  builder:
                      (context, snapshot) => Text(
                        'Number of patients: ${snapshot.data ?? "..."}',
                        style: const TextStyle(
                          color: ColorsManager.primaryColor,
                        ),
                      ),
                ), // عرض عدد المرضى هنا
              ],
            ),
            leading: CircleAvatar(
              backgroundColor: ColorsManager.lightGray,
              backgroundImage: NetworkImage(
                doctor.profileImage,
                ),
              radius: RadiusManager.r28,
            ),
            onTap: () async{
              final patientsCount = await context.read<DoctorCubit>().getPatientsCountForDoctor(doctor.id!);
              context.pushNamed(
                Routes.doctorDetailsScreen,
                arguments: {
                  'doctor': doctor.toJson(),
                  'patientsCount': patientsCount,
                },
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildDoctorsErrorWidget({required String message}) {
    return Center(
      child: Text(message, style: const TextStyle(color: Colors.red)),
    );
  }
}
