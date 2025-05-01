import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/di/dependency_injection.dart';
import 'package:leuko_care/core/routes/routes.dart';
import 'package:leuko_care/feature/admin-home/data/repository/admin_home_repo.dart';
import 'package:leuko_care/feature/admin-home/logic/cubit/admin_home_cubit.dart';
import 'package:leuko_care/feature/admin-home/ui/views/admin_home_screen.dart';
import 'package:leuko_care/feature/admin-home/ui/views/admin_statistics_screen.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
import 'package:leuko_care/feature/doctors/logic/cubit/doctor_cubit.dart';
import 'package:leuko_care/feature/doctors/ui/views/add_update_doctor_screen.dart';
import 'package:leuko_care/feature/doctors/ui/views/all_doctors_screen.dart';
import 'package:leuko_care/feature/doctors/ui/views/doctor_details_screen.dart';
import 'package:leuko_care/feature/auth/logic/cubit/auth_cubit.dart';
import 'package:leuko_care/feature/onboarding/logic/onboarding_cubit.dart';
import 'package:leuko_care/feature/onboarding/ui/views/onboarding_screen.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';
import 'package:leuko_care/feature/patients/logic/cubit/patient_cubit.dart';
import 'package:leuko_care/feature/patients/ui/views/admin_user/add_update_patient_screen.dart';
import 'package:leuko_care/feature/patients/ui/views/admin_user/all_patients_screen.dart';
import 'package:leuko_care/feature/patients/ui/views/admin_user/patient_details_screen.dart';
import 'package:leuko_care/feature/patients/ui/views/patient_user/doctor_details_screen_for_patient.dart';
import 'package:leuko_care/feature/patients/ui/views/patient_user/patient_home_screen.dart';
import 'package:leuko_care/feature/patients/ui/views/patient_user/patient_profile_screen.dart';
import 'package:leuko_care/feature/user_selection/ui/views/user_selection_screen.dart';
import 'package:leuko_care/navigation_handler_screen.dart';

import '../../feature/auth/ui/views/login_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    //this arguments to be passed in any screen like this ( arguments as ClassName )
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.navigationHandlerScreen:
        return MaterialPageRoute(
          builder: (_) => const NavigationHandlerScreen(),
        );
      case Routes.onboardingScreen:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => OnboardingCubit(),
                child: const OnboardingScreen(),
              ),
        );
      case Routes.adminHomeScreen:
        return MaterialPageRoute(
          builder:
              (_) => MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create:
                        (context) => AdminHomeCubit(
                          adminHomeRepository: getIt<AdminHomeRepository>(),
                        )..getDoctors(),
                  ),
                  BlocProvider(create: (context) => getIt<AuthCubit>()),
                ],
                child: const AdminHomeScreen(),
              ),
        );

      case Routes.loginScreen:
        final userType = arguments as String? ?? 'unknown';
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => getIt<AuthCubit>(),
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
        final doctorDetails = arguments as DoctorModel;
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider.value(
                value: getIt<DoctorCubit>()..getDoctorsStream(),
                child: DoctorDetailsScreen(doctor: doctorDetails),
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
        final arguments = settings.arguments as Map?;

        final doctorId = arguments?['doctorId'] as String;
        final doctorName = arguments?['doctorName'] as String;
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider.value(
                value: getIt<PatientCubit>()..getPatientsByDoctorId(doctorId),
                child: AllPatientsScreen(
                  doctorId: doctorId,
                  doctorName: doctorName,
                ),
              ),
        );
      case Routes.patientDetailsScreen:
        final arguments = settings.arguments as Map?;
        final patientId = arguments?['patientId'] as String;
        final doctorId = arguments?['doctorId'] as String;
        final doctorName = arguments?['doctorName'] as String;

        return MaterialPageRoute(
          builder:
              (_) => BlocProvider.value(
                value: getIt<PatientCubit>()..getPatientsStream(),
                child: PatientDetailsScreen(
                  patientId: patientId,
                  doctorId: doctorId,
                  doctorName: doctorName,
                ),
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

      case Routes.adminStatisticsScreen:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider.value(
                value: getIt<AdminHomeCubit>()..getAdminStatistics(),
                child: AdminStatisticsScreen(),
              ),
        );

      case Routes.patientHomeScreen:
        final patientId = FirebaseAuth.instance.currentUser?.uid;
        return MaterialPageRoute(
          builder:
              (_) => MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create:
                        (_) =>
                            getIt<PatientCubit>()
                              ..getPatientAndDoctor(patientId!),
                  ),
                  BlocProvider(create: (_) => getIt<AuthCubit>()),
                ],
                child: PatientHomeScreen(),
              ),
        );

      case Routes.doctorDetailsScreenForPatient:
        final doctorDetailsForPatientScreen = arguments as DoctorModel;

        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => getIt<PatientCubit>(),
                child: DoctorDetailsScreenForPatient(
                  doctor: doctorDetailsForPatientScreen,
                ),
              ),
        );

      case Routes.patientProfileScreen:

        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => getIt<PatientCubit>()..getPatientsStream(),
                child: PatientProfileScreen(),
              ),
        );

      default:
        return null;
    }
  }
}
