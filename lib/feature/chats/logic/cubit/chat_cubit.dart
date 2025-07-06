import 'dart:async';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import 'package:leuko_care/core/helpers/network_helper.dart';
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
  StreamSubscription? _internetSubscription;
  bool _hasLoadedInitialMessages = false;

  void clearChatState() {
    _hasLoadedInitialMessages = false;
    emit(ChatState.chatInitial());
  }

  Future<void> getDoctorInfo(String doctorId) async {
    final doc =
        await FirebaseFirestore.instance
            .collection('doctors')
            .doc(doctorId)
            .get();
    emit(ChatDoctorInfoLoaded(DoctorModel.fromJson(doc.data()!)));
  }

  Future<void> getPatientInfo(String patientId) async {
    final doc =
        await FirebaseFirestore.instance
            .collection('patients')
            .doc(patientId)
            .get();
    emit(ChatPatientInfoLoaded(PatientModel.fromJson(doc.data()!)));
  }

  @override
  Future<void> close() {
    _doctorSubscription?.cancel();
    _patientSubscription?.cancel();
    _internetSubscription?.cancel();
    return super.close();
  }

  void setCurrentChatId(String chatId) =>
      ChatSessionManager().currentChatId = chatId;

  static String getChatId(String uid1, String uid2) =>
      uid1.hashCode <= uid2.hashCode ? '${uid1}_$uid2' : '${uid2}_$uid1';

  Future<void> cacheMessages(
    String senderId,
    String receiverId,
    List<ChatModel> messages,
  ) async {
    final box = await Hive.openBox<ChatModel>('chat_${senderId}_$receiverId');
    for (var msg in messages) {
      await box.put(msg.id, msg);
    }
  }

  Future<List<ChatModel>> getCachedMessages(
    String senderId,
    String receiverId,
  ) async {
    final box = await Hive.openBox<ChatModel>('chat_${senderId}_$receiverId');
    return box.values.toList();
  }

  Future<void> clearLocalMessages(String senderId, String receiverId) async {
    await (await Hive.openBox<ChatModel>(
      'chat_${senderId}_$receiverId',
    )).clear();
  }

  void getMessages({
    required String senderId,
    required String receiverId,
  }) async {
    if (!_hasLoadedInitialMessages) {
      emit(ChatLoading());
      _hasLoadedInitialMessages = true;
    }
    try {
      // Get Saved Message From Hive
      final cachedMessages = await getCachedMessages(senderId, receiverId);
      final hasInternet = await NetworkHelper.hasInternetConnection();

      if (cachedMessages.isNotEmpty) {
        final localMessages =
            cachedMessages
                .where((msg) => msg.status != MessageStatus.sent)
                .toList();
        final normalMessages =
            cachedMessages
                .where((msg) => msg.status == MessageStatus.sent)
                .toList();
        final filteredLocalMessages =
            localMessages
                .where(
                  (localMsg) =>
                      !normalMessages.any(
                        (msg) =>
                            msg.text == localMsg.text &&
                            ((msg.timestamp?.millisecondsSinceEpoch ?? 0) -
                                        (localMsg
                                                .timestamp
                                                ?.millisecondsSinceEpoch ??
                                            0))
                                    .abs() <
                                2000,
                      ),
                )
                .toList();

        final combined = [...normalMessages, ...filteredLocalMessages]
          ..sort((a, b) => a.timestamp!.compareTo(b.timestamp!));
        emit(ChatSuccess(combined));
      }

      if (hasInternet) {
        _chatRepository
            .getMessages(senderId: senderId, receiverId: receiverId)
            .listen((messages) async {
              await cacheMessages(senderId, receiverId, messages);
              final localMessages =
                  (await Hive.openBox<ChatModel>(
                        'chat_${senderId}_$receiverId',
                      )).values
                      .where((msg) => msg.status != MessageStatus.sent)
                      .toList();

              final filteredLocalMessages =
                  localMessages
                      .where(
                        (localMsg) =>
                            !messages.any(
                              (msg) =>
                                  msg.id == localMsg.id ||
                                  (msg.text == localMsg.text &&
                                      ((msg.timestamp?.millisecondsSinceEpoch ??
                                                      0) -
                                                  (localMsg
                                                          .timestamp
                                                          ?.millisecondsSinceEpoch ??
                                                      0))
                                              .abs() <
                                          5000),
                            ),
                      )
                      .toList();

              final combinedMessages = [...messages, ...filteredLocalMessages]
                ..sort((a, b) => a.timestamp!.compareTo(b.timestamp!));
              if (!isClosed) emit(ChatSuccess(combinedMessages));
            });
      } else if (cachedMessages.isEmpty) {
        emit(ChatSuccess([]));
      }
    } catch (e) {
      emit(ChatError('Failed to load messages'));
    }
  }

  Future<void> removeTempMessageFromCache({
    required String senderId,
    required String receiverId,
    required String tempId,
  }) async {
    await (await Hive.openBox<ChatModel>(
      'chat_${senderId}_$receiverId',
    )).delete(tempId);
  }

  Future<void> sendMessageWithOptionalImageAndText({
    required String senderId,
    required String receiverId,
    String? text,
    String? imagePath,
    Uint8List? imageBytes,
    String? retryingMessageId,
  }) async {
    final tempId =
        retryingMessageId ?? 'temp_${DateTime.now().millisecondsSinceEpoch}';
    final tempMessage = ChatModel(
      id: tempId,
      senderId: senderId,
      receiverId: receiverId,
      text: text?.trim() ?? '',
      timestamp: Timestamp.now(),
      attachmentUrl: '',
      status: MessageStatus.sending,
      localImagePath: imagePath,
    );

    if (state is ChatSuccess) {
      final currentMessages = (state as ChatSuccess).messages;
      final updatedMessages =
          retryingMessageId != null
              ? currentMessages
                  .map((msg) => msg.id == retryingMessageId ? tempMessage : msg)
                  .toList()
              : [...currentMessages, tempMessage];
      emit(ChatSuccess(updatedMessages));
      await cacheMessages(senderId, receiverId, updatedMessages);
    } else {
      emit(ChatSuccess([tempMessage]));
    }

    final hasInternet = await NetworkHelper.hasInternetConnection();
    if (!hasInternet) {
      if (state is ChatSuccess) {
        final currentMessages = (state as ChatSuccess).messages;
        final updatedMessages =
            currentMessages
                .map(
                  (msg) =>
                      msg.id == tempId
                          ? msg.copyWith(status: MessageStatus.failed)
                          : msg,
                )
                .toList();
        emit(ChatSuccess(updatedMessages));
        await cacheMessages(senderId, receiverId, updatedMessages);
      }
      return;
    }

    try {
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

      final realMessage = tempMessage.copyWith(
        id: '',
        attachmentUrl: imageUrl,
        localImagePath: null,
      );
      await _chatRepository.sendMessage(realMessage);
      await removeTempMessageFromCache(
        senderId: senderId,
        receiverId: receiverId,
        tempId: tempId,
      );

      if (state is ChatSuccess) {
        final updatedMessages =
            (state as ChatSuccess).messages
                .where((msg) => msg.id != tempId)
                .toList();
        emit(ChatSuccess(updatedMessages));
      }
    } catch (_) {
      if (state is ChatSuccess) {
        final updatedMessages =
            (state as ChatSuccess).messages
                .map(
                  (msg) =>
                      msg.id == tempId
                          ? msg.copyWith(status: MessageStatus.failed)
                          : msg,
                )
                .toList();
        emit(ChatSuccess(updatedMessages));
        await cacheMessages(senderId, receiverId, updatedMessages);
      }
      emit(ChatError('Failed to send message'.tr()));
    }
  }

  Future<void> deleteMessage({
    required String senderId,
    required String receiverId,
    required String messageId,
  }) async {
    final box = await Hive.openBox<ChatModel>('chat_${senderId}_$receiverId');
    final hasInternet = await NetworkHelper.hasInternetConnection();

    try {
      if (hasInternet) {
        await _chatRepository.deleteMessage(senderId, receiverId, messageId);
        await box.delete(messageId);
      } else {
        final message = box.get(messageId);
        if (message != null) {
          await box.put(messageId, message.copyWith(pendingDelete: true));
        }
      }
      getMessages(senderId: senderId, receiverId: receiverId);
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  void monitorInternetAndDeletePendingMessages(
    String senderId,
    String receiverId,
  ) {
    _internetSubscription?.cancel();
    _internetSubscription = InternetConnection().onStatusChange.listen((
      status,
    ) async {
      if (status == InternetStatus.connected) {
        final box = await Hive.openBox<ChatModel>(
          'chat_${senderId}_$receiverId',
        );
        final pendingDeletes =
            box.values.where((msg) => msg.pendingDelete).toList();

        for (var msg in pendingDeletes) {
          try {
            await _chatRepository.deleteMessage(senderId, receiverId, msg.id);
            await box.delete(msg.id);
          } catch (_) {}
        }
        getMessages(senderId: senderId, receiverId: receiverId);
      }
    });
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
    getMessages(senderId: patientId, receiverId: doctorId);
    emit(MessagesMarkedAsReadSuccessfully());
  }
}
