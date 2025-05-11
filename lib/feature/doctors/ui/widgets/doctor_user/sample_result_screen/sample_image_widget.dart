import 'package:flutter/material.dart';

Widget sampleImageWidget(String sampleImageUrl) {
  if (sampleImageUrl.isNotEmpty) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Sample Image", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue)),
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
