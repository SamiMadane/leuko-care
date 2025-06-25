
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/widgets/custom_status_dialog.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
import 'package:leuko_care/feature/doctors/logic/cubit/doctor_cubit.dart';
import 'package:leuko_care/feature/doctors/logic/cubit/doctor_state.dart';
import 'package:leuko_care/core/routes/routes.dart';
import 'package:leuko_care/feature/doctors/ui/views/doctor_user/analyzing_screen.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';

class AnalyzeBlocListener extends StatefulWidget {
  final Widget child;
  final DoctorModel doctor;
  final PatientModel? selectedPatient;
  const AnalyzeBlocListener({
    super.key,
    required this.child,
    required this.doctor,
    required this.selectedPatient,
  });

  @override
  State<AnalyzeBlocListener> createState() => _AnalyzeBlocListenerState();
}
class _AnalyzeBlocListenerState extends State<AnalyzeBlocListener> {
  bool isAnalyzingScreenVisible = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<DoctorCubit, DoctorState>(
      listener: (context, state) async {
        final navigator = Navigator.of(context);

        state.whenOrNull(
          analyzingSampleLoading: () {
            if (!isAnalyzingScreenVisible) {
              isAnalyzingScreenVisible = true;
              navigator.push(
                MaterialPageRoute(builder: (_) => const AnalyzingScreen()),
              );
            }
          },
          analyzingSampleSuccess: (result) async {
            if (isAnalyzingScreenVisible) {
              isAnalyzingScreenVisible = false;
              navigator.pop(); // إغلاق شاشة التحليل
            }
            navigator.pushNamed(
              Routes.sampleResultScreen,
              arguments: {
                'patient': widget.selectedPatient,
                'doctor': widget.doctor,
                'result': result.result,
                'diseaseType': result.diseaseType,
                'confidence': result.confidence,
                'aiMessage': result.aiMessage,
                'sampleImageUrl': result.sampleImageUrl,
              },
            );
          },
          analyzingSampleError: (message) async {
            if (isAnalyzingScreenVisible) {
              isAnalyzingScreenVisible = false;
              navigator.pop(); // إغلاق شاشة التحليل
            }
             showAnimatedStatusDialog(
              context: context,
              statusType: DialogStatusType.error,
              title: 'Error'.tr(),
              message: message,
              buttonText: 'OK'.tr(),
              onConfirm: () => navigator.pop(),
            );
          },
        );
      },
      child: widget.child,
    );
  }
}
