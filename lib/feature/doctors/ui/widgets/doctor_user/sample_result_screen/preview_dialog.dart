import 'package:easy_localization/easy_localization.dart';

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:leuko_care/feature/chats/ui/views/chat_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/feature/chats/logic/cubit/chat_cubit.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';

void showPreviewDialog(BuildContext context, Uint8List image, DoctorModel doctor, PatientModel patient, String initialDoctorMessage) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text('Preview Before Sending'.tr()),
      content: Image.memory(image),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel'.tr())),
        ElevatedButton.icon(
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: context.read<ChatCubit>(),
                  child: ChatScreen(
                    currentUserId: doctor.id!,
                    otherUserId: patient.id!,
                    patient: patient,
                    initialDoctorMessage: initialDoctorMessage,
                    initialDoctorImage: image,
                    userType: 'patient',
                  ),
                ),
              ),
            );
          },
          icon: Icon(Icons.send, color: Colors.white),
          label: Text('Send'.tr(), style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
        ),
      ],
    ),
  );
}
