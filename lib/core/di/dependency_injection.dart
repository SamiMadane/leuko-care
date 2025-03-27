// GetIt => class dependency injection (files depend on each other).
import 'package:get_it/get_it.dart';
import 'package:leuko_care/feature/login/data/repository/login_repo.dart';
import 'package:leuko_care/feature/login/logic/cubit/login_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  getIt.registerLazySingleton(() => LoginRepository());
  getIt.registerFactory(() => LoginCubit(getIt<LoginRepository>()));
}
