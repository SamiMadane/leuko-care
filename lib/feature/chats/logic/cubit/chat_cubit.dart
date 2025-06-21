import 'dart:async';

import 'package:easy_localization/easy_localization.dart';

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
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


  void clearChatState() {
    emit(ChatState.chatInitial());
  }

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
    _internetSubscription?.cancel();
    return super.close();
  }

  void setCurrentChatId(String chatId) {
    ChatSessionManager().currentChatId = chatId;
  }

  static String getChatId(String uid1, String uid2) {
    return uid1.hashCode <= uid2.hashCode ? '${uid1}_$uid2' : '${uid2}_$uid1';
  }

  Future<void> cacheMessages(
    String senderId,
    String receiverId,
    List<ChatModel> messages,
  ) async {
    final boxName = 'chat_${senderId}_$receiverId';
    final box = await Hive.openBox<ChatModel>(boxName);
    print('Caching ${messages.length} messages to $boxName');

    for (var msg in messages) {
      await box.put(msg.id, msg);
    }

    print('Cached ${box.length} messages to $boxName');

    // ✅ نطبع أول 3 رسائل
    for (var i = 0; i < box.values.length && i < 3; i++) {
      final msg = box.getAt(i);
      print('msg $i: id=${msg?.id}, text=${msg?.text}');
    }
  }

  Future<List<ChatModel>> getCachedMessages(
    String senderId,
    String receiverId,
  ) async {
    final boxName = 'chat_${senderId}_$receiverId';
    final box = await Hive.openBox<ChatModel>(boxName);
    for (var msg in box.values) {
      print('🧾 Cached: id=${msg.id}, text=${msg.text}, status=${msg.status}');
    }
    return box.values.toList();
  }

  Future<void> clearLocalMessages(String senderId, String receiverId) async {
    final boxName = 'chat_${senderId}_$receiverId';
    final box = await Hive.openBox<ChatModel>(boxName);
    await box.clear();
  }

  void getMessages({
    required String senderId,
    required String receiverId,
  }) async {
    emit(ChatLoading());

    try {
      final cachedMessages = await getCachedMessages(senderId, receiverId);
      bool hasInternet = await NetworkHelper.hasInternetConnection();

      if (cachedMessages.isNotEmpty) {
        // ✅ حتى بدون إنترنت، فلتر الرسائل المؤقتة لمنع التكرار
        final localMessages =
            cachedMessages
                .where((msg) => msg.status != MessageStatus.sent)
                .toList();
        final normalMessages =
            cachedMessages
                .where((msg) => msg.status == MessageStatus.sent)
                .toList();

        // ✅ حذف أي تكرار بين الرسائل المؤقتة والعادية
        final filteredLocalMessages =
            localMessages.where((localMsg) {
              final match = normalMessages.any(
                (msg) =>
                    msg.text == localMsg.text &&
                    (msg.timestamp?.toDate().millisecondsSinceEpoch ?? 0) -
                            (localMsg.timestamp
                                    ?.toDate()
                                    .millisecondsSinceEpoch ??
                                0) <
                        2000,
              );
              return !match;
            }).toList();

        final combined = [...normalMessages, ...filteredLocalMessages];
        combined.sort((a, b) => a.timestamp!.compareTo(b.timestamp!));

        emit(ChatSuccess(combined));
      }

      if (hasInternet) {
          
        _chatRepository
            .getMessages(senderId: senderId, receiverId: receiverId)
            .listen((messages) async {
              await cacheMessages(senderId, receiverId, messages);

              final box = await Hive.openBox<ChatModel>(
                'chat_${senderId}_$receiverId',
              );
              final localMessages =
                  box.values
                      .where((msg) => msg.status != MessageStatus.sent)
                      .toList();

              final filteredLocalMessages =
                  localMessages.where((localMsg) {
                    final match = messages.any((msg) {
                      final sameText = msg.text == localMsg.text;
                      final sameId = msg.id == localMsg.id;
                      final timeDifference =
                          ((msg.timestamp?.toDate().millisecondsSinceEpoch ??
                                      0) -
                                  (localMsg.timestamp
                                          ?.toDate()
                                          .millisecondsSinceEpoch ??
                                      0))
                              .abs();

                      final closeInTime =
                          timeDifference < 5000; // بدل 2000 لتوسيع هامش الخطأ

                      return sameId || (sameText && closeInTime);
                    });

                    return !match; // نحتفظ فقط بالرسائل التي لا يوجد لها شبيه
                  }).toList();

              final combinedMessages = [...messages, ...filteredLocalMessages];
              combinedMessages.sort(
                (a, b) => a.timestamp!.compareTo(b.timestamp!),
              );

              if (!isClosed) {
                emit(ChatSuccess(combinedMessages));
              }
            });
      } else if (cachedMessages.isEmpty) {
        emit(ChatSuccess(cachedMessages));
      }
    } catch (e) {
      print('❌ Error in getMessages: $e');
      emit(ChatError('Failed to load messages'));
    }
  }

  Future<void> removeTempMessageFromCache({
    required String senderId,
    required String receiverId,
    required String tempId,
  }) async {
    final boxName = 'chat_${senderId}_$receiverId';
    final box = await Hive.openBox<ChatModel>(boxName);
    await box.delete(tempId);
  }

  Future<void> sendMessageWithOptionalImageAndText({
    required String senderId,
    required String receiverId,
    String? text,
    String? imagePath,
    Uint8List? imageBytes,
    String? retryingMessageId, // إذا تم إعادة الإرسال من رسالة فاشلة
  }) async {
    final tempId =
        retryingMessageId ?? 'temp_${DateTime.now().millisecondsSinceEpoch}';

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

      final tempMessage = ChatModel(
        id: tempId,
        senderId: senderId,
        receiverId: receiverId,
        text: text?.trim() ?? '',
        timestamp: Timestamp.now(),
        attachmentUrl: imageUrl,
        status: MessageStatus.sending,
      );

      if (state is ChatSuccess) {
        final currentMessages = (state as ChatSuccess).messages;

        // إذا إعادة إرسال رسالة فاشلة، حدثها فقط بدل إضافة جديدة
        List<ChatModel> updatedMessages;
        if (retryingMessageId != null) {
          updatedMessages =
              currentMessages.map((msg) {
                if (msg.id == retryingMessageId) {
                  return tempMessage;
                }
                return msg;
              }).toList();
        } else {
          updatedMessages = [...currentMessages, tempMessage];
        }
        emit(ChatSuccess(updatedMessages));
        await cacheMessages(senderId, receiverId, updatedMessages);
      } else {
        emit(ChatSuccess([tempMessage]));
      }

      bool hasInternet = await NetworkHelper.hasInternetConnection();
      if (!hasInternet) {
        final currentMessages = (state as ChatSuccess).messages;
        final updatedMessages =
            currentMessages.map((msg) {
              if (msg.id == tempId) {
                return msg.copyWith(status: MessageStatus.failed);
              }
              return msg;
            }).toList();
        emit(ChatSuccess(updatedMessages));
        await cacheMessages(senderId, receiverId, updatedMessages);
        return;
      }

      // إنشاء نسخة حقيقية من الرسالة مع id فارغ أو id حقيقي عند إرسالها إلى الريبو
      final realMessage = tempMessage.copyWith(id: '');

      await _chatRepository.sendMessage(realMessage);
      await removeTempMessageFromCache(
        senderId: senderId,
        receiverId: receiverId,
        tempId: tempId,
      );

      // حذف الرسالة المؤقتة من الواجهة قبل جلب الرسائل الحقيقية
      if (state is ChatSuccess) {
        final currentMessages = (state as ChatSuccess).messages;
        final updatedMessages =
            currentMessages.where((msg) => msg.id != tempId).toList();
        emit(ChatSuccess(updatedMessages));
      }

      // جلب الرسائل الحقيقية من Firestore
      getMessages(senderId: senderId, receiverId: receiverId);
      emit(ChatMessageSentSuccessfully());
    } catch (e) {
      if (state is ChatSuccess) {
        final currentMessages = (state as ChatSuccess).messages;
        final updatedMessages =
            currentMessages.map((msg) {
              if (msg.id == tempId) {
                return msg.copyWith(status: MessageStatus.failed);
              }
              return msg;
            }).toList();
        emit(ChatSuccess(updatedMessages));
        await cacheMessages(senderId, receiverId, updatedMessages);
      }
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

    final boxName = 'chat_${senderId}_$receiverId';
    final box = await Hive.openBox<ChatModel>(boxName);

    try {
      // تحقق من وجود الإنترنت
      bool hasInternet = await NetworkHelper.hasInternetConnection();

      if (hasInternet) {
        // ✅ حذف من Firestore
        await _chatRepository.deleteMessage(senderId, receiverId, messageId);

        // ✅ حذف من Hive
        await box.delete(messageId);
        print('✅ Deleted message $messageId from Hive & Firestore');
      } else {
        // 🔁 حذف مؤجل - تعديل الرسالة لإظهار "سيتم حذفها لاحقًا"
        final message = box.get(messageId);
        if (message != null) {
          final updated = message.copyWith(pendingDelete: true);
          await box.put(messageId, updated);
          print('⏳ Marked message $messageId as pending delete (no internet)');
        }
      }

      // تحديث الرسائل
      getMessages(senderId: senderId, receiverId: receiverId);
      emit(ChatMessageDeleteSuccessfully());
    } catch (e) {
      print('❌ Error deleting message: $e');
      emit(ChatError(e.toString()));
    }
  }

  void monitorInternetAndDeletePendingMessages(String senderId, String receiverId) {
  _internetSubscription?.cancel();
  _internetSubscription = InternetConnection().onStatusChange.listen((status) async {
    if (status == InternetStatus.connected) {
      final boxName = 'chat_${senderId}_$receiverId';
      final box = await Hive.openBox<ChatModel>(boxName);

      final pendingDeletes = box.values.where((msg) => msg.pendingDelete).toList();

      for (var msg in pendingDeletes) {
        try {
          await _chatRepository.deleteMessage(senderId, receiverId, msg.id);
          await box.delete(msg.id);
          print('✅ Deleted pending message ${msg.id} after internet restored');
        } catch (e) {
          print('❌ Failed to delete pending message ${msg.id}: $e');
        }
      }

      // تحديث الواجهة بعد حذف الرسائل
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
    getMessages(
      senderId: patientId,
      receiverId: doctorId,
    ); // أو العكس حسب الحاجة
    emit(MessagesMarkedAsReadSuccessfully());
  }
}
