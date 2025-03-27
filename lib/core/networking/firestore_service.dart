// lib/core/services/firestore_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class FirestoreService {
  Future<void> createUserDocument(
    User user,
    String userType, {
    String? name,
    String? phone,
    int? age,
  }) async {
    try {
      Map<String, dynamic> userData = {
        'email': user.email,
        'userType': userType,
        'emailVerified': user.emailVerified,
      };

      // إضافة بيانات المستخدم بناءً على نوعه
      if (userType == 'doctor') {
        userData['name'] = name ?? '';
        userData['phone'] = phone ?? '';
      } else if (userType == 'patient') {
        userData['name'] = name ?? '';
        userData['age'] = age ?? 0;
      }

      // إضافة المستند في Firestore باستخدام user.uid كمفتاح
      await _firestore.collection("users").doc(user.uid).set(userData);
      print("User document created successfully.");
    } catch (e) {
      print("Error creating user document: $e");
    }
  }

  Future<DocumentSnapshot> getUserDocument(String userId) async {
    return await _firestore.collection("users").doc(userId).get();
  }

  Future<void> updateEmailVerificationStatus(
    String userId,
    bool isVerified,
  ) async {
    try {
      await _firestore.collection("users").doc(userId).update({
        'emailVerified': isVerified,
      });
      print("Email verification status updated.");
    } catch (e) {
      print("Error updating email verification status: $e");
    }
  }
}
