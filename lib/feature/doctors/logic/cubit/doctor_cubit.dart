import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
import 'package:leuko_care/feature/doctors/data/repository/doctor_repo.dart';
import 'package:leuko_care/feature/doctors/logic/cubit/doctor_state.dart';

class DoctorCubit extends Cubit<DoctorState> {
  final DoctorRepository _repository;
  DoctorCubit(this._repository) : super(const DoctorState.doctorStateInitial());

  StreamSubscription? _doctorsSubscription;
  bool isAscending = false;
  int selectedIndex = 0;
  bool shouldInjectPatient = false;

  void getDoctorsStream() async {
    emit(GetDoctorStateLoading());
    await _doctorsSubscription?.cancel();
    _doctorsSubscription = _repository.getDoctorsStream().listen(
      (doctors) async {
        final sortedDoctors = await _repository
            .getDoctorsOrderedByPatientsCount(doctors, isAscending);
        doctors = sortedDoctors;

        emit(GetDoctorStateSuccess(doctors));
      },
      onError: (error) {
        emit(GetDoctorStateError(error.toString()));
      },
    );
  }

  void toggleSortOrder() {
    isAscending = !isAscending;
    getDoctorsStream();
  }

  Future<String> _getImageUrl(DoctorModel doctor) async {
    if (doctor.profileImage.isEmpty) {
      return 'https://res.cloudinary.com/dmhmhyigi/image/upload/doctor_profile_wnyo6c.png';
    } else if (!doctor.profileImage.contains('http')) {
      return await _repository.uploadImageToCloudinary(doctor.profileImage);
    }
    return doctor.profileImage;
  }

  Future<void> addDoctor(DoctorModel doctor, String password) async {
    emit(AddDoctorStateLoading());
    try {
      String imageUrl = await _getImageUrl(doctor);
      doctor = doctor.copyWith(profileImage: imageUrl);

      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: doctor.email,
            password: password,
          );

      // Get UID from Firebase Authentication
      final uid = userCredential.user!.uid;
      doctor = doctor.copyWith(id: uid);

      await _repository.addDoctor(doctor);
      emit(AddDoctorStateSuccess());
    } catch (e) {
      emit(AddDoctorStateError(e.toString()));
    }
  }

  Future<void> updateDoctor(DoctorModel doctor) async {
    emit(UpdateDoctorStateLoading());
    try {
      String imageUrl = await _getImageUrl(doctor);
      doctor = doctor.copyWith(profileImage: imageUrl);

      await _repository.updateDoctor(doctor);
      emit(UpdateDoctorStateSuccess(doctor));
    } catch (e) {
      emit(UpdateDoctorStateError(e.toString()));
    }
  }

  Future<void> deleteDoctor(String doctorId) async {
    emit(DeleteDoctorStateLoading());

    try {
      await _repository.deleteDoctor(doctorId);
      emit(DeleteDoctorStateSuccess());
    } catch (e) {
      emit(DeleteDoctorStateError('Error deleting doctor: $e'));
    }
  }

  Stream<int> getPatientsCountStream(String doctorId) {
    return _repository.getPatientsCountForDoctor(doctorId);
  }

  // Doctor User

  void changeSelectedIndex(int index) {
    selectedIndex = index;
    emit(DoctorBottomNavChanged(index));
  }

  void getDoctorAndPatients(String doctorId) {
    emit(const GetDoctorAndPatientsStateLoading());

    try {
      // 1. جلب الدكتور الحالي باستخدام Stream
      final doctorStream = _repository.getDoctorByDoctorIdStream(doctorId);

      // 2. جلب المرضى المرتبطين به باستخدام Stream
      final patientsStream = _repository.getPatientsByDoctorIdStream(doctorId);

      // استخدام StreamSubscription للاستماع للتغييرات المستمرة
      doctorStream.listen(
        (doctor) {
          patientsStream.listen(
            (patients) {
              emit(
                GetDoctorAndPatientsStateSuccess(
                  doctor: doctor,
                  patients: patients,
                ),
              );
            },
            onError: (error) {
              emit(GetDoctorAndPatientsStateError(error.toString()));
            },
          );
        },
        onError: (error) {
          emit(GetDoctorAndPatientsStateError(error.toString()));
        },
      );
    } catch (e) {
      emit(GetDoctorAndPatientsStateError(e.toString()));
    }
  }

}
