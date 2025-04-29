import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:leuko_care/core/helpers/shared_pref_helper.dart';
import 'package:leuko_care/core/networking/firebase_error_handler.dart';
import 'package:leuko_care/core/networking/firestore_service.dart';
import 'package:leuko_care/core/networking/operation_result.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // تعديل الجزء الذي يحقق من نوع المستخدم
  Future<OperationResult<User?>> login(
    String email,
    String password,
    String userType,
  ) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;

      if (user != null) {
        bool isVerified = user.emailVerified;

        if (isVerified) {
          // جلب الوثيقة من الكولكشن الصحيح
          DocumentSnapshot userDoc = await _firestoreService.getUserDocument(
            userType: userType,
            userId: user.uid,
          );

          if (!userDoc.exists) {
            // البحث في كولكشنات أخرى
            final allTypes = ['admin', 'doctor', 'patient'];
            for (final type in allTypes) {
              if (type == userType) continue;

              final doc = await _firestoreService.getUserDocument(
                userType: type,
                userId: user.uid,
              );
              if (doc.exists) {
                final correctType = doc['userType'] ?? type;
                await FirebaseAuth.instance.signOut();
                return OperationResult.failure(
                  "You are trying to login in the wrong page. Go to the $correctType page.",
                );
              }
            }

            await FirebaseAuth.instance.signOut();
            return OperationResult.failure(
              "This user is not registered on our servers.",
            );
          }

          final storedUserType = userDoc['userType'] ?? '';
          if (storedUserType != userType) {
            await FirebaseAuth.instance.signOut();
            return OperationResult.failure(
              "You are trying to login in the wrong page. Go to the $storedUserType page.",
            );
          }

          await SharedPrefHelper.setData('userType', storedUserType);
          await SharedPrefHelper.setData('uid', user.uid);
          return OperationResult.success(user);
        } else {
          return _handleEmailVerification(user);
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

  Future<OperationResult<User?>> signInWithGoogle(String userType) async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return OperationResult.failure("User canceled the login");
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );
      final User? user = userCredential.user;

      if (user != null) {
        bool isVerified = user.emailVerified;

        if (isVerified) {
          DocumentSnapshot userDoc = await _firestoreService.getUserDocument(
            userId: user.uid,
            userType: userType,
          );

          if (!userDoc.exists) {
            final allTypes = ['admin', 'doctor', 'patient'];
            for (final type in allTypes) {
              if (type == userType) continue;

              final doc = await _firestoreService.getUserDocument(
                userId: user.uid,
                userType: type,
              );
              if (doc.exists) {
                final correctType = doc['userType'] ?? type;
                await FirebaseAuth.instance.signOut();
                return OperationResult.failure(
                  "You are trying to login in the wrong page. Go to the $correctType page.",
                );
              }
            }

            await FirebaseAuth.instance.signOut();
            return OperationResult.failure(
              "This user is not registered on our servers.",
            );
          }

          String storedUserType = userDoc["userType"] ?? "";
          if (storedUserType != userType) {
            await _auth.signOut();
            return OperationResult.failure(
              "You are trying to login in the wrong page. Go to the $storedUserType page.",
            );
          }

          await SharedPrefHelper.setData('userType', storedUserType);
          await SharedPrefHelper.setData('uid', user.uid);
          return OperationResult.success(user);
        } else {
          return _handleEmailVerification(user);
        }
      } else {
        return OperationResult.failure("Failed to sign in with Google.");
      }
    } catch (e) {
      return OperationResult.failure(
        "An error occurred during Google sign-in: ${e.toString()}",
      );
    }
  }

  Future<OperationResult<User?>> _handleEmailVerification(User user) async {
    final prefs = await SharedPreferences.getInstance();
    bool emailSent = prefs.getBool('email_sent') ?? false;

    if (!emailSent) {
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
