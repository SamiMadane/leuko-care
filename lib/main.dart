import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leuko_care/core/di/dependency_injection.dart';
import 'package:leuko_care/firebase_options.dart' show DefaultFirebaseOptions;
import 'package:leuko_care/leuko_care.dart';
import 'core/routes/app_router.dart';

void main() async{ 
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    // ✅ إعداد Debug Provider فقط لبيئة التطوير
  // await FirebaseAppCheck.instance.activate(
  //   androidProvider: AndroidProvider.debug,
  // );
  await ScreenUtil.ensureScreenSize();  
  setupGetIt();
  runApp(LeukoAi(
    appRouter: AppRouter(),
  ));
}


