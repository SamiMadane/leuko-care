
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:leuko_care/feature/chats/data/models/conversation_model.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';
part 'doctor_state.freezed.dart';

@freezed
class DoctorState with _$DoctorState {
  // حالة مبدئية
  const factory DoctorState.doctorStateInitial() = _DoctorStateInitial;

  // Get all doctors states
  const factory DoctorState.getDoctorStateLoading() = GetDoctorStateLoading;
  const factory DoctorState.getDoctorStateSuccess(List<DoctorModel> doctors) = GetDoctorStateSuccess;
  const factory DoctorState.getDoctorStateError(String message) = GetDoctorStateError;

  // Add doctors states
  const factory DoctorState.addDoctorStateLoading() = AddDoctorStateLoading;
  const factory DoctorState.addDoctorStateSuccess() = AddDoctorStateSuccess;
  const factory DoctorState.addDoctorStateError(String message) = AddDoctorStateError;
  
  // Update doctors states
  const factory DoctorState.updateDoctorStateLoading() = UpdateDoctorStateLoading;
  const factory DoctorState.updateDoctorStateSuccess(DoctorModel doctor) = UpdateDoctorStateSuccess;
  const factory DoctorState.updateDoctorStateError(String message) = UpdateDoctorStateError;

  // Delete doctors states
  const factory DoctorState.deleteDoctorStateLoading() = DeleteDoctorStateLoading;
  const factory DoctorState.deleteDoctorStateSuccess() = DeleteDoctorStateSuccess;
  const factory DoctorState.deleteDoctorStateError(String message) = DeleteDoctorStateError;

 const factory DoctorState.getDoctorAndPatientsStateLoading() = GetDoctorAndPatientsStateLoading;
const factory DoctorState.getDoctorAndPatientsStateSuccess({
  required DoctorModel doctor,
  required List<PatientModel> patients,
  required Map<String, ConversationModel> conversationsByPatientId,
  PatientModel? selectedPatientForSampleUpload,
}) = GetDoctorAndPatientsStateSuccess;
  const factory DoctorState.getDoctorAndPatientsStateError(String error) = GetDoctorAndPatientsStateError;

  const factory DoctorState.doctorBottomNavChanged(int index) = DoctorBottomNavChanged;


}
