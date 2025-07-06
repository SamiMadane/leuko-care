import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:leuko_care/core/helpers/network_helper.dart';
import 'package:leuko_care/core/helpers/shared_pref_helper.dart';
import 'package:leuko_care/core/networking/firebase_error_handler.dart';
import 'package:leuko_care/core/networking/firestore_service.dart';
import 'package:leuko_care/core/networking/notification_service.dart';
import 'package:leuko_care/core/networking/operation_result.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> saveFcmToken(String uid, String userType, String token) async {
    print('Saving FCM token for user: $uid token: $token');
    final docRef = FirebaseFirestore.instance.collection('fcmTokens').doc(uid);

    try {
      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        // لو المستند موجود، نضيف التوكن للقائمة إذا مش موجودة مسبقاً
        final tokens = List<String>.from(docSnapshot.data()?['tokens'] ?? []);

        if (!tokens.contains(token)) {
          tokens.add(token);
        }

        await docRef.update({
          'tokens': tokens,
          'userType': userType,
          'platform': Platform.operatingSystem,
          'updatedAt': FieldValue.serverTimestamp(),
        });
      } else {
        // إنشاء مستند جديد مع التوكن في قائمة
        await docRef.set({
          'tokens': [token],
          'userType': userType,
          'platform': Platform.operatingSystem,
          'updatedAt': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      print("Failed to save FCM token: $e");
    }
  }

  Future<void> updateUserLanguage(String uid, String userType) async {
    try {
      print('=========== iam in repo of updateUserLanguage');
      final languageCode = await SharedPrefHelper.getLocale();
      print('in repo languageCode = $languageCode');
      print('in repo userType = $userType');
      print('in repo uid = $uid');

      final docRef = await FirebaseFirestore.instance
          .collection(userType == 'doctor' ? 'doctors' : 'patients')
          .doc(uid);
      final docSnapshot = await docRef.get();
      print('Document exists? ${docSnapshot.exists}');
      docRef.update({'language': languageCode});
    } catch (e) {
      print('Error updating language for user: $e');
    }
  }

  Future<OperationResult<void>> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return OperationResult.success(null);
    } on FirebaseAuthException catch (e) {
      final errorMessage = FirebaseErrorHandler.handle(e);
      return OperationResult.failure(errorMessage);
    } catch (e) {
      return OperationResult.failure("An unexpected error occurred.".tr());
    }
  }

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
                  tr(
                    'login_in_the_wrong_page',
                    namedArgs: {'correctPage': tr(correctType)},
                  ),
                );
              }
            }

            await FirebaseAuth.instance.signOut();
            return OperationResult.failure(
              'This user is not registered on our servers.'.tr(),
            );
          }

          final storedUserType = userDoc['userType'] ?? '';
          if (storedUserType != userType) {
            await FirebaseAuth.instance.signOut();
            return OperationResult.failure(
              tr(
                'login_in_the_wrong_page',
                namedArgs: {'correctPage': tr(storedUserType)},
              ),
            );
          }

          await SharedPrefHelper.setData('userType', storedUserType);
          await SharedPrefHelper.setData('uid', user.uid);
          // حفظ التوكن فوراً بعد تسجيل الدخول
          final token = await FirebaseMessaging.instance.getToken();
          if (token != null) {
            print('Saving FCM token after login: $token');
            await saveFcmToken(user.uid, storedUserType, token);
          }

          NotificationService.listenToTokenRefresh(
            authRepository: this,
            uid: user.uid,
            userType: storedUserType,
          );
          await updateUserLanguage(user.uid, storedUserType);

          return OperationResult.success(user);
        } else {
          return _handleEmailVerification(user);
        }
      }

      return OperationResult.failure('User not found.'.tr());
    } on FirebaseAuthException catch (e) {
      final errorMessage = FirebaseErrorHandler.handle(e);
      return OperationResult.failure(errorMessage);
    } catch (e) {
      final errorMessage = FirebaseErrorHandler.handle(e);
      return OperationResult.failure(errorMessage);
    }
  }

  Future<OperationResult<User?>> signInWithGoogle(String userType) async {
    try {
      bool hasInternet = await NetworkHelper.hasInternetConnection();
      if (!hasInternet) {
        return OperationResult.failure('error_network_request_failed'.tr());
      }
      await _auth.signOut();
      await _googleSignIn.signOut();

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return OperationResult.failure('User canceled the login'.tr());
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
                  tr(
                    'login_in_the_wrong_page',
                    namedArgs: {'correctPage': tr(correctType)},
                  ),
                );
              }
            }

            await FirebaseAuth.instance.signOut();
            return OperationResult.failure(
              'This user is not registered on our servers.'.tr(),
            );
          }

          String storedUserType = userDoc['userType'] ?? "";
          if (storedUserType != userType) {
            await _auth.signOut();
            return OperationResult.failure(
              tr(
                'login_in_the_wrong_page',
                namedArgs: {'correctPage': tr(storedUserType)},
              ),
            );
          }

          await SharedPrefHelper.setData('userType', storedUserType);
          await SharedPrefHelper.setData('uid', user.uid);
          final token = await FirebaseMessaging.instance.getToken();
          if (token != null) {
            print('Saving FCM token after login: $token');
            await saveFcmToken(user.uid, storedUserType, token);
          }
          NotificationService.listenToTokenRefresh(
            authRepository: this,
            uid: user.uid,
            userType: storedUserType,
          );
          await updateUserLanguage(user.uid, storedUserType);

          return OperationResult.success(user);
        } else {
          return _handleEmailVerification(user);
        }
      } else {
        return OperationResult.failure('Failed to sign in with Google.'.tr());
      }
    } catch (e) {
      final errorMessage = FirebaseErrorHandler.handle(e);
      return OperationResult.failure(errorMessage);
    }
  }

  Future<void> signOut() async {
    try {
      // احصل على الـ uid من Shared Preferences أو من FirebaseAuth الحالي
      final uid =
          _auth.currentUser?.uid ?? await SharedPrefHelper.getString('uid');

      // ignore: unnecessary_null_comparison
      if (uid != null && uid.isNotEmpty) {
        await FirebaseFirestore.instance
            .collection('fcmTokens')
            .doc(uid)
            .delete();
      }

      await FirebaseAuth.instance.signOut();
      await SharedPrefHelper.clearAllData();
    } catch (e) {
      throw Exception('Error signing out: $e'.tr());
    }
  }

  Future<OperationResult<User?>> _handleEmailVerification(User user) async {
    final prefs = await SharedPreferences.getInstance();
    bool emailSent = prefs.getBool('email_sent'.tr()) ?? false;

    if (!emailSent) {
      await user.sendEmailVerification();
      await prefs.setBool('email_sent'.tr(), true);
      return OperationResult.failure(
        'Please verify your email. A verification link has been sent.'.tr(),
      );
    } else {
      return OperationResult.failure(
        'Please verify your email. A verification link has already been sent.'
            .tr(),
      );
    }
  }
}
