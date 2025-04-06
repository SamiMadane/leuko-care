import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
import 'package:leuko_care/feature/doctors/data/repository/doctor_repo.dart';
import 'package:leuko_care/feature/doctors/logic/cubit/doctor_state.dart';

class DoctorCubit extends Cubit<DoctorState> {
  final DoctorRepository _repository;
  StreamSubscription? _doctorsSubscription;

  DoctorCubit(this._repository) : super(const DoctorState.doctorStateInitial());
  

  // ✅ متابعة التحديثات مباشرة من Firestore
  void getDoctorsStream() {
    emit(GetDoctorStateLoading());
    _doctorsSubscription?.cancel(); // إلغاء أي استماع قديم قبل بدء الجديد
    _doctorsSubscription = _repository.getDoctorsStream().listen(
      (doctors) {
        emit(
          GetDoctorStateSuccess(doctors),
        ); // 🔹 تحديث الحالة فورًا عند أي تغيير
      },
      onError: (error) {
        emit(GetDoctorStateError(error.toString()));
      },
    );
  }

  // إضافة دالة لحساب عدد المرضى للطبيب
  Future<int> getPatientsCountForDoctor(String doctorId) async {
    try {
      final count = await _repository.getPatientsCountForDoctor(doctorId);
      return count; // إعادة العدد مباشرة
    } catch (e) {
      throw Exception('Error fetching patient count: $e');
    }
  }

    // دالة للحصول على URL الصورة
  Future<String> _getImageUrl(DoctorModel doctor) async {
    if (doctor.profileImage.isEmpty) {
      return 'https://static.vecteezy.com/system/resources/previews/041/408/858/non_2x/ai-generated-a-smiling-doctor-with-glasses-and-a-white-lab-coat-isolated-on-transparent-background-free-png.png';
    } else if (!doctor.profileImage.contains('http')) {
      return await _repository.uploadImageToCloudinary(doctor.profileImage);
    }
    return doctor.profileImage;
  }
  
  // إضافة طبيب
  Future<void> addDoctor(DoctorModel doctor, String password) async {
    emit(AddDoctorStateLoading());
    try {
      String imageUrl = await _getImageUrl(doctor);
      doctor = doctor.copyWith(profileImage: imageUrl);

      // ✅ إنشاء الحساب في Firebase Authentication
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: doctor.email,
            password: password,
          );

      // ✅ الحصول على UID من Firebase Authentication
      final uid = userCredential.user!.uid;

      // ✅ تعديل بيانات الطبيب لإضافة UID و userType
      doctor = doctor.copyWith(id: uid);
      await _repository.addDoctor(doctor);
      emit(AddDoctorStateSuccess());
    } catch (e) {
      emit(AddDoctorStateError(e.toString()));
    }
  }

  // تحديث طبيب
  Future<void> updateDoctor(DoctorModel doctor) async {
    emit(UpdateDoctorStateLoading());
    try {
       String imageUrl = await _getImageUrl(doctor);
       doctor = doctor.copyWith(profileImage: imageUrl);

      await _repository.updateDoctor(
        doctor,
      ); // التأكد من إضافة دالة التحديث في الـ Repository
      emit(UpdateDoctorStateSuccess());
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
}
