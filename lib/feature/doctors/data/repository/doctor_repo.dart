import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:leuko_care/core/usecases/get_doctors_ordered_by_patients_count_usecase.dart';
import 'package:leuko_care/feature/chats/data/models/conversation_model.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';
import 'package:rxdart/rxdart.dart';
import '../models/doctor_model.dart';

class DoctorRepository {
  final FirebaseFirestore firestore;
  final GetDoctorsOrderedByPatientsCountUseCase
  getDoctorsOrderedByPatientsCountUseCase;

  DoctorRepository({
    required this.firestore,
    required this.getDoctorsOrderedByPatientsCountUseCase,
  });

  // Get all doctors from firestore
  // snapshots its read real time all changes
  Stream<List<DoctorModel>> getDoctorsStream() {
    return firestore.collection('doctors').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => DoctorModel.fromJson(doc.data()))
          .toList();
    });
  }

  Future<List<DoctorModel>> getDoctorsOrderedByPatientsCount(
    List<DoctorModel> doctors,
    bool isAscending,
  ) async {
    return getDoctorsOrderedByPatientsCountUseCase.call(doctors, isAscending);
  }

  // Get count of patients for each doctor
  Stream<int> getPatientsCountForDoctor(String doctorId) {
    return firestore
        .collection('patients')
        .where('doctorId', isEqualTo: doctorId)
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  Future<void> addDoctor(DoctorModel doctor) async {
    try {
      // After click on add doctor we change userType for doctor.
      doctor = doctor.copyWith(userType: "doctor");
      await firestore.collection('doctors').doc(doctor.id).set(doctor.toJson());
    } catch (e) {
      throw Exception("Error saving doctor data: ${e.toString()}");
    }
  }

  Future<void> updateDoctor(DoctorModel doctor) async {
    try {
      // After click on update doctor we change userType for doctor.
      doctor = doctor.copyWith(userType: "doctor");
      await firestore
          .collection('doctors')
          .doc(doctor.id)
          .update(doctor.toJson());
    } catch (e) {
      throw Exception("Error update doctor data: ${e.toString()}");
    }
  }

  Future<void> deleteDoctor(String doctorId) async {
    try {
      final doctorRef = firestore.collection('doctors').doc(doctorId);

      // حذف المرضى المرتبطين بهذا الطبيب
      final patientQuery =
          await firestore
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

  // Doctor User
  Stream<DoctorModel> getDoctorByDoctorIdStream(String doctorId) {
    return FirebaseFirestore.instance
        .collection('doctors')
        .doc(doctorId)
        .snapshots()
        .map((doc) => DoctorModel.fromJson(doc.data()!));
  }

  Stream<List<PatientModel>> getPatientsByDoctorIdStream(String doctorId) {
    return FirebaseFirestore.instance
        .collection('patients')
        .where('doctorId', isEqualTo: doctorId)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs
                  .map((doc) => PatientModel.fromJson(doc.data()))
                  .toList(),
        );
  }

 Stream<Map<String, ConversationModel>> getConversationsForDoctorStream(String doctorId) {
  final streamA = FirebaseFirestore.instance
      .collection('conversations')
      .where('participantAId', isEqualTo: doctorId)
      .snapshots();

  final streamB = FirebaseFirestore.instance
      .collection('conversations')
      .where('participantBId', isEqualTo: doctorId)
      .snapshots();

  return Rx.combineLatest2<QuerySnapshot, QuerySnapshot, Map<String, ConversationModel>>(
    streamA,
    streamB,
    (snapshotA, snapshotB) {
      final allDocs = [...snapshotA.docs, ...snapshotB.docs];

      final Map<String, ConversationModel> map = {};

      for (final doc in allDocs) {
        try {
          final data = doc.data() as Map<String, dynamic>;
          final conv = ConversationModel.fromJson(data);

          final patientId = conv.participantAId == doctorId
              ? conv.participantBId
              : conv.participantAId;

          if (patientId.isNotEmpty) {
            map[patientId] = conv;
          }
        } catch (e, stackTrace) {
          print('Error parsing conversation: $e');
          print(stackTrace);
          continue;
        }
      }

      print('Total conversations updated for doctor: ${map.length}');
      return map;
    },
  );
}
}
