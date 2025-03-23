import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leuko_care/leuko_care.dart';
import 'core/routes/app_router.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();  
  runApp(LeukoCare(
    appRouter: AppRouter(),
  ));
}


