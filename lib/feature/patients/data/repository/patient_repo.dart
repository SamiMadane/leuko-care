import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import '../models/patient_model.dart';
import 'package:intl/intl.dart';

class PatientRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  PatientRepository(this._firestore); // 🔹 تمرير Firestore عند الإنشاء

  // جلب المرضى
  Stream<List<PatientModel>> getPatientsStream() {
    return _firestore.collection('patients').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => PatientModel.fromJson(doc.data()))
          .toList();
    });
  }

  // إضافة مريض
  Future<void> addPatient(PatientModel patient) async {
    try {
      String registrationDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
      patient = patient.copyWith(
        userType: "patient",
        registrationDate: registrationDate,
        isExamined: false,
      );

      // ✅ تخزين بيانات المريض في Firestore
      await _firestore
          .collection('patients')
          .doc(patient.id)
          .set(patient.toJson());
          getPatientsStream();

    } catch (e) {
      throw Exception("Error saving patient data: ${e.toString()}");
    }
  }

  // تحديث مريض
  Future<void> updatePatient(PatientModel patient) async {
    try {
      patient = patient.copyWith(userType: "patient");
      // ✅ تحديث بيانات المريض في Firestore
      await _firestore
          .collection('patients')
          .doc(patient.id)
          .update(patient.toJson());
          getPatientsStream();
    } catch (e) {
      throw Exception("Error updating patient data: ${e.toString()}");
    }
  }

  // حذف مريض
  Future<void> deletePatient(String patientId) async {
    try {
      // حذف بيانات المريض من Firestore
      await _firestore.collection('patients').doc(patientId).delete();
      getPatientsStream();
    
    } catch (e) {
      throw Exception('Error deleting patient: $e');
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

  
  Future<List<PatientModel>> getPatientsByDoctorId(String doctorId) async {
    try {
      final querySnapshot = await _firestore
          .collection('patients')
          .where('doctorId', isEqualTo: doctorId) // تصفية المرضى حسب doctorId
          .get();

      return querySnapshot.docs
          .map((doc) => PatientModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception("Failed to load patients");
    }
  }
}
