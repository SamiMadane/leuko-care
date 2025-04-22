import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';

class DoctorFilterHelper {
  // Filter doctors based on search keyword.
  static List<DoctorModel> filterDoctors({
    required List<DoctorModel> doctors,
    required String searchKeyword,
  }) {
    //We filter by search keyword if contains the keyword in name or email.
    return doctors.where((doctor) {
      final matchesSearch =
          doctor.name.toLowerCase().contains(searchKeyword.toLowerCase()) ||
          doctor.email.toLowerCase().contains(searchKeyword.toLowerCase());
      return matchesSearch;
    }).toList();
  }
}
