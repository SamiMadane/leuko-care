import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:leuko_care/feature/doctors/ui/widgets/doctor_user/sample_result_screen/result_info_row.dart';

Widget aiAnalysisWidget(String result, String diseaseType, double? confidence, String aiMessage) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('AI Analysis Result'.tr(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue)),
      SizedBox(height: 8),
      resultInfoRow('Result'.tr(), result),
      resultInfoRow('Type'.tr(), diseaseType.isEmpty ? 'Unknown'.tr() : diseaseType),
      resultInfoRow('Confidence'.tr(), confidence == null ? '-'.tr() : '${confidence.toStringAsFixed(1)}%'.tr()),
      resultInfoRow('Message'.tr(), aiMessage.isEmpty ? '-'.tr() : aiMessage),
      SizedBox(height: 16),
    ],
  );
}

