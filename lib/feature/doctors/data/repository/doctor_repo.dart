import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import '../models/doctor_model.dart';

class DoctorRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  DoctorRepository(this._firestore); // 🔹 تمرير Firestore عند الإنشاء

  // جلب الأطباء
  Stream<List<DoctorModel>> getDoctorsStream() {
    return _firestore.collection('doctors').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => DoctorModel.fromJson(doc.data()))
          .toList();
    });
  }

// جلب عدد المرضى لدى كل طبيب 
  Future<int> getPatientsCountForDoctor(String doctorId) async {
    final snapshot =
        await FirebaseFirestore.instance
            .collection('patients')
            .where('doctorId', isEqualTo: doctorId)
            .get();
    return snapshot.size;
  }

  // إضافة طبيب
  Future<void> addDoctor(DoctorModel doctor) async {
    try {
      doctor = doctor.copyWith(userType: "doctor");
      // ✅ تخزين بيانات الطبيب في Firestore فقط
      await _firestore
          .collection('doctors')
          .doc(doctor.id)
          .set(doctor.toJson());
    } catch (e) {
      throw Exception("Error saving doctor data: ${e.toString()}");
    }
  }

  // تحديث طبيب
  Future<void> updateDoctor(DoctorModel doctor) async {
    try {
      doctor = doctor.copyWith(userType: "doctor");
      // ✅ تحديث بيانات الطبيب في Firestore فقط
      await _firestore
          .collection('doctors')
          .doc(doctor.id)
          .update(doctor.toJson());
    } catch (e) {
      throw Exception("Error update doctor data: ${e.toString()}");
    }
  }

  Future<void> deleteDoctor(String doctorId) async {
    try {
      // حذف بيانات الطبيب من Firestore
      await _firestore.collection('doctors').doc(doctorId).delete();
      getDoctorsStream();
      // حذف بيانات الطبيب من Firebase Auth
      User? user = _auth.currentUser;
      if (user != null && user.uid == doctorId) {
        await user.delete(); // حذف المستخدم من Auth
      }
    } catch (e) {
      throw Exception('Error deleting doctor: $e');
    }
  }

  // دالة لرفع الصورة إلى Cloudinary
  Future<String> uploadImageToCloudinary(String imagePath) async {
    final url = Uri.parse(
      'https://api.cloudinary.com/v1_1/dmhmhyigi/image/upload',
    );
    final uploadRequest = http.MultipartRequest('POST', url);

    // إعدادات المصادقة
    uploadRequest.fields['upload_preset'] = 'leuko_care';

    // قراءة الصورة
    final imageBytes = await File(imagePath).readAsBytes();
    final imageFile = http.MultipartFile.fromBytes(
      'file',
      imageBytes,
      filename: 'image.jpg',
    );
    uploadRequest.files.add(imageFile);

    final response = await uploadRequest.send();
    final responseData = await response.stream.toBytes();
    final result = json.decode(String.fromCharCodes(responseData));

    if (response.statusCode == 200) {
      return result['secure_url']; // رابط الصورة المرفوعة
    } else {
      throw Exception('Error uploading image: ${result['error']}');
    }
  }
}
