import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';

Widget confirmationButtonsWidget(void Function() onConfirm, void Function() onCancel) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      ElevatedButton.icon(
        onPressed: onConfirm,
        icon: Icon(Icons.check, color: ColorsManager.white),
        label: Text("Confirm Diagnosis", style: TextStyle(fontSize: 14, color: ColorsManager.white)),
        style: ElevatedButton.styleFrom(backgroundColor: ColorsManager.primaryColor),
      ),
      ElevatedButton.icon(
        onPressed: onCancel,
        icon: Icon(Icons.cancel, color: ColorsManager.white),
        label: Text("Cancel", style: TextStyle(fontSize: 14, color: ColorsManager.white)),
        style: ElevatedButton.styleFrom(backgroundColor: ColorsManager.red),
      ),
    ],
  );
}
