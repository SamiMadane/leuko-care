import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/resources/assets_manager.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/feature/doctors/logic/cubit/doctor_cubit.dart';

class DoctorFab extends StatelessWidget {
  const DoctorFab({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<DoctorCubit>();
    final isHomeSelected = cubit.selectedIndex == 2;

    return AnimatedScale(
      scale: isHomeSelected ? 1.2 : 1.0,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      child: FloatingActionButton(
        onPressed: () {
          if (!isHomeSelected) {
            cubit.goToPage(2);
          }
        },
        backgroundColor:
            isHomeSelected
                ? ColorsManager.primaryColor.withValues(alpha: 0.8)
                : ColorsManager.primaryColor,
        shape: const CircleBorder(),
        child: AnimatedOpacity(
          opacity: isHomeSelected ? 0.8 : 1.0,
          duration: const Duration(milliseconds: 200),
          child: Image.asset(
            AssetsManager.homeIcon,
            width: WidthManager.w26,
            height: HeightManager.h26,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
