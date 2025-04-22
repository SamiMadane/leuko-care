import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/resources/colors_manager.dart';
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
        title: 'Leuko Care',
        theme: ThemeData(
          primaryColor: ColorsManager.primaryColor,
          scaffoldBackgroundColor: ColorsManager.white,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.navigationHandlerScreen,
        onGenerateRoute: appRouter.generateRoute,
      )
    );
  }
}

