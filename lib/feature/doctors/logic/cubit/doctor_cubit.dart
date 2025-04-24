import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
import 'package:leuko_care/feature/doctors/data/repository/doctor_repo.dart';
import 'package:leuko_care/feature/doctors/logic/cubit/doctor_state.dart';

class DoctorCubit extends Cubit<DoctorState> {
  final DoctorRepository _repository;
  StreamSubscription? _doctorsSubscription;
  bool isAscending = false;

  DoctorCubit(this._repository) : super(const DoctorState.doctorStateInitial());

  void getDoctorsStream() async {
    print('pressed and iam in loading');
    emit(GetDoctorStateLoading());
    await _doctorsSubscription?.cancel();
    _doctorsSubscription = _repository.getDoctorsStream().listen(
      (doctors) async {
        print(
          'isAscending send in getDoctorsStream in DoctorCubit $isAscending',
        );

        final sortedDoctors = await _repository
            .getDoctorsOrderedByPatientsCount(doctors, isAscending);
        doctors = sortedDoctors;
        print('pressed and iam in success');

        emit(GetDoctorStateSuccess(doctors));
      },
      onError: (error) {
        print('pressed and iam in error');

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
      return 'https://res.cloudinary.com/dmhmhyigi/image/upload/doctor_profile_kruo7j.png';
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
}
