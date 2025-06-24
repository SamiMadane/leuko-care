import 'package:easy_localization/easy_localization.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/feature/chats/data/models/conversation_model.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
import 'package:leuko_care/feature/doctors/data/repository/doctor_repo.dart';
import 'package:leuko_care/feature/doctors/logic/cubit/doctor_state.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';
import 'package:rxdart/rxdart.dart';

class DoctorCubit extends Cubit<DoctorState> {
  final DoctorRepository _repository;
  DoctorCubit(this._repository) : super(const DoctorState.doctorStateInitial());

  StreamSubscription? _doctorsSubscription;
  bool isAscending = false;
  int selectedIndex = 2;
  bool shouldInjectPatient = false;
  StreamSubscription? _doctorAndPatientsSubscription;
  final PageController pageController = PageController(initialPage: 2);

  void goToPage(int index) {
    final currentPage = pageController.page?.round() ?? 0;

    if ((index - currentPage).abs() > 1) {
      // انتقال سريع بدون تمرير الصفحات الوسيطة
      pageController.jumpToPage(index);
    } else {
      // انتقال متحرك سلس للصفحات المجاورة
      pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

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
      emit(DeleteDoctorStateError('Error deleting doctor: $e'.tr()));
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
    _doctorAndPatientsSubscription?.cancel();

    try {
      // 1. جلب ستريم الدكتور
      final doctorStream = _repository.getDoctorByDoctorIdStream(doctorId);

      // 2. جلب ستريم المرضى المرتبطين به
      final patientsStream = _repository.getPatientsByDoctorIdStream(doctorId);

      // 3. جلب ستريم المحادثات الخاصة به
      final conversationsStream = _repository.getConversationsForDoctorStream(
        doctorId,
      );

      // استخدام Rx.combineLatest3 للجمع بين الثلاثة Streams
      Rx.combineLatest3(
        doctorStream,
        patientsStream,
        conversationsStream,
        (
          DoctorModel doctor,
          List<PatientModel> patients,
          Map<String, ConversationModel> conversationsMap,
        ) {
          // يتم تنفيذ هذا عندما تتوفر القيم الثلاثة.
          return GetDoctorAndPatientsStateSuccess(
            doctor: doctor,
            patients: patients,
            conversationsByPatientId: conversationsMap,
          );
        },
        //final state = GetDoctorAndPatientsStateSuccess(...);
        //  emit(state);
      ).listen(
        (state) {
          emit(
            state,
          ); // this will emit the combined state getDoctorAndPatientsStateSuccess
        },
        onError: (error) {
          emit(GetDoctorAndPatientsStateError(error.toString()));
        },
      );
    } catch (e) {
      emit(GetDoctorAndPatientsStateError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _doctorsSubscription?.cancel();
    _doctorAndPatientsSubscription?.cancel();
    pageController.dispose();
    return super.close();
  }
}
