import 'package:flutter/material.dart';

class UploadSampleScreen extends StatelessWidget {
  const UploadSampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(),
      body: Column(
        children: [
          Center(child: Text('Upload Sample Screen')),
        ],
      )
    );
  }
}