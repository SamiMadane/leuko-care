import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';

Widget sampleImageWidget(String sampleImageUrl) {
  if (sampleImageUrl.isNotEmpty) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Sample Image'.tr(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue)),
        SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(sampleImageUrl, height: 200),
        ),
      ],
    );
  }
  return SizedBox.shrink();
}
