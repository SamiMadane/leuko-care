import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/resourses/sizes_util_manager.dart';
import 'package:leuko_care/feature/admin-home/logic/cubit/admin_home_cubit.dart';
import 'package:leuko_care/feature/admin-home/ui/widgets/doctor_department/doctor_department_add_item.dart';
import 'package:leuko_care/feature/admin-home/ui/widgets/doctor_department/doctor_department_list_view_item.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';

class DoctorsDepartmentListView extends StatelessWidget {
  final List<DoctorModel> doctors;
  const DoctorsDepartmentListView({super.key,required this.doctors});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: HeightManager.h100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: doctors.length + 1,
        itemBuilder: (context, index) {
          if (index == doctors.length) {
            return const DoctorDepartmentAddItem();
          }
          final doctor = doctors[index];
          final isSelected =
              doctor == context.read<AdminHomeCubit>().selectedDoctor;
          return DoctorDepartmentListViewItem(
            doctor: doctor,
            isSelected: isSelected,
            index: index,
          );
        },
      ),
    );
  }

}
