import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:leuko_care/core/networking/firebase_error_handler.dart';
import 'package:leuko_care/core/networking/firestore_service.dart';
import 'package:leuko_care/core/networking/operation_result.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // This return type => if everything is right and success will be return user.
  Future<OperationResult<User?>> adminLogin(
    String email,
    String password,
    String userType,
  ) async {
    try {
      // store data in userCredential
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (user != null) {
        bool isVerified = await checkAndUpdateEmailVerification(user);

        // التحقق من البريد الإلكتروني
        if (isVerified) {
          // Get user data from Firestore
          DocumentSnapshot userDoc = await _firestoreService.getUserDocument(
            user.uid,
          );
          if (!userDoc.exists) {
            await FirebaseAuth.instance.signOut(); // تسجيل خروج المستخدم
            return OperationResult.failure("This user is not registered on our servers.");
          }

          // التحقق من نوع المستخدم
          String storedUserType = userDoc["userType"] ?? "";
          if (storedUserType != userType) {
            return OperationResult.failure(
              "Invalid user type for this login page. go to (${storedUserType}) page.",
            );
          }
          return OperationResult.success(user);
        } else {
          return _handelEmailVerification(user);
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


  Future<bool> checkAndUpdateEmailVerification(User user) async {
  DocumentSnapshot userDoc = await _firestoreService.getUserDocument(user.uid);
  bool storedVerificationStatus = userDoc['emailVerified'] ?? false;

  // تحديث الحالة فقط إذا كانت مختلفة
  if (storedVerificationStatus != user.emailVerified) {
    await _firestoreService.updateEmailVerificationStatus(user.uid, user.emailVerified);
  }

  return user.emailVerified;
}

  Future<OperationResult<User?>> signInWithGoogle(String userType) async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
      // show window to select google account
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return OperationResult.failure(
          "User canceled the login",
        ); // user canceled the login and not select any account.
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
        DocumentSnapshot userDoc = await _firestoreService.getUserDocument(
          user.uid,
        );

        if (!userDoc.exists) {
          return OperationResult.failure("This user is not registered on our servers.");
        } else {
          String storedUserType = userDoc["userType"] ?? "";
          if (storedUserType != userType) {
            return OperationResult.failure(
              "Invalid user type for this login page. go to (${storedUserType}) page.",
            );
          }
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

  Future<OperationResult<User?>> _handelEmailVerification(User user) async {
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
