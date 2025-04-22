import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
import 'package:leuko_care/feature/patients/data/repository/patient_repo.dart';

class GetDoctorsOrderedByPatientsCountUseCase {
  final PatientRepository patientRepository;

  GetDoctorsOrderedByPatientsCountUseCase(this.patientRepository);

  Future<List<DoctorModel>> call(List<DoctorModel> doctors, bool isAscending ) async {
    final doctorWithCounts = await Future.wait(
      doctors.map((doctor) async {
        final patients = await patientRepository
            .getPatientsByDoctorIdStream(doctor.id!)
            .first;
        return MapEntry(doctor, patients.length);
      }),
    );

    doctorWithCounts.sort((a, b) {
      return isAscending
          ? a.value.compareTo(b.value)  // تصاعدي
          : b.value.compareTo(a.value); // تنازلي
    });

    return doctorWithCounts.map((entry) => entry.key).toList();
  }
}
