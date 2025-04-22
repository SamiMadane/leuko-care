import 'package:leuko_care/feature/patients/data/models/patient_model.dart';

class PatientFilterHelper {
    // Filter patients based on search keyword and selected filter criteria
  static List<PatientModel> filterPatients({
    required List<PatientModel> patients,
    required String searchKeyword,
    required String filterBy,
    required String selectedFilterValue,
  }) {
    //First, we filter by search keyword if contains the keyword in name or email.
    return patients.where((patient) {
      final matchesSearch = patient.name.toLowerCase().contains(searchKeyword.toLowerCase()) ||
          patient.email.toLowerCase().contains(searchKeyword.toLowerCase());

      //Then, we filter by the selected filter criteria.
      bool matchesFilter = true;
      if (filterBy == 'Health Status') {
        matchesFilter =
            selectedFilterValue == 'All' ||
            (selectedFilterValue == 'Sick' &&
                patient.healthStatus != 'Not Sick' &&
                patient.isExamined) ||
            (selectedFilterValue == 'Healthy' &&
                patient.healthStatus == 'Not Sick' &&
                patient.isExamined) ||
            (selectedFilterValue == 'Unknown' && !patient.isExamined);
      } else if (filterBy == 'Examined Status') {
        matchesFilter =
            selectedFilterValue == 'All' ||
            (selectedFilterValue == 'Examined' && patient.isExamined) ||
            (selectedFilterValue == 'Not Examined' && !patient.isExamined);
      }
      // Patients who match the search and filter will be kept on the list.
      return matchesSearch && matchesFilter;
    }).toList();
  }
}
