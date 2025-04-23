import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:leuko_care/feature/admin-home/data/model/admin_statistics_model.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';
part 'admin_home_state.freezed.dart';

@freezed
class AdminHomeState with _$AdminHomeState {
  const factory AdminHomeState.homeStateInitial() = _HomeStateInitial;
  // Get Doctors States
  const factory AdminHomeState.getDoctorsStateLoading() = GetDoctorsStateLoading;
  const factory AdminHomeState.getDoctorsStateSuccess(List<DoctorModel> doctors) = GetDoctorsStateSuccess;
  const factory AdminHomeState.getDoctorsStateError(String message) = GetDoctorsStateError;
  
  // Get Patient States
  const factory AdminHomeState.getPatientsStateLoading() = GetPatientsStateLoading;
  const factory AdminHomeState.getPatientsStateSuccess(List<PatientModel> patients) = GetPatientsStateSuccess;
  const factory AdminHomeState.getPatientsStateError(String message) = GetPatientsStateError;

  // SignOut States
  const factory AdminHomeState.signedOutStateLoading() = SignedOutStateLoading;
  const factory AdminHomeState.signedOutStateSuccess() = SignedOutStateSuccess;
  const factory AdminHomeState.signedOutStateError(String message) = SignedOutStateError;

  // Get Statistics States
  const factory AdminHomeState.getStatisticsStateLoading() = GetStatisticsStateLoading;
  const factory AdminHomeState.getStatisticsStateSuccess(AdminStatisticsModel statistics) = GetStatisticsStateSuccess;
  const factory AdminHomeState.getStatisticsStateError(String message) = GetStatisticsStateError;

}
