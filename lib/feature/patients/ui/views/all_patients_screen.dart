import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/helpers/extensions.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/routes/routes.dart';
import 'package:leuko_care/feature/patients/logic/cubit/patient_cubit.dart';
import 'package:leuko_care/feature/patients/ui/widgets/all_patients_widgets/all_patients_body_bloc_builder.dart';

class AllPatientsScreen extends StatefulWidget {
  final String doctorId;
  final String doctorName;

  const AllPatientsScreen({
    super.key,
    required this.doctorId,
    required this.doctorName,
  });

  @override
  State<AllPatientsScreen> createState() => _AllPatientsScreenState();
}

class _AllPatientsScreenState extends State<AllPatientsScreen> {
    @override
  void initState() {
    super.initState();
    context.read<PatientCubit>().getPatientsByDoctorId(widget.doctorId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Patients of Dr. ${widget.doctorName}')),
      body: AllPatientsBodyBlocBuilder(
        doctorId: widget.doctorId,
        doctorName: widget.doctorName,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed(
            Routes.addUpdatePatientScreen,
            arguments: {'doctorId': widget.doctorId},
          );
        },
       shape: const CircleBorder(),
        
        backgroundColor: ColorsManager.primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
  
}
