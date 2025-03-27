import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();

      // 🔹 حذف بيانات `SharedPreferences` مثل `email_sent`
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('email_sent');

      print("User logged out successfully.");
    } catch (e) {
      print("Error signing out: $e");
    }
  }
}
