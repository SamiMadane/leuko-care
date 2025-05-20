import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:leuko_care/feature/chats/data/models/conversation_model.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
import 'package:rxdart/rxdart.dart';
import '../models/patient_model.dart';

class PatientRepository {
  final FirebaseFirestore _firestore;

  PatientRepository(this._firestore);

  Stream<List<PatientModel>> getPatientsStream() {
    return _firestore.collection('patients').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => PatientModel.fromJson(doc.data()))
          .toList();
    });
  }

  Future<void> addPatient(PatientModel patient) async {
    try {
      await _firestore
          .collection('patients')
          .doc(patient.id)
          .set(patient.toJson());
    } catch (e) {
      throw Exception("Error saving patient data: ${e.toString()}");
    }
  }

  Future<void> updatePatient(PatientModel patient) async {
    try {
      await _firestore
          .collection('patients')
          .doc(patient.id)
          .update(patient.toJson());
    } catch (e) {
      throw Exception("Error updating patient data: ${e.toString()}");
    }
  }

  Future<void> deletePatient(String patientId) async {
    try {
      await _firestore.collection('patients').doc(patientId).delete();
    } catch (e) {
      throw Exception('Error deleting patient: $e');
    }
  }

  Future<String> uploadImageToCloudinary(String imagePath) async {
    final url = Uri.parse(
      'https://api.cloudinary.com/v1_1/dmhmhyigi/image/upload',
    );
    final uploadRequest = http.MultipartRequest('POST', url);

    uploadRequest.fields['upload_preset'] = 'leuko_care';

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

  Stream<List<PatientModel>> getPatientsByDoctorIdStream(String doctorId) {
    return _firestore
        .collection('patients')
        .where('doctorId', isEqualTo: doctorId)
        .snapshots()
        .map((querySnapshot) {
          return querySnapshot.docs
              .map((doc) => PatientModel.fromJson(doc.data()))
              .toList();
        });
  }

  Future<DoctorModel> getDoctorByDoctorId(String doctorId) async {
    try {
      final docSnapshot =
          await _firestore.collection('doctors').doc(doctorId).get();
      return DoctorModel.fromJson(docSnapshot.data()!);
    } catch (e) {
      throw Exception('Error fetching doctor: $e');
    }
  }

  Stream<PatientModel> getPatientByIdStream(String patientId) {
    return _firestore
        .collection('patients')
        .doc(patientId)
        .snapshots()
        .map((doc) => PatientModel.fromJson(doc.data()!));
  }



  Future<void> updateFcmTokenIfNeeded() async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return;

  final token = await FirebaseMessaging.instance.getToken();
  if (token == null) return;

  final docRef = _firestore.collection('patients').doc(user.uid);

  // تأكد من التحديث فقط إذا تغير التوكن
  final snapshot = await docRef.get();
  final existingToken = snapshot.data()?['fcmToken'];

  if (existingToken != token) {
    await docRef.set({'fcmToken': token}, SetOptions(merge: true)); 
    print('✅ FCM token updated for patient.');
  } else {
    print('ℹ️ FCM token already up to date.');
  }
}

Stream<Map<String, ConversationModel>> getConversationsForPatientStream(String patientId) {

  final streamA = FirebaseFirestore.instance
      .collection('conversations')
      .where('participantAId', isEqualTo: patientId)
      .snapshots();

  final streamB = FirebaseFirestore.instance
      .collection('conversations')
      .where('participantBId', isEqualTo: patientId)
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

          final doctorId = conv.participantAId == patientId
              ? conv.participantBId
              : conv.participantAId;

          if (doctorId.isNotEmpty) {
            map[doctorId] = conv;
          }
        } catch (e) {
          print('Error parsing conversation: $e');
          continue;
        }
      }
      return map;
    },
  );
}

}
