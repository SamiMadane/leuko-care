import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/di/dependency_injection.dart';
import 'package:leuko_care/core/routes/routes.dart';
import 'package:leuko_care/feature/admin-home/ui/views/admin_home_screen.dart';
import 'package:leuko_care/feature/login/logic/cubit/login_cubit.dart';
import 'package:leuko_care/feature/user_selection/ui/views/user_selection_screen.dart';

import '../../feature/login/ui/views/login_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    //this arguments to be passed in any screen like this ( arguments as ClassName )
    final arguments = settings.arguments;
     final userType = arguments as String? ?? 'unknown';

    switch (settings.name) {
      case Routes.adminHomeScreen:
        return MaterialPageRoute(builder: (_) => const AdminHomeScreen());
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => getIt<LoginCubit>(),
                child: LoginScreen(userType:userType),
              ),
        );
      case Routes.userSelectionScreen:
        return MaterialPageRoute(builder: (_) => const UserSelectionScreen());
      default:
        return null;
    }
  }
}
