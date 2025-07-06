
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';
import '../../data/models/chat_model.dart';

part 'chat_state.freezed.dart';

@freezed
class ChatState with _$ChatState {
  const factory ChatState.chatInitial() = _ChatInitial;
  const factory ChatState.chatLoading() = ChatLoading;
  const factory ChatState.chatSuccess(List<ChatModel> messages) = ChatSuccess;
  const factory ChatState.chatError(String message) = ChatError;
  const factory ChatState.messagesMarkedAsReadSuccessfully() = MessagesMarkedAsReadSuccessfully;
  const factory ChatState.chatConversationUpdated(Map<String, dynamic> data) = ChatConversationUpdated;
  const factory ChatState.chatDoctorInfoLoaded(DoctorModel doctor) = ChatDoctorInfoLoaded;
  const factory ChatState.chatPatientInfoLoaded(PatientModel patient) = ChatPatientInfoLoaded;
}
