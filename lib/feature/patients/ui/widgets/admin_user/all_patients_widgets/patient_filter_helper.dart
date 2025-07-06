import 'package:easy_localization/easy_localization.dart';

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
      final matchesSearch =
          patient.name.toLowerCase().contains(searchKeyword.toLowerCase()) ||
          patient.email.toLowerCase().contains(searchKeyword.toLowerCase());

      //Then, we filter by the selected filter criteria.
      bool matchesFilter = true;
      if (filterBy == 'Health Status'.tr()) {
        matchesFilter =
            selectedFilterValue == 'All'.tr() ||
            (selectedFilterValue == 'Sick'.tr() &&
                patient.healthStatus == 'sick'&&
                patient.isExamined) ||
            (selectedFilterValue == 'Healthy'.tr() &&
                patient.healthStatus == 'healthy'&&
                patient.isExamined) ;
      } else if (filterBy == 'Examined Status'.tr()) {
        matchesFilter =
            selectedFilterValue == 'All'.tr() ||
            (selectedFilterValue == 'Examined'.tr() && patient.isExamined) ||
            (selectedFilterValue == 'Not Examined'.tr() && !patient.isExamined);
      }
      // Patients who match the search and filter will be kept on the list.
      return matchesSearch && matchesFilter;
    }).toList();
  }
}
