import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:leuko_care/core/helpers/extensions.dart';
import 'package:leuko_care/core/networking/auth_service.dart';
import 'package:leuko_care/core/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Home Screen'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              _authService.signOut();
              context.pushNamedAndRemoveUntil(
                Routes.userSelectionScreen,
                predicate: (route) => false,
              );
            },
          ),
        ],
      ),
      body: Center(child: Text('Admin Home Screen')),
    );
  }
}
