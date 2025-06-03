import 'package:easy_localization/easy_localization.dart';

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
  StreamSubscription<PatientModel>? _onePatientSubscription;
  StreamSubscription? _conversationSubscription;
  String? patientId;
  String? doctorId;

  int selectedIndex = 0;
  String? initialChatMessage;
  bool shouldInjectInitialMessage = false;

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
      return patient.gender.toLowerCase() == 'male'.tr()
          ? 'https://res.cloudinary.com/dmhmhyigi/image/upload/patient_profile_osluzn.png'
          : 'https://res.cloudinary.com/dmhmhyigi/image/upload/patient_profile_image_nut3m4';
    } else if (!patient.profileImage.contains('http'.tr())) {
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
      emit(DeletePatientStateError('Error deleting patient: $e'.tr()));
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
            emit(
              GetPatientsByDoctorIdStateError('Failed to load patients'.tr()),
            );
          },
        );
  }

  Stream<PatientModel> getPatientByIdStream(String patientId) {
    return _repository.getPatientByIdStream(patientId);
  }

  Future<void> getPatientAndDoctor(String patientId) async {
    emit(GetPatientAndDoctorStateLoading());

    try {
      // الاشتراك في Stream للمريض
      _onePatientSubscription = _repository
          .getPatientByIdStream(patientId)
          .listen((patient) async {
            // نبدأ بالاشتراك في Stream المحادثات
            _conversationSubscription?.cancel(); // إلغاء أي اشتراك سابق
            _conversationSubscription = _repository
                .getConversationsForPatientStream(patientId)
                .listen((conversationMap) async {
                  try {
                    final doctor = await _repository.getDoctorByDoctorId(
                      patient.doctorId,
                    );

                    final conversation = conversationMap[doctor.id];

                    // _repository.updateFcmTokenIfNeeded();
                    this.patientId = patient.id;
                    this.doctorId = doctor.id;
                    
               

                    emit(
                      GetPatientAndDoctorStateSuccess(
                        doctor,
                        patient,
                        conversation,
                      ),
                    );
                  } catch (e) {
                    emit(GetPatientAndDoctorStateError(e.toString()));
                  }
                });
          });
    } catch (e) {
      emit(GetPatientAndDoctorStateError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _patientsSubscription?.cancel();
    _doctorSubscription?.cancel();
    _onePatientSubscription?.cancel();
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

  void changeSelectedIndex(int index) {
    print('🔁 Changing selectedIndex to $index');
    selectedIndex = index;
    emit(PatientBottomNavChanged(selectedIndex));
    print('✅ تم بث الحالة الجديدة - selectedIndex: $selectedIndex');
  }

  void setInitialMessage(String message) {
    initialChatMessage = message;
    shouldInjectInitialMessage = true;

    final currentState = state;
    if (currentState is GetPatientAndDoctorStateSuccess) {
      emit(
        GetPatientAndDoctorStateSuccess(
          currentState.doctor,
          currentState.patient,
          currentState.conversation,
        ),
      );
    }
  }
}
