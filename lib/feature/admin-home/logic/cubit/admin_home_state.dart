import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';
part 'admin_home_state.freezed.dart';

@freezed
class AdminHomeState with _$AdminHomeState {
  // الحالة الأولية
  const factory AdminHomeState.homeStateInitial() = _HomeStateInitial;

  // حالة تحميل لجلب الدكاترة
  const factory AdminHomeState.getDoctorsStateLoading() = GetDoctorsStateLoading;

  // حالة نجاح في جلب الدكاترة
  const factory AdminHomeState.getDoctorsStateSuccess(List<DoctorModel> doctors) = GetDoctorsStateSuccess;

  // حالة خطأ في جلب الدكاترة
  const factory AdminHomeState.getDoctorsStateError(String message) = GetDoctorsStateError;

  // حالة تحميل لجلب المرضى
  const factory AdminHomeState.getPatientsStateLoading() = GetPatientsStateLoading;

  // حالة نجاح في جلب المرضى بناءً على الدكتور
  const factory AdminHomeState.getPatientsStateSuccess(List<PatientModel> patients) = GetPatientsStateSuccess;

  // حالة خطأ في جلب المرضى
  const factory AdminHomeState.getPatientsStateError(String message) = GetPatientsStateError;

  const factory AdminHomeState.signedOutStateLoading() = SignedOutStateLoading;
  const factory AdminHomeState.signedOutStateSuccess() = SignedOutStateSuccess;
  const factory AdminHomeState.signedOutStateError(String message) = SignedOutStateError;

}
