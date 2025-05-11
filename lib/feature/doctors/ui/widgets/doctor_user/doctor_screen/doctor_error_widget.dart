import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/feature/doctors/logic/cubit/doctor_cubit.dart';

class DoctorErrorWidget extends StatelessWidget {
  final String? doctorId;
  const DoctorErrorWidget({super.key, this.doctorId});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Error loading data"),
          ElevatedButton(
            onPressed: () {
              if (doctorId != null) {
                context.read<DoctorCubit>().getDoctorAndPatients(doctorId!);
              }
            },
            child: const Text("Retry"),
          ),
        ],
      ),
    );
  }
}