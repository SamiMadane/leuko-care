import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';
import 'package:leuko_care/feature/patients/data/repository/patient_repo.dart';
import 'package:leuko_care/feature/patients/logic/cubit/patient_state.dart';

class PatientCubit extends Cubit<PatientState> {
  final PatientRepository _repository;
  StreamSubscription? _patientsSubscription;

  PatientCubit(this._repository) : super(const PatientState.patientStateInitial());

  // ✅ متابعة التحديثات مباشرة من Firestore
  void getPatientsStream() {
    emit(GetPatientStateLoading());
    _patientsSubscription?.cancel(); // إلغاء أي استماع قديم قبل بدء الجديد
    _patientsSubscription = _repository.getPatientsStream().listen(
      (patients) {
        emit(
          GetPatientStateSuccess(patients),
        ); // 🔹 تحديث الحالة فورًا عند أي تغيير
      },
      onError: (error) {
        emit(GetPatientStateError(error.toString()));
      },
    );
  }

  // دالة للحصول على URL الصورة
  Future<String> _getImageUrl(PatientModel patient) async {
    if (patient.profileImage.isEmpty) {
      return 'https://static.vecteezy.com/system/resources/previews/041/408/858/non_2x/ai-generated-a-smiling-doctor-with-glasses-and-a-white-lab-coat-isolated-on-transparent-background-free-png.png';
    } else if (!patient.profileImage.contains('http')) {
      return await _repository.uploadImageToCloudinary(patient.profileImage);
    }
    return patient.profileImage;
  }

  // إضافة مريض
  Future<void> addPatient(PatientModel patient, String password) async {
    emit(AddPatientStateLoading());
    try {
      String imageUrl = await _getImageUrl(patient);
      patient = patient.copyWith(profileImage: imageUrl);

      // ✅ إنشاء الحساب في Firebase Authentication
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: patient.email,
            password: password,
          );

      // ✅ الحصول على UID من Firebase Authentication
      final uid = userCredential.user!.uid;

      // ✅ تعديل بيانات المريض لإضافة UID و userType
      patient = patient.copyWith(id: uid);
      await _repository.addPatient(patient);
      emit(AddPatientStateSuccess());
    } catch (e) {
      emit(AddPatientStateError(e.toString()));
    }
  }

  // تحديث مريض
  Future<void> updatePatient(PatientModel patient) async {
    emit(UpdatePatientStateLoading());
    try {
      String imageUrl = await _getImageUrl(patient);
      patient = patient.copyWith(profileImage: imageUrl);

      await _repository.updatePatient(patient); // التأكد من إضافة دالة التحديث في الـ Repository
      emit(UpdatePatientStateSuccess());
    } catch (e) {
      emit(UpdatePatientStateError(e.toString()));
    }
  }

  // حذف مريض
  Future<void> deletePatient(String patientId) async {
    emit(DeletePatientStateLoading());

    try {
      await _repository.deletePatient(patientId);
      emit(DeletePatientStateSuccess());
    } catch (e) {
      emit(DeletePatientStateError('Error deleting patient: $e'));
    }
  }

  
    Future<void> getPatientsByDoctorId(String doctorId) async {
    try {
      emit(GetPatientsByDoctorIdStateLoading());

      // تصفية المرضى بناءً على doctorId
      final patients = await _repository.getPatientsByDoctorId(doctorId);

      emit(GetPatientsByDoctorIdStateSuccess(patients));
    } catch (e) {
      emit(GetPatientsByDoctorIdStateError("Failed to load patients"));
    }
  }

  int calculateAge(String birthDateString) {
  final birthDate = DateTime.parse(birthDateString);
  final today = DateTime.now();
  int age = today.year - birthDate.year;
  if (today.month < birthDate.month ||
      (today.month == birthDate.month && today.day < birthDate.day)) {
    age--;
  } // إذا كان اليوم أقل من تاريخ الميلاد في نفس السنة، نخصم سنة واحدة
  return age;
}

}
