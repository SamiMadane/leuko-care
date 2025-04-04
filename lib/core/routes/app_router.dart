import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/di/dependency_injection.dart';
import 'package:leuko_care/core/routes/routes.dart';
import 'package:leuko_care/feature/admin-home/ui/views/admin_home_screen.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
import 'package:leuko_care/feature/doctors/logic/cubit/doctor_cubit.dart';
import 'package:leuko_care/feature/doctors/ui/views/add_doctor_screen.dart';
import 'package:leuko_care/feature/doctors/ui/views/all_doctors_screen.dart';
import 'package:leuko_care/feature/doctors/ui/views/doctor_details_screen.dart';
import 'package:leuko_care/feature/login/logic/cubit/login_cubit.dart';
import 'package:leuko_care/feature/user_selection/ui/views/user_selection_screen.dart';

import '../../feature/login/ui/views/login_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    //this arguments to be passed in any screen like this ( arguments as ClassName )
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.adminHomeScreen:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create:
                    (context) =>
                        getIt<DoctorCubit>()
                          ..getDoctorsStream(), // تمرير DoctorCubit هنا
                child: const AdminHomeScreen(),
              ),
        );
      case Routes.loginScreen:
        final userType = arguments as String? ?? 'unknown';
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => getIt<LoginCubit>(),
                child: LoginScreen(userType: userType),
              ),
        );
      case Routes.userSelectionScreen:
        return MaterialPageRoute(builder: (_) => const UserSelectionScreen());
      case Routes.allDoctorsScreen:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider.value(
                value: getIt<DoctorCubit>()..getDoctorsStream(),
                child: AllDoctorsScreen(),
              ),
        );
      case Routes.doctorDetailsScreen:
        final args = arguments as Map<String, dynamic>;
        final doctorDetails = DoctorModel.fromJson(
          args['doctor'] as Map<String, dynamic>,
        );
        final patientsCount = args['patientsCount'] as int;

        return MaterialPageRoute(
          builder:
              (_) => BlocProvider.value(
                value: getIt<DoctorCubit>()..getDoctorsStream(),
                child: DoctorDetailsScreen(doctor: doctorDetails,  patientsCount: patientsCount),
              ),
        );
      case Routes.addDoctorScreen:
        final doctorModel = arguments as DoctorModel? ?? null;
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider.value(
                value: getIt<DoctorCubit>(),
                child: AddDoctorScreen(doctor: doctorModel),
              ),
        );
      default:
        return null;
    }
  }
}
