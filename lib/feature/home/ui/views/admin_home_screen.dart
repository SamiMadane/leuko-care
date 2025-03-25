import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:leuko_care/core/helpers/extensions.dart';
import 'package:leuko_care/core/routes/routes.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
    final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Home Screen'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              setState(() async{
                FirebaseAuth.instance.signOut();
                await _googleSignIn.signOut();
                context.pushNamedAndRemoveUntil(Routes.adminLoginScreen, predicate: (route) => false,);
              });
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Admin Home Screen'),
      ),
    );
  }
}

