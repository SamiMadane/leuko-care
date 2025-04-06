// 📁 lib/feature/doctors/ui/screens/all_doctors_screen.dart
import 'package:flutter/material.dart';
import 'package:leuko_care/core/helpers/extensions.dart';
import 'package:leuko_care/core/routes/routes.dart';
import 'package:leuko_care/core/resourses/colors_manager.dart';
import 'package:leuko_care/feature/doctors/ui/widgets/all_doctors_widgets/all_doctors_body_bloc_builder.dart';

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
              (route) => false,
            );
          },
        ),
      ),
      body: AllDoctorsBodyBlocBuilder(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed(Routes.addUpdateDoctorScreen);
        },
        backgroundColor: ColorsManager.primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
