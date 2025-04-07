import 'package:flutter/material.dart';
import 'package:leuko_care/core/helpers/extensions.dart';
import 'package:leuko_care/core/resourses/colors_manager.dart';
import 'package:leuko_care/core/routes/routes.dart';
import 'package:leuko_care/feature/patients/ui/widgets/all_patients_widgets/all_patients_body_bloc_builder.dart';

class AllPatientsScreen extends StatelessWidget {
  final String doctorId;

  const AllPatientsScreen({super.key, required this.doctorId});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patients List'),
      ),
      body: AllPatientsBodyBlocBuilder(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed(
            Routes.addUpdatePatientScreen,
            arguments: {doctorId: doctorId},
          );
        },
        backgroundColor: ColorsManager.primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
