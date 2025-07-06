import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';

Future<void> setUpTestEnvironment(WidgetTester tester) async {
  tester.view.physicalSize = const Size(375, 812);
  tester.view.devicePixelRatio = 1.0;

  // إعادة تعيين الإعدادات بعد كل اختبار
  addTearDown(() {
    tester.view.resetPhysicalSize();
    tester.view.resetDevicePixelRatio();
  });
}

Widget buildTestableWidget(Widget child, {Locale locale = const Locale('en')}) {
  return EasyLocalization(
    supportedLocales: const [Locale('en'), Locale('ar')],
    path: 'assets/lang',
    fallbackLocale: const Locale('en'),
    startLocale: locale,
    child: ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, _) {
        FontFamilyManager.setLanguageCodeForTest(locale.languageCode);
        return MediaQuery(
          data: const MediaQueryData(size: Size(375, 812)),
          child: MaterialApp(
            locale: locale,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            localeResolutionCallback: (locale, supportedLocales) => locale,
            home: child,
          ),
        );
      },
    ),
  );
}
