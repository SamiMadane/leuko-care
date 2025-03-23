// // GetIt => class dependency injection (files depend on each other).
// import 'package:dio/dio.dart';
// import 'package:get_it/get_it.dart';
// import 'package:leuko_care/core/networking/api_service.dart';
// import 'package:leuko_care/core/networking/dio_factory.dart';

// final getIt = GetIt.instance;

// Future<void> setupGetIt() async {
//   // Dio & ApiService
//   Dio dio = DioFactory.getDio();
//   getIt.registerLazySingleton<ApiService>(() => ApiService(dio));

//   // getIt.registerLazySingleton<LoginRepo>(() => LoginRepo(getIt()));
//   // getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt()));
// }
