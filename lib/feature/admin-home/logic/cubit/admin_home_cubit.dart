import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/feature/admin-home/logic/cubit/admin_home_state.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
import 'package:leuko_care/feature/doctors/data/repository/doctor_repo.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';
import 'package:leuko_care/feature/patients/data/repository/patient_repo.dart';

class AdminHomeCubit extends Cubit<AdminHomeState> {
  final DoctorRepository doctorRepository;
  final PatientRepository patientRepository;
  StreamSubscription? _doctorsSubscription;

  // المتغيرات الجديدة
  List<DoctorModel> doctors = [];
  DoctorModel? selectedDoctor;
  List<PatientModel> filteredPatients = [];

  AdminHomeCubit({
    required this.doctorRepository,
    required this.patientRepository,
  }) : super(const AdminHomeState.homeStateInitial());


  void getDoctors() async {
  emit(GetDoctorsStateLoading());

  _doctorsSubscription?.cancel();
  _doctorsSubscription = doctorRepository.getDoctorsStream().listen(
    (doctorList) async {

      List<MapEntry<DoctorModel, int>> doctorWithPatientCounts = [];

      for (var doctor in doctorList) {
        var patients = await patientRepository.getPatientsByDoctorId(doctor.id!);
        doctorWithPatientCounts.add(MapEntry(doctor, patients.length));
      }
      // arranged the doctors by the number of patients in descending order
      doctorWithPatientCounts.sort((a, b) => b.value.compareTo(a.value));
      doctors = doctorWithPatientCounts.map((entry) => entry.key).toList();

      selectedDoctor = doctors.isNotEmpty ? doctors.first : null;
      _filterPatientsByDoctor();
      emit(GetDoctorsStateSuccess(doctors));
    },
    onError: (error) {
      emit(GetDoctorsStateError(error.toString()));
    },
  );
}


  // دالة تصفية المرضى بناءً على الطبيب المختار
void _filterPatientsByDoctor() {
  emit(GetPatientsStateLoading());  // عرض حالة تحميل المرضى
  if (selectedDoctor != null) {
    patientRepository
        .getPatientsByDoctorId(selectedDoctor!.id!)
        .then((patients) {
          filteredPatients = patients;
          emit(GetPatientsStateSuccess(filteredPatients));  // عرض المرضى عند النجاح
        })
        .catchError((error) {
          emit(GetPatientsStateError(error.toString()));  // عرض الخطأ عند حدوثه
        });
  }
}

 void selectDoctor(DoctorModel doctor) {
  selectedDoctor = doctor;
  _filterPatientsByDoctor(); // تصفية المرضى بناءً على الطبيب المختار
  emit(GetDoctorsStateSuccess(doctors)); // تحديث حالة الأطباء
  

}

  @override
  Future<void> close() {
    _doctorsSubscription?.cancel(); // إلغاء الاشتراك
    return super.close();
  }
}
