import 'package:firebase_auth/firebase_auth.dart';
import 'package:leuko_care/core/helpers/shared_pref_helper.dart';
import 'package:leuko_care/core/usecases/get_doctors_ordered_by_patients_count_usecase.dart';
import 'package:leuko_care/feature/admin-home/data/model/admin_statistics_model.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
import 'package:leuko_care/feature/doctors/data/repository/doctor_repo.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';
import 'package:leuko_care/feature/patients/data/repository/patient_repo.dart';

class AdminHomeRepository {
  final DoctorRepository doctorRepository;
  final PatientRepository patientRepository;
  final GetDoctorsOrderedByPatientsCountUseCase
  getDoctorsOrderedByPatientsCountUseCase;

  AdminHomeRepository({
    required this.doctorRepository,
    required this.patientRepository,
    required this.getDoctorsOrderedByPatientsCountUseCase,
  });

  Stream<List<DoctorModel>> getDoctorsStream() {
    return doctorRepository.getDoctorsStream();
  }

  Future<List<DoctorModel>> getDoctorsOrderedByPatientsCount(
    List<DoctorModel> doctors,
    bool isAscending,
  ) async {
    return getDoctorsOrderedByPatientsCountUseCase.call(doctors, isAscending);
  }

  Stream<List<PatientModel>> getPatientsByDoctorIdStream(String doctorId) {
    return patientRepository.getPatientsByDoctorIdStream(doctorId);
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      await SharedPrefHelper.clearAllData();
    } catch (e) {
      throw Exception("Error signing out: $e");
    }
  }

  Future<AdminStatisticsModel> getAllStatistics() async {
    final patients = await patientRepository.getPatientsStream().first;
    final doctors = await doctorRepository.getDoctorsStream().first;

    int examined = 0;
    int unexamined = 0;
    final Map<String, int> healthStatusCounts = {};
    final Map<String, int> patientsPerDoctor = {};
    final Map<String, String> doctorNames = {
      for (var doctor in doctors) doctor.id!: doctor.name,
    };
    // patients per doctor counts.
    for (var doctor in doctors) {
      patientsPerDoctor[doctor.name] = 0; // Initialize with 0 for each doctor
    }

    // examined and unexamined counts
    for (var patient in patients) {
      if (patient.isExamined) {
        examined++;
      } else {
        unexamined++;
      }

      // health status counts.
      healthStatusCounts[patient.healthStatus] =
          (healthStatusCounts[patient.healthStatus] ?? 0) + 1;

      final doctorName = doctorNames[patient.doctorId] ?? "Unknown Doctor";
      patientsPerDoctor[doctorName] = (patientsPerDoctor[doctorName] ?? 0) + 1;
    }
    return AdminStatisticsModel(
      totalPatients: patients.length,
      totalDoctors: doctors.length,
      healthStatusCounts: healthStatusCounts,
      patientsPerDoctor: patientsPerDoctor,
      examinedCount: examined,
      unexaminedCount: unexamined,
    );
  }
}
