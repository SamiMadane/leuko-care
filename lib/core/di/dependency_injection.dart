// GetIt => class dependency injection (files depend on each other).
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:leuko_care/feature/doctors/data/repository/doctor_repo.dart';
import 'package:leuko_care/feature/doctors/logic/cubit/doctor_cubit.dart';
import 'package:leuko_care/feature/login/data/repository/login_repo.dart';
import 'package:leuko_care/feature/login/logic/cubit/login_cubit.dart';

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
}
