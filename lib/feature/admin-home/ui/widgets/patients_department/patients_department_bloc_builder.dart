import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/feature/admin-home/logic/cubit/admin_home_cubit.dart';
import 'package:leuko_care/feature/admin-home/logic/cubit/admin_home_state.dart';
import 'package:leuko_care/feature/admin-home/ui/widgets/patients_department/patients_department_list_view.dart';
import 'package:leuko_care/feature/admin-home/ui/widgets/patients_department/patients_department_shimmer_loading.dart';

class PatientsDepartmentBlocBuilder extends StatelessWidget {
  const PatientsDepartmentBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final _ = context.locale;
    return BlocBuilder<AdminHomeCubit, AdminHomeState>(
      buildWhen:
          (previous, current) =>
              current is GetPatientsStateLoading ||
              current is GetPatientsStateError ||
              current is GetPatientsStateSuccess,
      builder: (context, state) {
        return switch (state) {
          GetPatientsStateLoading() => const PatientsDepartmentShimmerLoading(),
          GetPatientsStateError() => const SizedBox.shrink(),
          GetPatientsStateSuccess(patients: var patients) => PatientsDepartmentListView(patients: patients),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }
}
