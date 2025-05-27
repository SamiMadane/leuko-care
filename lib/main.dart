import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leuko_care/core/di/dependency_injection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:leuko_care/core/helpers/shared_pref_helper.dart';
import 'package:leuko_care/firebase_options.dart' show DefaultFirebaseOptions;
import 'package:leuko_care/leuko_ai.dart';
import 'core/routes/app_router.dart';

void main() async{ 
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await NotificationService.init();
  await ScreenUtil.ensureScreenSize();  
  setupGetIt();
  final localeCode = await SharedPrefHelper.getLocale();
  final startLocale = Locale(localeCode);
   runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/lang', 
      fallbackLocale: const Locale('ar'),
      startLocale: startLocale,
      child: LeukoAi(
        appRouter: AppRouter(),
      ),
    ),
  );
}


