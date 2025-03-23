import 'package:flutter/material.dart';
import 'package:leuko_care/core/routes/routes.dart';

import '../../feature/login/ui/views/login_screen.dart';
import '../../feature/onboarding/ui/views/onboarding_screen.dart';



class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    //this arguments to be passed in any screen like this ( arguments as ClassName )
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.onBoardingScreen:
        return MaterialPageRoute(
          builder: (_) => const onBoardingScreen(),
        );
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
      default:
        return null;
    }
  }
}
