// GetIt => class dependency injection (files depend on each other).
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:leuko_care/feature/admin-home/data/repository/admin_home_repo.dart';
import 'package:leuko_care/feature/admin-home/logic/cubit/admin_home_cubit.dart';
import 'package:leuko_care/feature/doctors/data/repository/doctor_repo.dart';
import 'package:leuko_care/feature/doctors/logic/cubit/doctor_cubit.dart';
import 'package:leuko_care/feature/login/data/repository/login_repo.dart';
import 'package:leuko_care/feature/login/logic/cubit/login_cubit.dart';
import 'package:leuko_care/feature/patients/data/repository/patient_repo.dart';
import 'package:leuko_care/feature/patients/logic/cubit/patient_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {

    // تسجيل FirebaseFirestore كمصدر بيانات
  getIt.registerLazySingleton(() => FirebaseFirestore.instance);

  // تسجيل Login Repository & Cubit
  getIt.registerLazySingleton(() => LoginRepository());
  getIt.registerFactory(() => LoginCubit(getIt<LoginRepository>()));

  // تسجيل Doctor Repository & Cubit
  getIt.registerLazySingleton(() => DoctorRepository(getIt<FirebaseFirestore>()));
  getIt.registerFactory(() => DoctorCubit(getIt<DoctorRepository>()));

    // تسجيل Patient Repository & Cubit
  getIt.registerLazySingleton(() => PatientRepository(getIt<FirebaseFirestore>()));
  getIt.registerFactory(() => PatientCubit(getIt<PatientRepository>()));

  // تسجيل الـ AdminHomeRepository في GetIt مع تمریر الـ Repositories التي يعتمد عليها
  getIt.registerLazySingleton<AdminHomeRepository>(() => AdminHomeRepository(
    doctorRepository: getIt<DoctorRepository>(),
    patientRepository: getIt<PatientRepository>(),
  ));

  // تسجيل الـ AdminHomeCubit
  getIt.registerFactory(() => AdminHomeCubit(
    adminHomeRepository: getIt<AdminHomeRepository>(),
  ));
}
