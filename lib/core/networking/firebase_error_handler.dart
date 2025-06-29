import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseErrorHandler {
  static String handle(Object error) {
    if (error is FirebaseAuthException) {
      return _handleAuthError(error);
    } else if (error is FirebaseException &&
        error.plugin == 'cloud_firestore') {
      return _handleFirestoreError(error);
    } else {
      return 'error_unexpected'.tr(); // رسالة عامة عند خطأ غير معروف
    }
  }

  static String _handleAuthError(FirebaseAuthException error) {
    switch (error.code) {
      case 'user-not-found':
        return "error_user_not_found".tr();
      case 'wrong-password':
        return "error_wrong_password".tr();
      case 'invalid-credential':
        return "error_invalid_credential".tr();
      case 'email-already-in-use':
        return "error_email_already_in_use".tr();
      case 'operation-not-allowed':
        return "error_operation_not_allowed".tr();
      case 'weak-password':
        return "error_weak_password".tr();
      case 'too-many-requests':
        return "error_too_many_requests".tr();
      case 'network-request-failed':
        return "error_network_request_failed".tr();
      default:
        return "error_generic_with_code".tr(args: [error.code]);
    }
  }

  static String _handleFirestoreError(FirebaseException error) {
    switch (error.code) {
      case 'unavailable':
        return 'error_firestore_unavailable'.tr();
      case 'permission-denied':
        return 'error_firestore_permission_denied'.tr();
      case 'not-found':
        return 'error_firestore_not_found'.tr();
      default:
        return 'error_firestore_generic'.tr(args: [error.code]);
    }
  }
}
