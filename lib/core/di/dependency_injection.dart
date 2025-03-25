// GetIt => class dependency injection (files depend on each other).
import 'package:get_it/get_it.dart';
import 'package:leuko_care/feature/login/data/repository/admin_login_repo.dart';
import 'package:leuko_care/feature/login/logic/cubit/admin_login_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  getIt.registerLazySingleton(() => AdminLoginRepository());
  getIt.registerFactory(() => AdminLoginCubit(getIt<AdminLoginRepository>()));
}
