import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';

part 'patient_state.freezed.dart';

@freezed
class PatientState with _$PatientState {
  // حالة مبدئية
  const factory PatientState.patientStateInitial() = _PatientStateInitial;

  // حالة تحميل لجلب المرضى
  const factory PatientState.getPatientStateLoading() = GetPatientStateLoading;

  // حالة نجاح في جلب المرضى
  const factory PatientState.getPatientStateSuccess(List<PatientModel> patients) = GetPatientStateSuccess;

  // حالة خطأ في جلب المرضى
  const factory PatientState.getPatientStateError(String message) = GetPatientStateError;

  // حالة تحميل لإضافة مريض
  const factory PatientState.addPatientStateLoading() = AddPatientStateLoading;

  // حالة نجاح في إضافة مريض
  const factory PatientState.addPatientStateSuccess() = AddPatientStateSuccess;

  // حالة خطأ في إضافة مريض
  const factory PatientState.addPatientStateError(String message) = AddPatientStateError;

  // حالة تحميل لتحديث مريض
  const factory PatientState.updatePatientStateLoading() = UpdatePatientStateLoading;

  // حالة نجاح في تحديث مريض
  const factory PatientState.updatePatientStateSuccess() = UpdatePatientStateSuccess;

  // حالة خطأ في تحديث مريض
  const factory PatientState.updatePatientStateError(String message) = UpdatePatientStateError;

  // حالة تحميل لحذف مريض
  const factory PatientState.deletePatientStateLoading() = DeletePatientStateLoading;

  // حالة نجاح في حذف مريض
  const factory PatientState.deletePatientStateSuccess() = DeletePatientStateSuccess;

  // حالة خطأ في حذف مريض
  const factory PatientState.deletePatientStateError(String message) = DeletePatientStateError;
}
