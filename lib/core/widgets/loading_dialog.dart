import 'package:flutter/material.dart';
import 'package:leuko_care/core/resourses/colors_manager.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(color: ColorsManager.primaryColor),
    );
  }
}