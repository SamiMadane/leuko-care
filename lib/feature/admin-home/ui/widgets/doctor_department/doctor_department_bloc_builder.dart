import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/resourses/colors_manager.dart';
import 'package:leuko_care/core/resourses/fonts_manager.dart';
import 'package:leuko_care/core/resourses/styles_manager.dart';
import 'package:leuko_care/feature/admin-home/logic/cubit/admin_home_cubit.dart';
import 'package:leuko_care/feature/admin-home/logic/cubit/admin_home_state.dart';
import 'package:leuko_care/feature/admin-home/ui/widgets/doctor_department/doctor_department_list_view.dart';
import 'package:leuko_care/feature/admin-home/ui/widgets/doctor_department/doctor_department_shimmer_loading.dart';

class DoctorsDepartmentBlocBuilder extends StatelessWidget {
  const DoctorsDepartmentBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminHomeCubit, AdminHomeState>(
      buildWhen:
          (previous, current) =>
              current is GetDoctorsStateLoading ||
              current is GetDoctorsStateError ||
              current is GetDoctorsStateSuccess,
      builder: (context, state) {
        return switch (state) {
          GetDoctorsStateLoading() => const DoctorDepartmentShimmerLoading(),
          GetDoctorsStateError() => const SizedBox.shrink(),
          GetDoctorsStateSuccess(doctors: var doctors) => DoctorsDepartmentListView(doctors: doctors),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }

}
