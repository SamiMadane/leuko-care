import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';
import 'package:leuko_care/feature/patients/data/repository/patient_repo.dart';
import 'package:leuko_care/feature/patients/logic/cubit/patient_state.dart';

class PatientCubit extends Cubit<PatientState> {
  final PatientRepository _repository;
  StreamSubscription<List<PatientModel>>? _patientsSubscription;
  StreamSubscription<List<DoctorModel>>? _doctorSubscription;

  PatientCubit(this._repository)
    : super(const PatientState.patientStateInitial());


  void getPatientsStream() {
    _patientsSubscription?.cancel();
    emit(GetPatientStateLoading());
    _patientsSubscription = _repository.getPatientsStream().listen(
      (patients) {
        emit(GetPatientStateSuccess(patients));
      },
      onError: (error) {
        emit(GetPatientStateError(error.toString()));
      },
    );
  }

  Future<String> _getImageUrl(PatientModel patient) async {
    if (patient.profileImage.isEmpty) {
      return 'https://res.cloudinary.com/dmhmhyigi/image/upload/patient_profile_osluzn.png';
    } else if (!patient.profileImage.contains('http')) {
      return await _repository.uploadImageToCloudinary(patient.profileImage);
    }
    return patient.profileImage;
  }

  Future<void> addPatient(PatientModel patient, String password) async {
    emit(AddPatientStateLoading());
    try {
      String imageUrl = await _getImageUrl(patient);
      patient = patient.copyWith(profileImage: imageUrl);

      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: patient.email,
            password: password,
          );

      final uid = userCredential.user!.uid;

      patient = patient.copyWith(id: uid);
      await _repository.addPatient(patient);
      getPatientsStream();
      emit(AddPatientStateSuccess());
    } catch (e) {
      emit(AddPatientStateError(e.toString()));
    }
  }

  Future<void> updatePatient(PatientModel patient) async {
    emit(UpdatePatientStateLoading());
    try {
      String imageUrl = await _getImageUrl(patient);
      patient = patient.copyWith(profileImage: imageUrl);

      await _repository.updatePatient(patient);
      getPatientsStream();
      emit(UpdatePatientStateSuccess(patient));
    } catch (e) {
      emit(UpdatePatientStateError(e.toString()));
    }
  }

  // حذف مريض
  Future<void> deletePatient(String patientId) async {
    emit(DeletePatientStateLoading());

    try {
      await _repository.deletePatient(patientId);
      getPatientsStream();
      emit(DeletePatientStateSuccess());
    } catch (e) {
      emit(DeletePatientStateError('Error deleting patient: $e'));
    }
  }

  void getPatientsByDoctorId(String doctorId) {
    emit(GetPatientsByDoctorIdStateLoading());

    _patientsSubscription?.cancel(); // لإلغاء أي اشتراك سابق

    _patientsSubscription = _repository
        .getPatientsByDoctorIdStream(doctorId)
        .listen(
          (patients) {
            emit(GetPatientsByDoctorIdStateSuccess(patients));
          },
          onError: (error) {
            emit(GetPatientsByDoctorIdStateError("Failed to load patients"));
          },
        );
  }

  
 


  Stream<PatientModel> getPatientByIdStream(String patientId) {
    return _repository.getPatientByIdStream(patientId);
  }

 Future<void> getPatientAndDoctor(String patientId) async {
    emit(GetPatientAndDoctorStateLoading());
    try {
      // جلب المريض
      final patient = await _repository.getPatientByIdStream(patientId).first;
      
      // جلب الطبيب المرتبط بالمريض
      final doctor = await _repository.getDoctorByDoctorId(patient.doctorId);
      
      emit(GetPatientAndDoctorStateSuccess(doctor, patient));
    } catch (e) {
      emit(GetPatientAndDoctorStateError(e.toString()));
    }
  }
  @override
  Future<void> close() {
    _patientsSubscription?.cancel();
    _doctorSubscription?.cancel();
    return super.close();
  }

  int calculateAge(String birthDateString) {
    final birthDate = DateTime.parse(birthDateString);
    final today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    } // if not coming birthday yet decrease one year
    return age;
  }
}
