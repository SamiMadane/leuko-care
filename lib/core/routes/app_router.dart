import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/di/dependency_injection.dart';
import 'package:leuko_care/core/routes/routes.dart';
import 'package:leuko_care/feature/admin-home/ui/views/admin_home_screen.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
import 'package:leuko_care/feature/doctors/logic/cubit/doctor_cubit.dart';
import 'package:leuko_care/feature/doctors/ui/views/add_update_doctor_screen.dart';
import 'package:leuko_care/feature/doctors/ui/views/all_doctors_screen.dart';
import 'package:leuko_care/feature/doctors/ui/views/doctor_details_screen.dart';
import 'package:leuko_care/feature/login/logic/cubit/login_cubit.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';
import 'package:leuko_care/feature/patients/logic/cubit/patient_cubit.dart';
import 'package:leuko_care/feature/patients/ui/views/add_update_patient_screen.dart';
import 'package:leuko_care/feature/patients/ui/views/all_patients_screen.dart';
import 'package:leuko_care/feature/patients/ui/views/patient_details_screen.dart';
import 'package:leuko_care/feature/user_selection/ui/views/user_selection_screen.dart';
import 'package:leuko_care/navigation_handler_screen.dart';

import '../../feature/login/ui/views/login_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    //this arguments to be passed in any screen like this ( arguments as ClassName )
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.navigationHandlerScreen:
        return MaterialPageRoute(
          builder: (_) => const NavigationHandlerScreen(),
        );
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
                child: DoctorDetailsScreen(
                  doctor: doctorDetails,
                  patientsCount: patientsCount,
                ),
              ),
        );
      case Routes.addUpdateDoctorScreen:
        final doctorModel = arguments as DoctorModel? ?? null;

        return MaterialPageRoute(
          builder:
              (_) => BlocProvider.value(
                value: getIt<DoctorCubit>(),
                child: AddUpdateDoctorScreen(doctor: doctorModel),
              ),
        );
      case Routes.allPatientsScreen:
      final String doctorId = arguments as String;
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider.value(
                value: getIt<PatientCubit>()..getPatientsStream(),
                child: AllPatientsScreen(
                  doctorId: doctorId,
                ),
              ),
        );
      case Routes.patientDetailsScreen:
        final patientDetails = arguments as PatientModel;
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider.value(
                value: getIt<PatientCubit>()..getPatientsStream(),
                child: PatientDetailsScreen(patient: patientDetails),
              ),
        );
      case Routes.addUpdatePatientScreen:
        final arguments = settings.arguments as Map?;
        final patientModel = arguments?['patientModel'] as PatientModel?;
        final doctorId = arguments?['doctorId'] as String?;

        return MaterialPageRoute(
          builder:
              (_) => BlocProvider.value(
                value: getIt<PatientCubit>(),
                child: AddUpdatePatientScreen(
                  patient: patientModel,
                  doctorId: doctorId,
                ),
              ),
        );
      default:
        return null;
    }
  }
}
