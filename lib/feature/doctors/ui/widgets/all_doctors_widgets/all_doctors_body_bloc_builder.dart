import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/resourses/colors_manager.dart';
import 'package:leuko_care/feature/doctors/logic/cubit/doctor_cubit.dart';
import 'package:leuko_care/feature/doctors/logic/cubit/doctor_state.dart';
import 'package:leuko_care/feature/doctors/ui/widgets/all_doctors_widgets/all_doctors_list_view.dart';

class AllDoctorsBodyBlocBuilder extends StatelessWidget {
  const AllDoctorsBodyBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorCubit, DoctorState>(
      buildWhen: (previous, current) =>
          current is GetDoctorStateLoading ||
          current is GetDoctorStateSuccess ||
          current is GetDoctorStateError,
      builder: (context, state) {
        switch (state) {
          case GetDoctorStateLoading():
            return _buildDoctorsLoadingWidget();

          case GetDoctorStateSuccess():
            return AllDoctorsListView(doctors: state.doctors);

          case GetDoctorStateError():
            return _buildDoctorsErrorWidget(message: state.message);

          default:
            return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildDoctorsLoadingWidget() {
    return const Center(
      child: CircularProgressIndicator(color: ColorsManager.primaryColor),
    );
  }

  Widget _buildDoctorsErrorWidget({required String message}) {
    return Center(
      child: Text(message, style: const TextStyle(color: Colors.red)),
    );
  }
}
