import 'package:flutter/material.dart';
import 'package:leuko_care/core/helpers/shared_pref_helper.dart';
import 'package:leuko_care/core/networking/notification_service.dart';
import 'package:leuko_care/core/routes/routes.dart';

class NavigationHandlerScreen extends StatefulWidget {
  const NavigationHandlerScreen({super.key});

  @override
  State<NavigationHandlerScreen> createState() =>
      _NavigationHandlerScreenState();
}

class _NavigationHandlerScreenState extends State<NavigationHandlerScreen> {
  @override
  void initState() {
    super.initState();    
    _handleNavigation();
  }

  Future<void> _handleNavigation() async {
    final userType = await SharedPrefHelper.getString('userType');

    if (userType == 'admin') {
      Navigator.pushReplacementNamed(context, Routes.adminHomeScreen);
    } else if (userType == 'doctor') {
      Navigator.pushReplacementNamed(context, Routes.doctorScreen);
      WidgetsBinding.instance.addPostFrameCallback((_) {
      NotificationService.processPendingNotificationIfNeeded();
    });
    } else if (userType == 'patient') {

      Navigator.pushReplacementNamed(context, Routes.patientScreen);
      WidgetsBinding.instance.addPostFrameCallback((_) {
      NotificationService.processPendingNotificationIfNeeded();
    });
    } else {
      Navigator.pushReplacementNamed(context, Routes.onboardingScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SizedBox(), // فارغة لأنها فقط شاشة توجيه خلف splash native
    );
  }
}
