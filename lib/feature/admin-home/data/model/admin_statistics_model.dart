class AdminStatisticsModel {
  final int totalPatients;
  final int totalDoctors;
  final Map<String, int> healthStatusCounts;
  final Map<String, int> patientsPerDoctor;
  final int examinedCount;
  final int unexaminedCount;
  final Map<String, int> diseaseCounts;

  AdminStatisticsModel({
    required this.totalPatients,
    required this.totalDoctors,
    required this.healthStatusCounts,
    required this.patientsPerDoctor,
    required this.examinedCount,
    required this.unexaminedCount,
    required this.diseaseCounts,
  });
}
