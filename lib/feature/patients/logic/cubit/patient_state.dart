import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';

part 'patient_state.freezed.dart';

@freezed
class PatientState with _$PatientState {
  const factory PatientState.patientStateInitial() = _PatientStateInitial;

  const factory PatientState.getPatientStateLoading() = GetPatientStateLoading;
  const factory PatientState.getPatientStateSuccess(List<PatientModel> patients) = GetPatientStateSuccess;
  const factory PatientState.getPatientStateError(String message) = GetPatientStateError;

  const factory PatientState.addPatientStateLoading() = AddPatientStateLoading;
  const factory PatientState.addPatientStateSuccess() = AddPatientStateSuccess;
  const factory PatientState.addPatientStateError(String message) = AddPatientStateError;

  const factory PatientState.updatePatientStateLoading() = UpdatePatientStateLoading;
  const factory PatientState.updatePatientStateSuccess(PatientModel patient) = UpdatePatientStateSuccess;
  const factory PatientState.updatePatientStateError(String message) = UpdatePatientStateError;

  const factory PatientState.deletePatientStateLoading() = DeletePatientStateLoading;
  const factory PatientState.deletePatientStateSuccess() = DeletePatientStateSuccess;
  const factory PatientState.deletePatientStateError(String message) = DeletePatientStateError;

  const factory PatientState.getPatientsByDoctorIdStateLoading() = GetPatientsByDoctorIdStateLoading;
  const factory PatientState.getPatientsByDoctorIdStateSuccess(List<PatientModel> patients) = GetPatientsByDoctorIdStateSuccess;
  const factory PatientState.getPatientsByDoctorIdStateError(String message) = GetPatientsByDoctorIdStateError;

  
  const factory PatientState.getPatientAndDoctorStateLoading() = GetPatientAndDoctorStateLoading;
  const factory PatientState.getPatientAndDoctorStateSuccess(DoctorModel doctor,PatientModel patient) = GetPatientAndDoctorStateSuccess;
  const factory PatientState.getPatientAndDoctorStateError(String message) = GetPatientAndDoctorStateError;

  const factory PatientState.patientBottomNavChanged(int index) = PatientBottomNavChanged;
  
}

