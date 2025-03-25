import 'package:firebase_auth/firebase_auth.dart';

class FirebaseErrorHandler {
  static String handle(FirebaseAuthException error) {
    switch (error.code) {
      case 'user-not-found':
        return "No user found for that email. Please check your email and try again.";
      case 'wrong-password':
        return "Incorrect password. Please ensure your password is correct and try again.";
      case 'invalid-credential':
        return "The credentials you entered are incorrect. Please check your email and password.";
      case 'email-already-in-use':
        return "This email is already in use. Please try another email or use 'Forgot Password' to reset it.";
      case 'operation-not-allowed':
        return "This operation is not allowed. Please contact support.";
      case 'weak-password':
        return "The password you entered is too weak. Please choose a stronger password with at least 6 characters.";
      case 'too-many-requests':
        return "Too many requests. Please try again later.";
      case 'network-request-failed':
        return "Network error. Please check your internet connection and try again.";
      default:
        return "An error occurred. Please try again later. Error code: ${error.code}";
    }
  }
}
