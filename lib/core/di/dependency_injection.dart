// GetIt => class dependency injection (files depend on each other).
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:leuko_care/core/usecases/get_doctors_ordered_by_patients_count_usecase.dart';
import 'package:leuko_care/feature/admin-home/data/repository/admin_home_repo.dart';
import 'package:leuko_care/feature/admin-home/logic/cubit/admin_home_cubit.dart';
import 'package:leuko_care/feature/chats/data/repository/chat_repo.dart';
import 'package:leuko_care/feature/chats/logic/cubit/chat_cubit.dart';
import 'package:leuko_care/feature/doctors/data/repository/doctor_repo.dart';
import 'package:leuko_care/feature/doctors/logic/cubit/doctor_cubit.dart';
import 'package:leuko_care/feature/auth/data/repository/auth_repo.dart';
import 'package:leuko_care/feature/auth/logic/cubit/auth_cubit.dart';
import 'package:leuko_care/feature/patients/data/repository/patient_repo.dart';
import 'package:leuko_care/feature/patients/logic/cubit/patient_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // تسجيل FirebaseFirestore كمصدر بيانات
  getIt.registerLazySingleton(() => FirebaseFirestore.instance);

  // تسجيل Login Repository & Cubit
  getIt.registerLazySingleton(() => AuthRepository());
  getIt.registerFactory(() => AuthCubit(getIt<AuthRepository>()));

  // تسجيل Doctor Repository & Cubit
  getIt.registerLazySingleton(
    () => DoctorRepository(
      firestore: getIt<FirebaseFirestore>(),
      getDoctorsOrderedByPatientsCountUseCase:
          getIt<GetDoctorsOrderedByPatientsCountUseCase>(),
    ),
  );
  getIt.registerFactory(() => DoctorCubit(getIt<DoctorRepository>()));

  // تسجيل Patient Repository & Cubit
  getIt.registerLazySingleton(
    () => PatientRepository(getIt<FirebaseFirestore>()),
  );
  getIt.registerFactory(() => PatientCubit(getIt<PatientRepository>()));

  // تسجيل الـ AdminHomeRepository في GetIt مع تمریر الـ Repositories التي يعتمد عليها
  getIt.registerLazySingleton<AdminHomeRepository>(
    () => AdminHomeRepository(
      doctorRepository: getIt<DoctorRepository>(),
      patientRepository: getIt<PatientRepository>(),
      getDoctorsOrderedByPatientsCountUseCase:
          getIt<GetDoctorsOrderedByPatientsCountUseCase>(),
    ),
  );

  // تسجيل الـ AdminHomeCubit
  getIt.registerFactory(
    () => AdminHomeCubit(adminHomeRepository: getIt<AdminHomeRepository>()),
  );

  getIt.registerLazySingleton<GetDoctorsOrderedByPatientsCountUseCase>(
    () => GetDoctorsOrderedByPatientsCountUseCase(getIt<PatientRepository>()),
  );
  getIt.registerLazySingleton(() => ChatRepository(getIt<FirebaseFirestore>()));
  getIt.registerFactory(() => ChatCubit(getIt<ChatRepository>()));
}
