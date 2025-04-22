import 'package:firebase_auth/firebase_auth.dart';
import 'package:leuko_care/core/helpers/shared_pref_helper.dart';
import 'package:leuko_care/core/usecases/get_doctors_ordered_by_patients_count_usecase.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
import 'package:leuko_care/feature/doctors/data/repository/doctor_repo.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';
import 'package:leuko_care/feature/patients/data/repository/patient_repo.dart';

class AdminHomeRepository {
  final DoctorRepository doctorRepository;
  final PatientRepository patientRepository;
  final GetDoctorsOrderedByPatientsCountUseCase getDoctorsOrderedByPatientsCountUseCase;

  AdminHomeRepository({
    required this.doctorRepository,
    required this.patientRepository,
    required this.getDoctorsOrderedByPatientsCountUseCase,
  });

  Stream<List<DoctorModel>> getDoctorsStream() {
    return doctorRepository.getDoctorsStream();
  }

  // Future<List<DoctorModel>> getDoctorsOrderedByPatientsCount(List<DoctorModel> doctors) async {
  //   final doctorWithCounts = await Future.wait(
  //     doctors.map((doctor) async {
  //       // we use .first here to get counts of patients for each doctor (Future<List<PatientModel>> get first)
  //       final patients = await patientRepository.getPatientsByDoctorIdStream(doctor.id!).first;
  //       return MapEntry(doctor, patients.length);
  //     }),
  //   );

  //   doctorWithCounts.sort((a, b) => b.value.compareTo(a.value));
  //   return doctorWithCounts.map((entry) => entry.key).toList();
  // }

  Future<List<DoctorModel>> getDoctorsOrderedByPatientsCount(List<DoctorModel> doctors,bool isAscending) async {
    return getDoctorsOrderedByPatientsCountUseCase.call(doctors,isAscending);
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
}
