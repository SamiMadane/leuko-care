
import 'package:leuko_care/core/usecases/get_doctors_ordered_by_patients_count_usecase.dart';
import 'package:leuko_care/feature/admin-home/data/model/admin_statistics_model.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
import 'package:leuko_care/feature/doctors/data/repository/doctor_repo.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';
import 'package:leuko_care/feature/patients/data/repository/patient_repo.dart';
import 'package:rxdart/rxdart.dart';

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

  Stream<AdminStatisticsModel> getAllStatistics() {
    return Rx.combineLatest2<
      List<PatientModel>,
      List<DoctorModel>,
      AdminStatisticsModel
    >(
      patientRepository.getPatientsStream(),
      doctorRepository.getDoctorsStream(),
      (patients, doctors) {
        int examined = 0;
        int unexamined = 0;
        final Map<String, int> healthStatusCounts = {};
        final Map<String, int> patientsPerDoctor = {};
        final Map<String, String> doctorNames = {
          for (var doctor in doctors) doctor.id!: doctor.name,
        };
        // Initialize health status counts make it zero for each status 
        final allLeukemiaTypes = ['AML', 'CML', 'ALL', 'CLL'];
        final Map<String, int> diseaseCounts = {
           for (var type in allLeukemiaTypes) type: 0,
        };

        for (var doctor in doctors) {
          patientsPerDoctor[doctor.name] = 0;
        }

        for (var patient in patients) {
          if (patient.isExamined) {
            examined++;
          } else {
            unexamined++;
          }

          if (patient.isExamined) {
            healthStatusCounts[patient.healthStatus] =
                (healthStatusCounts[patient.healthStatus] ?? 0) + 1;
          }

          final doctorName = doctorNames[patient.doctorId] ?? 'Unknown Doctor';
          patientsPerDoctor[doctorName] =
              (patientsPerDoctor[doctorName] ?? 0) + 1;

          if (patient.isExamined && patient.healthStatus == 'sick') {
            final leukemiaType = patient.leukemiaType;
            diseaseCounts[leukemiaType] =
                (diseaseCounts[leukemiaType] ?? 0) + 1;
          }
        }

        return AdminStatisticsModel(
          totalPatients: patients.length,
          totalDoctors: doctors.length,
          healthStatusCounts: healthStatusCounts,
          patientsPerDoctor: patientsPerDoctor,
          examinedCount: examined,
          unexaminedCount: unexamined,
          diseaseCounts: diseaseCounts,
        );
      },
    );
  }
}
