import 'package:flutter/material.dart';
import 'package:leuko_care/feature/doctors/ui/widgets/doctor_user/sample_result_screen/result_info_row.dart';

Widget aiAnalysisWidget(String result, String diseaseType, double? confidence, String aiMessage) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("AI Analysis Result", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue)),
      SizedBox(height: 8),
      resultInfoRow("Result", result),
      resultInfoRow("Type", diseaseType.isEmpty ? "Unknown" : diseaseType),
      resultInfoRow("Confidence", confidence == null ? "-" : "${confidence.toStringAsFixed(1)}%"),
      resultInfoRow("Message", aiMessage.isEmpty ? "-" : aiMessage),
      SizedBox(height: 16),
    ],
  );
}

