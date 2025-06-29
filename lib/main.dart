import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leuko_care/core/di/dependency_injection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:leuko_care/core/helpers/shared_pref_helper.dart';
import 'package:leuko_care/feature/chats/data/models/hive_adapter/message_status_adapter.dart';
import 'package:leuko_care/feature/chats/data/models/hive_adapter/timestamp_adapter.dart';
import 'package:leuko_care/core/networking/notification_service.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/feature/chats/data/models/chat_model.dart';
import 'package:leuko_care/firebase_options.dart' show DefaultFirebaseOptions;
import 'package:leuko_care/leuko_ai.dart';
import 'core/routes/app_router.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FontFamilyManager.init();
  await NotificationService.init();

  await ScreenUtil.ensureScreenSize();
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,
    appleProvider: AppleProvider.debug,
  );
  setupGetIt();
  await Hive.initFlutter();
  Hive.registerAdapter(ChatModelAdapter());
  Hive.registerAdapter(TimestampAdapter());
  Hive.registerAdapter(MessageStatusAdapter());

  final localeCode = await SharedPrefHelper.getLocale();
  final startLocale = Locale(localeCode);

  final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
  final userType = await SharedPrefHelper.getString('userType');
  if (initialMessage != null) {
    NotificationService.setPendingNotification(initialMessage.data, userType);
  }

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/lang',
      fallbackLocale: const Locale('en'),
      startLocale: startLocale,
      ignorePluralRules: false,
      child: LeukoAi(appRouter: AppRouter()),
    ),
  );
}
