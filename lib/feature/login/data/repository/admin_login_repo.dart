import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:leuko_care/core/networking/firebase_error_handler.dart';
import 'package:leuko_care/core/networking/operation_result.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminLoginRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<OperationResult<User?>> adminLogin(
    String email,
    String password,
  ) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (user != null) {
        // التحقق من البريد الإلكتروني
        if (user.emailVerified) {
          return OperationResult.success(user);
        } else {
          final prefs = await SharedPreferences.getInstance();
          bool emailSent = prefs.getBool('email_sent') ?? false;

          if (!emailSent) {
            // إرسال رسالة التحقق فقط إذا لم يتم إرسالها من قبل
            await user.sendEmailVerification();
            await prefs.setBool('email_sent', true);
            return OperationResult.failure(
              "Please verify your email. A verification link has been sent.",
            );
          } else {
            return OperationResult.failure(
              "Please verify your email. A verification link has already been sent.",
            );
          }
        }
      }
      return OperationResult.failure("User not found.");
    } on FirebaseAuthException catch (e) {
      final errorMessage = FirebaseErrorHandler.handle(e);
      return OperationResult.failure(errorMessage);
    } catch (e) {
      return OperationResult.failure(
        "An unexpected error occurred: ${e.toString()}",
      );
    }
  }

  Future<OperationResult<User?>> signInWithGoogle() async {
    try {
      // 1. إتمام عملية تسجيل الدخول باستخدام Google
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        return OperationResult.failure(
          "User canceled the login",
        ); // المستخدم ألغى عملية التسجيل
      }

      // 2. الحصول على بيانات التوثيق من جوجل
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // 3. استخدم التوثيق مع Firebase
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // 4. تسجيل الدخول باستخدام Firebase
      final UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );
      final User? user = userCredential.user;

      if (user != null) {
        // التحقق من تطابق البريد الإلكتروني مع البريد الخاص بالأدمن
        const adminEmail =
            "samimadane23@gmail.com"; // استبدلها بالبريد الإلكتروني للأدمن
        if (user.email != adminEmail) {
          await _auth
              .signOut(); // تسجيل الخروج من الحساب إذا لم يكن بريد المستخدم هو بريد الأدمن
          return OperationResult.failure("Unauthorized user.");
        }
        return OperationResult.success(user);
      } else {
        return OperationResult.failure("Failed to sign in with Google.");
      }
    } catch (e) {
      return OperationResult.failure(
        "An error occurred during Google sign-in: ${e.toString()}",
      );
    }
  }
}
