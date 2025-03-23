import 'dart:io';

void main() {
  final directories = [
    'lib/core/networking',
    'lib/core/di',
    'lib/core/themes',
    'lib/core/routes',
    'lib/core/resourses',
    'lib/core/widgets',
    'lib/core/di',
    'lib/core/helpers',
    'lib/core/util',
    'lib/feature/onboarding/data/models',
    'lib/feature/onboarding/data/repository',
    'lib/feature/onboarding/logic',
    'lib/feature/onboarding/ui/views',
    'lib/feature/onboarding/ui/widgets',

    'lib/feature/login/data/models',
    'lib/feature/login/data/repository',
    'lib/feature/login/logic',
    'lib/feature/login/ui/views',
    'lib/feature/login/ui/widgets',
  ];

  for (var dir in directories) {
    final directory = Directory(dir);
    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
      print('Folder Created: $dir');
    }
  }

  File('lib/name_app.dart').createSync();
  File('lib/main.dart').createSync();
  File('lib/core/routes/app_router.dart').createSync();
  File('lib/core/routes/routes.dart').createSync();
  File('lib/core/helpers/extensions.dart').createSync();
  File('lib/core/util/size_util.dart').createSync();
  File('lib/core/resourses/colors_manager.dart').createSync();
  File('lib/core/resourses/fonts_manager.dart').createSync();
  File('lib/core/resourses/sizes_util_manager.dart').createSync();
  File('lib/core/resourses/styles_manager.dart').createSync();
  File('lib/core/resourses/assets_manager.dart').createSync();
  File('lib/core/di/dependency_injection.dart').createSync();
  File('lib/feature/onboarding/ui/views/onboarding_screen.dart').createSync();
  File('lib/feature/login/ui/views/login_screen.dart').createSync();
  File('lib/core/networking/api_constants.dart').createSync();
  File('lib/core/networking/api_service.dart').createSync();
  File('lib/core/networking/dio_factory.dart').createSync();
  File('lib/core/networking/api_error_model.dart').createSync();
  File('lib/core/networking/api_error_handler.dart').createSync();
  File('lib/core/networking/api_result.dart').createSync();



  File('lib/core/networking/api_constants.dart').writeAsStringSync('''

class ApiConstants {
  static const String apiBaseUrl = "https://api.example.com/";
  static const String login = "auth/login";
  static const String signup = "auth/register";
}

class ApiErrors {
  static const String badRequestError = "badRequestError";
  static const String noContent = "noContent";
  static const String forbiddenError = "forbiddenError";
  static const String unauthorizedError = "unauthorizedError";
  static const String notFoundError = "notFoundError";
  static const String conflictError = "conflictError";
  static const String internalServerError = "internalServerError";
  static const String unknownError = "unknownError";
  static const String timeoutError = "timeoutError";
  static const String defaultError = "defaultError";
  static const String cacheError = "cacheError";
  static const String noInternetError = "noInternetError";
  static const String loadingMessage = "loading_message";
  static const String retryAgainMessage = "retry_again_message";
  static const String ok = "Ok";
}

''');

  File('lib/core/di/dependency_injection.dart').writeAsStringSync('''
  // GetIt => class dependency injection (files depend on each other).
import 'package:chat_ai/core/networking/api_service.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../networking/dio_factory.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Dio & ApiService
  Dio dio = DioFactory.getDio();
  getIt.registerLazySingleton<ApiService>(() => ApiService(dio));


  // getIt.registerLazySingleton<LoginRepo>(() => LoginRepo(getIt()));
  // getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt()));

}
''');
  File('lib/core/networking/api_service.dart').writeAsStringSync('''
  import 'package:dio/dio.dart';
// part 'api_service.g.dart';



// @RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  // @POST(ApiConstants.login)
  // Future<LoginResponse> login(
  //   @Body() LoginRequestBody loginRequestBody,
  // );

  // @POST(ApiConstants.signup)
  // Future<SignupResponse> signup(
  //   @Body() SignupRequestBody signupRequestBody,
  // );
}
''');

  File('lib/core/networking/dio_factory.dart').writeAsStringSync('''
import 'package:dio/dio.dart';;
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../helpers/constants.dart';
import '../helpers/shared_pref_helper.dart';

class DioFactory {
  /// private constructor as I don't want to allow creating an instance of this class
  DioFactory._();

  static Dio? dio;

  static Dio getDio() {
    Duration timeOut = const Duration(seconds: 30);

    if (dio == null) {
      dio = Dio();
      dio!
        ..options.connectTimeout = timeOut
        ..options.receiveTimeout = timeOut;
      addDioHeader();
      addDioInterceptor();
      return dio!;
    } else {
      return dio!;
    }
  }

  static void addDioHeader() async{
    dio?.options.headers = {
      'Accept': 'application/json',
      'Authorization':
          'Bearer {await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken)}',
    };
  }

  static void setTokenIntoHeaderAfterLogin(String token) {
    dio?.options.headers = {'Authorization': 'Bearer token'};
  }

  static void addDioInterceptor() {
    dio?.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
    );
  }
}
''');
  File('lib/core/routes/app_router.dart').writeAsStringSync('''
import 'package:chat_ai/core/routes/routes.dart';
import 'package:flutter/material.dart';

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
''');
  File('lib/core/routes/routes.dart').writeAsStringSync('''
class Routes {
  static const String onBoardingScreen = '/onBoardingScreen';
  static const String loginScreen = '/loginScreen';
}
''');
  File('lib/feature/onboarding/ui/views/onboarding_screen.dart').writeAsStringSync('''
import 'package:flutter/material.dart';

class onBoardingScreen extends StatelessWidget {
  const onBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

''');
  File('lib/feature/login/ui/views/login_screen.dart').writeAsStringSync('''
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
''');
  File('lib/core/util/size_util.dart').writeAsStringSync('''
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SizeUtil {
  // Width (dp)
  static double setWidth(double width) {
    return width.w;
  }

  // Height (dp)
  static double setHeight(double height) {
    return height.h;
  }

  // Font Size (sp)
  static double setFontSize(double font) {
    return font.sp;
  }

  // Radius (dp)
  static double setRadius(double radius) {
    return radius.r;
  }
}

''');

  File('lib/core/resourses/colors_manager.dart').writeAsStringSync('''
import 'package:flutter/material.dart';

class ColorsManager {
  static const Color primaryColor = Color(0xFF247CFF);
  static const Color gray = Color(0xFF757575);
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color grey = Colors.grey;
  static const Color red = Colors.red;
  static const Color blue = Colors.blue;
}

''');
  File('lib/core/resourses/styles_manager.dart').writeAsStringSync('''
import 'package:chat_ai/core/resourses/fonts_manager.dart';
import 'package:flutter/material.dart';

TextStyle _getTextStyle(
  double fontSize,
  FontWeight fontWeight,
  Color color,
  TextDecoration decoration,
  dynamic overflow,
  double height,
) {
  return TextStyle(
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
    decoration: decoration,
    overflow: overflow,
    height: height,
  );
}

// Regular TextStyle
TextStyle getRegularTextStyle({
  required double fontSize,
  required Color color,
  dynamic overflow = TextOverflow.visible,
  TextDecoration decoration = TextDecoration.none,
  double? height,
}) {
  return _getTextStyle(
    fontSize,
    FontWeightManager.regular,
    color,
    decoration,
    overflow,
    height ?? 1.0,
  );
}

// Medium TextStyle
TextStyle getMediumTextStyle({
  required double fontSize,
  required Color color,
  TextDecoration decoration = TextDecoration.none,
  dynamic overflow = TextOverflow.visible,
  double? height,
}) {
  return _getTextStyle(
    fontSize,
    FontWeightManager.medium,
    color,
    decoration,
    overflow,
    height ?? 1.0,
  );
}

// SemiBold TextStyle
TextStyle getSemiBoldTextStyle({
  required double fontSize,
  required Color color,
  TextDecoration decoration = TextDecoration.none,
  dynamic overflow = TextOverflow.visible,
  double? height,
}) {
  return _getTextStyle(
    fontSize,
    FontWeightManager.semiBold,
    color,
    decoration,
    overflow,
    height ?? 1.0,
  );
}

// Bold TextStyle
TextStyle getBoldTextStyle({
  required double fontSize,
  required Color color,
  TextDecoration decoration = TextDecoration.none,
  dynamic overflow = TextOverflow.visible,
  double? height,
}) {
  return _getTextStyle(
    fontSize,
    FontWeightManager.bold,
    color,
    decoration,
    overflow,
    height ?? 1.0,
  );
}



''');
  File('lib/core/resourses/sizes_util_manager.dart').writeAsStringSync('''


import '../util/size_util.dart';

class RadiusManager {
  static double r2 = SizeUtil.setRadius(2.0);
  static double r4 = SizeUtil.setRadius(4.0);
  static double r6 = SizeUtil.setRadius(6.0);
  static double r8 = SizeUtil.setRadius(8.0);
  static double r10 = SizeUtil.setRadius(10.0);
  static double r12 = SizeUtil.setRadius(12.0);
  static double r14 = SizeUtil.setRadius(14.0);
  static double r16 = SizeUtil.setRadius(16.0);
  static double r18 = SizeUtil.setRadius(18.0);
  static double r20 = SizeUtil.setRadius(20.0);
  static double r22 = SizeUtil.setRadius(22.0);
  static double r24 = SizeUtil.setRadius(24.0);
  static double r26 = SizeUtil.setRadius(26.0);
  static double r28 = SizeUtil.setRadius(28.0);
  static double r30 = SizeUtil.setRadius(30.0);
  static double r40 = SizeUtil.setRadius(40.0);
  static double r50 = SizeUtil.setRadius(50.0);
  static double r80 = SizeUtil.setRadius(80.0);
  static double r100 = SizeUtil.setRadius(100.0);
}

class WidthManager {
  static double w0_9 = SizeUtil.setWidth(0.9);
  static double w1 = SizeUtil.setWidth(1.0);
  static double w1_5 = SizeUtil.setWidth(1.5);
  static double w2 = SizeUtil.setWidth(2.0);
  static double w4 = SizeUtil.setWidth(4.0);
  static double w6 = SizeUtil.setWidth(6.0);
  static double w8 = SizeUtil.setWidth(8.0);
  static double w10 = SizeUtil.setWidth(10.0);
  static double w12 = SizeUtil.setWidth(12.0);
  static double w14 = SizeUtil.setWidth(14.0);
  static double w16 = SizeUtil.setWidth(16.0);
  static double w18 = SizeUtil.setWidth(18.0);
  static double w20 = SizeUtil.setWidth(20.0);
  static double w22 = SizeUtil.setWidth(22.0);
  static double w24 = SizeUtil.setWidth(24.0);
  static double w26 = SizeUtil.setWidth(26.0);
  static double w28 = SizeUtil.setWidth(28.0);
  static double w30 = SizeUtil.setWidth(30.0);
  static double w32 = SizeUtil.setWidth(32.0);
  static double w36 = SizeUtil.setWidth(36.0);
  static double w40 = SizeUtil.setWidth(40.0);
  static double w48 = SizeUtil.setWidth(48.0);
  static double w49 = SizeUtil.setWidth(49.0);
  static double w50 = SizeUtil.setWidth(50.0);
  static double w60 = SizeUtil.setWidth(60.0);
  static double w68 = SizeUtil.setWidth(68.0);
  static double w76 = SizeUtil.setWidth(76.0);
  static double w80 = SizeUtil.setWidth(80.0);
  static double w100 = SizeUtil.setWidth(100.0);
  static double w812 = SizeUtil.setWidth(812.0);

}

class HeightManager {
  static double h1 = SizeUtil.setHeight(1.0);
  static double h2 = SizeUtil.setHeight(2.0);
  static double h4 = SizeUtil.setHeight(4.0);
  static double h6 = SizeUtil.setHeight(6.0);
  static double h8 = SizeUtil.setHeight(8.0);
  static double h10 = SizeUtil.setHeight(10.0);
  static double h12 = SizeUtil.setHeight(12.0);
  static double h14 = SizeUtil.setHeight(14.0);
  static double h16 = SizeUtil.setHeight(16.0);
  static double h18 = SizeUtil.setHeight(18.0);
  static double h20 = SizeUtil.setHeight(20.0);
  static double h22 = SizeUtil.setHeight(22.0);
  static double h24 = SizeUtil.setHeight(24.0);
  static double h26 = SizeUtil.setHeight(26.0);
  static double h28 = SizeUtil.setHeight(28.0);
  static double h30 = SizeUtil.setHeight(30.0);
  static double h32 = SizeUtil.setHeight(32.0);
  static double h36 = SizeUtil.setHeight(36.0);
  static double h38 = SizeUtil.setHeight(38.0);
  static double h40 = SizeUtil.setHeight(40.0);
  static double h44 = SizeUtil.setHeight(44.0);
  static double h46 = SizeUtil.setHeight(46.0);
  static double h48 = SizeUtil.setHeight(48.0);
  static double h50 = SizeUtil.setHeight(50.0);
  static double h54 = SizeUtil.setHeight(54.0);
  static double h60 = SizeUtil.setHeight(60.0);
  static double h70 = SizeUtil.setHeight(60.0);
  static double h80 = SizeUtil.setHeight(80.0);
  static double h90 = SizeUtil.setHeight(90.0);
  static double h100 = SizeUtil.setHeight(100.0);
  static double h375 = SizeUtil.setHeight(375.0);

}

class IconSizeManager {
  static double s2 = 2;
  static double s4 = 4;
  static double s6 = 6;
  static double s8 = 8;
  static double s10 = 10;
  static double s12 = 12;
  static double s14 = 14;
}

class OpacityManager {
  static double Op_0_3 = 0.3;
  static double Op_0_5 = 0.5;
  static double Op_0_0_5 = 0.05;
}

class ConstantSize {
  static const double s5 = 5;
  static const double s2 = 5;
}



''');

  File('lib/core/resourses/fonts_manager.dart').writeAsStringSync('''
import 'package:flutter/material.dart';

import '../util/size_util.dart';

class FontWeightManager {
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
}

class FontSizeManager {
  static double s2 = SizeUtil.setFontSize(2.0);
  static double s4 = SizeUtil.setFontSize(4.0);
  static double s6 = SizeUtil.setFontSize(6.0);
  static double s8 = SizeUtil.setFontSize(8.0);
  static double s10 = SizeUtil.setFontSize(10.0);
  static double s11 = SizeUtil.setFontSize(11.0);
  static double s12 = SizeUtil.setFontSize(12.0);
  static double s14 = SizeUtil.setFontSize(14.0);
  static double s15 = SizeUtil.setFontSize(15.0);
  static double s16 = SizeUtil.setFontSize(16.0);
  static double s18 = SizeUtil.setFontSize(18.0);
  static double s20 = SizeUtil.setFontSize(20.0);
  static double s22 = SizeUtil.setFontSize(22.0);
  static double s24 = SizeUtil.setFontSize(24.0);
  static double s26 = SizeUtil.setFontSize(26.0);
  static double s28 = SizeUtil.setFontSize(28.0);
  static double s30 = SizeUtil.setFontSize(30.0);
  static double s35 = SizeUtil.setFontSize(35.0);
  static double s40 = SizeUtil.setFontSize(40.0);
  static double s80 = SizeUtil.setFontSize(80.0);
  static double s100 = SizeUtil.setFontSize(100.0);
}



''');
  File('lib/core/helpers/extensions.dart').writeAsStringSync('''
import 'package:flutter/widgets.dart';

extension Navigation on BuildContext {
  Future<dynamic> pushNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushReplacementNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this)
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushNamedAndRemoveUntil(String routeName,
      {Object? arguments, required RoutePredicate predicate}) {
    return Navigator.of(this)
        .pushNamedAndRemoveUntil(routeName, predicate, arguments: arguments);
  }

  void pop() => Navigator.of(this).pop();
}
''');

  File('lib/name_app.dart').writeAsStringSync('''
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/resourses/colors_manager.dart';
import 'core/routes/app_router.dart';
import 'core/routes/routes.dart';


class NameApp extends StatelessWidget {
  final AppRouter appRouter;
  const NameApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(MediaQuery.of(context).size.height.h, MediaQuery.of(context).size.width.w),
      minTextAdapt: true,
      child: MaterialApp(
        title: 'Name App',
        theme: ThemeData(
          primaryColor: ColorsManager.primaryColor,
          scaffoldBackgroundColor: ColorsManager.white,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.onBoardingScreen,
        onGenerateRoute: appRouter.generateRoute,
      )
    );
  }
}

''');

  File('lib/main.dart').writeAsStringSync('''
import 'package:chat_ai/core/di/dependency_injection.dart';
import 'package:chat_ai/name_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/routes/app_router.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  setupGetIt();
  await ScreenUtil.ensureScreenSize();  
  runApp(NameApp(
    appRouter: AppRouter(),
  ));
}


''');

  File('lib/main.dart').writeAsStringSync('''
import 'package:chat_ai/core/di/dependency_injection.dart';
import 'package:chat_ai/name_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/routes/app_router.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  setupGetIt();
  await ScreenUtil.ensureScreenSize();  
  runApp(NameApp(
    appRouter: AppRouter(),
  ));
}


''');
}