import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/helpers/extensions.dart';
import 'package:leuko_care/core/routes/routes.dart';
import 'package:leuko_care/feature/doctors/logic/cubit/doctor_cubit.dart';
import 'package:leuko_care/feature/doctors/logic/cubit/doctor_state.dart';
import 'package:leuko_care/core/resourses/colors_manager.dart';

class AllDoctorsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctors List'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.adminHomeScreen,
              (route) => false, // إزالة جميع الشاشات السابقة
            );
          },
        ),
      ),
      body: BlocBuilder<DoctorCubit, DoctorState>(
        builder: (context, state) {
          if (state is GetDoctorStateLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: ColorsManager.primaryColor,
              ),
            );
          }

          if (state is GetDoctorStateSuccess) {
            if (state.doctors.isEmpty) {
              return Center(child: Text('No doctors available.'));
            }

            return ListView.builder(
              itemCount: state.doctors.length,
              itemBuilder: (context, index) {
                final doctor = state.doctors[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  elevation: 4,
                  child: ListTile(
                    contentPadding: EdgeInsets.all(18),
                    title: Text(doctor.name),
                    subtitle: Text(doctor.email),
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      backgroundImage: NetworkImage(
                        doctor.profileImage.isEmpty
                            ? 'https://static.vecteezy.com/system/resources/previews/041/408/858/non_2x/ai-generated-a-smiling-doctor-with-glasses-and-a-white-lab-coat-isolated-on-transparent-background-free-png.png'
                            : doctor.profileImage,
                      ),
                      radius: 28,
                    ),
                    onTap: () {
                      context.pushNamed(
                        Routes.doctorDetailsScreen,
                        arguments: doctor.toJson(),
                      );
                    },
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to add doctor screen
          context.pushNamed(Routes.addDoctorScreen);
        },
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: ColorsManager.primaryColor,
      ),
    );
  }
}
