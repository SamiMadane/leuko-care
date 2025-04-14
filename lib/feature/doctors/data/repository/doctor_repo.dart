import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import '../models/doctor_model.dart';

class DoctorRepository {
  final FirebaseFirestore _firestore;

  DoctorRepository(this._firestore);

  // Get all doctors from firestore
  // snapshots its read real time all changes
  Stream<List<DoctorModel>> getDoctorsStream() {
    return _firestore.collection('doctors').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => DoctorModel.fromJson(doc.data()))
          .toList();
    });
  }

  // Get count of patients for each doctor
  Stream<int> getPatientsCountForDoctor(String doctorId) {
    return _firestore
        .collection('patients')
        .where('doctorId', isEqualTo: doctorId)
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  Future<void> addDoctor(DoctorModel doctor) async {
    try {
      // After click on add doctor we change userType for doctor.
      doctor = doctor.copyWith(userType: "doctor");
      await _firestore
          .collection('doctors')
          .doc(doctor.id)
          .set(doctor.toJson());
    } catch (e) {
      throw Exception("Error saving doctor data: ${e.toString()}");
    }
  }

  Future<void> updateDoctor(DoctorModel doctor) async {
    try {
      // After click on update doctor we change userType for doctor.
      doctor = doctor.copyWith(userType: "doctor");
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
    final doctorRef = _firestore.collection('doctors').doc(doctorId);

    // حذف المرضى المرتبطين بهذا الطبيب
    final patientQuery = await _firestore
        .collection('patients')
        .where('doctorId', isEqualTo: doctorId)
        .get();

    for (final doc in patientQuery.docs) {
      await doc.reference.delete();
    }
    await doctorRef.delete();
  } catch (e) {
    throw Exception('Error deleting doctor and patients: $e');
  }
}


  // upload image to cloudinary to storage it.
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
