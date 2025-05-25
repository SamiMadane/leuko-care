import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/feature/admin-home/data/repository/admin_home_repo.dart';
import 'package:leuko_care/feature/admin-home/logic/cubit/admin_home_state.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';

class AdminHomeCubit extends Cubit<AdminHomeState> {
  final AdminHomeRepository adminHomeRepository;
  StreamSubscription<List<PatientModel>>? _patientsSubscription;
  StreamSubscription? _doctorsSubscription;
    StreamSubscription? _statisticsSubscription;



  List<DoctorModel> doctors = [];
  DoctorModel? selectedDoctor;
  List<PatientModel> filteredPatients = [];

  AdminHomeCubit({required this.adminHomeRepository})
    : super(const AdminHomeState.homeStateInitial());

  void getDoctors({bool isAscending = false}) async {
    emit(GetDoctorsStateLoading());

    _doctorsSubscription?.cancel();
    _doctorsSubscription = adminHomeRepository.getDoctorsStream().listen(
      (doctorList) async {
        final sortedDoctors = await adminHomeRepository
            .getDoctorsOrderedByPatientsCount(doctorList,isAscending);
        doctors = sortedDoctors;
        selectedDoctor = doctors.isNotEmpty ? doctors.first : null;
        await _filterPatientsByDoctor();
        emit(GetDoctorsStateSuccess(doctors));
      },
      onError: (error) {
        emit(GetDoctorsStateError(error.toString()));
      },
    );
  }

  Future<void> _filterPatientsByDoctor() async {
    emit(GetPatientsStateLoading());
    if (selectedDoctor != null) {
      try {
        // استخدام Stream للمرضى الخاصين بالطبيب المحدد
        _patientsSubscription?.cancel();
        _patientsSubscription = adminHomeRepository.getPatientsByDoctorIdStream(
          selectedDoctor!.id!,
        ).listen(
          (patients) {
            filteredPatients = patients;
            emit(GetPatientsStateSuccess(filteredPatients));
          },
          onError: (error) {
            emit(GetPatientsStateError(error.toString()));
          },
        );
      } catch (e) {
        emit(GetPatientsStateError(e.toString()));
      }
    } else {
      filteredPatients = [];
      emit(GetPatientsStateSuccess(filteredPatients));
    }
  }

  void selectDoctor(DoctorModel doctor) {
    selectedDoctor = doctor;
    _filterPatientsByDoctor();
    emit(GetDoctorsStateSuccess(doctors));
  }



   void getAdminStatistics() {
    _statisticsSubscription?.cancel(); 
    _statisticsSubscription =
        adminHomeRepository.getAllStatistics().listen((statistics) {
      emit(GetStatisticsStateSuccess(statistics));
    }, onError: (error) {
      emit(GetStatisticsStateError(error.toString()));
    });
  }

  @override
  Future<void> close() {
    _patientsSubscription?.cancel();
    _doctorsSubscription?.cancel();
    return super.close();
  }
}

