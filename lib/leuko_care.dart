import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leuko_care/feature/login/ui/views/admin_login_screen.dart';
import 'core/resourses/colors_manager.dart';
import 'core/routes/app_router.dart';
import 'core/routes/routes.dart';


class LeukoCare extends StatelessWidget {
  final AppRouter appRouter;
  const LeukoCare({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: MaterialApp(
        title: 'Name App',
        theme: ThemeData(
          primaryColor: ColorsManager.primaryColor,
          scaffoldBackgroundColor: ColorsManager.white,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.userSelectionScreen,
        onGenerateRoute: appRouter.generateRoute,
      )
    );
  }
}

