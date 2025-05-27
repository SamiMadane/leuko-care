import 'package:easy_localization/easy_localization.dart';

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
          Text('Error loading data'.tr()),
          ElevatedButton(
            onPressed: () {
              if (doctorId != null) {
                context.read<DoctorCubit>().getDoctorAndPatients(doctorId!);
              }
            },
            child: Text('Retry'.tr()),
          ),
        ],
      ),
    );
  }
}