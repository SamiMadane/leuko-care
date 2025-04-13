import 'package:firebase_auth/firebase_auth.dart';
import 'package:leuko_care/core/helpers/shared_pref_helper.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
import 'package:leuko_care/feature/doctors/data/repository/doctor_repo.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';
import 'package:leuko_care/feature/patients/data/repository/patient_repo.dart';

class AdminHomeRepository {
  final DoctorRepository doctorRepository;
  final PatientRepository patientRepository;

  AdminHomeRepository({
    required this.doctorRepository,
    required this.patientRepository,
  });

  Stream<List<DoctorModel>> getDoctorsStream() {
    return doctorRepository.getDoctorsStream();
  }

  Future<List<DoctorModel>> getDoctorsOrderedByPatientsCount(List<DoctorModel> doctors) async {
    final doctorWithCounts = await Future.wait(
      doctors.map((doctor) async {
        final patients = await patientRepository.getPatientsByDoctorId(doctor.id!);
        return MapEntry(doctor, patients.length);
      }),
    );

    doctorWithCounts.sort((a, b) => b.value.compareTo(a.value));
    return doctorWithCounts.map((entry) => entry.key).toList();
  }

  Future<List<PatientModel>> getPatientsByDoctorId(String doctorId) {
    return patientRepository.getPatientsByDoctorId(doctorId);
  }

    Future<void> signOut() async {
    try {
      // تسجيل الخروج من Firebase
      await FirebaseAuth.instance.signOut();

      // مسح البيانات المحلية من SharedPreferences
      await SharedPrefHelper.clearAllData();
    } catch (e) {
      throw Exception("Error signing out: $e");
    }
  }
}
