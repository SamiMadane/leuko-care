import 'dart:async';

import 'package:easy_localization/easy_localization.dart';

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/feature/chats/data/repository/chat_repo.dart';
import 'package:leuko_care/feature/chats/logic/cubit/chat_session_manager.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';
import '../../data/models/chat_model.dart';
import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepository _chatRepository;

  ChatCubit(this._chatRepository) : super(const ChatState.chatInitial());


  StreamSubscription? _doctorSubscription;
  StreamSubscription? _patientSubscription;

  Future<void> getDoctorInfo(String doctorId) async {
    final doc =
        await FirebaseFirestore.instance
            .collection('doctors')
            .doc(doctorId)
            .get();
    final doctor = DoctorModel.fromJson(doc.data()!);
    emit(ChatDoctorInfoLoaded(doctor));
  }

  Future<void> getPatientInfo(String patientId) async {
    final doc =
        await FirebaseFirestore.instance
            .collection('patients')
            .doc(patientId)
            .get();
    final patient = PatientModel.fromJson(doc.data()!);
    emit(ChatPatientInfoLoaded(patient));
  }

  @override
  Future<void> close() {
    _doctorSubscription?.cancel();
    _patientSubscription?.cancel();
    return super.close();
  }

  void setCurrentChatId(String chatId) {
    ChatSessionManager().currentChatId = chatId;
  }

  static String getChatId(String uid1, String uid2) {
    return uid1.hashCode <= uid2.hashCode ? '${uid1}_$uid2' : '${uid2}_$uid1';
  }

  void getMessages({required String senderId, required String receiverId}) {
    emit(ChatLoading());

    try {
      _chatRepository
          .getMessages(senderId: senderId, receiverId: receiverId)
          .listen((messages) {
            emit(ChatSuccess(messages));
          });
    } catch (e) {
      emit(ChatError('Failed to load messages'.tr()));
    }
  }

  Future<void> sendMessageWithOptionalImageAndText({
    required String senderId,
    required String receiverId,
    String? text,
    String? imagePath,
    Uint8List? imageBytes,
  }) async {
    try {
      emit(ChatLoading());

      String imageUrl = '';

      if (imagePath != null && imagePath.isNotEmpty) {
        imageUrl = await _chatRepository.uploadImageToCloudinary(
          imagePath: imagePath,
        );
      } else if (imageBytes != null) {
        imageUrl = await _chatRepository.uploadImageToCloudinary(
          imageBytes: imageBytes,
        );
      }

      final message = ChatModel(
        id: '',
        senderId: senderId,
        receiverId: receiverId,
        text: text?.trim() ?? '',
        timestamp: Timestamp.now(),
        attachmentUrl: imageUrl,
      );

      await _chatRepository.sendMessage(message);
      getMessages(senderId: senderId, receiverId: receiverId);
      emit(ChatMessageSentSuccessfully());
    } catch (e) {
      emit(ChatError('Failed to send message'.tr()));
    }
  }

  // دالة لحذف الرسالة
  Future<void> deleteMessage({
    required String senderId,
    required String receiverId,
    required String messageId,
  }) async {
    emit(ChatLoading());

    try {
      await _chatRepository.deleteMessage(
        senderId,
        receiverId,
        messageId,
      ); // حذف الرسالة من الريبو
      getMessages(senderId: senderId, receiverId: receiverId);

      emit(ChatMessageDeleteSuccessfully()); // حالة تفيد بحذف الرسالة
    } catch (e) {
      emit(ChatError(e.toString())); // في حالة حدوث خطأ
    }
  }

  Future<void> markMessagesAsReadForDoctor(
    String doctorId,
    String patientId,
  ) async {
    await _chatRepository.markMessagesAsReadByDoctor(doctorId, patientId);
    getMessages(senderId: doctorId, receiverId: patientId);
    emit(MessagesMarkedAsReadSuccessfully());
  }

  Future<void> markMessagesAsReadForPatient(
    String patientId,
    String doctorId,
  ) async {
    await _chatRepository.markMessagesAsReadByPatient(patientId, doctorId);
    getMessages(
      senderId: patientId,
      receiverId: doctorId,
    ); // أو العكس حسب الحاجة
    emit(MessagesMarkedAsReadSuccessfully());
  }
}
