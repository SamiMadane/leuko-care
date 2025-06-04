import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:leuko_care/core/helpers/shared_pref_helper.dart';
import 'package:leuko_care/core/routes/routes.dart';
import 'package:leuko_care/feature/auth/data/repository/auth_repo.dart';
import 'package:leuko_care/feature/chats/logic/cubit/chat_cubit.dart';
import 'package:leuko_care/feature/chats/logic/cubit/chat_session_manager.dart';
import 'package:leuko_care/feature/chats/ui/views/chat_screen.dart';
import 'package:leuko_care/leuko_ai.dart';

// Initialize background message handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message: ${message.messageId}');
}

class NotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static Map<String, dynamic>? _pendingNotificationData;
  static String? _pendingUserType;

  static void listenToTokenRefresh({
    required AuthRepository authRepository,
    required String uid,
    required String userType,
  }) {
    _messaging.onTokenRefresh.listen((newToken) {
      print('FCM Token refreshed: $newToken');
      authRepository.saveFcmToken(uid, userType, newToken);
    });
  }

  // إعداد القناة الخاصة بالإشعارات على أندرويد
  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'high_importance_channel', // id القناة
    'High Importance Notifications', // اسم القناة للمستخدم
    description:
        'This channel is used for important notifications.', // وصف القناة
    importance: Importance.high,
  );

  static Future<void> init() async {
    // 1. طلب الأذونات
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }

    final userType = await SharedPrefHelper.getString('userType');

    // 2. تهيئة flutter_local_notifications
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
        InitializationSettings(
          android: androidInitializationSettings,
          iOS: DarwinInitializationSettings(),
        );

    await _localNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        print('Notification payload: ${response.payload}');
        if (response.payload == null) return;

        final payloadMap = jsonDecode(response.payload!);
        print('Click in Notification in foreground');
        handleNotificationNavigation(
          navigatorKey.currentContext!,
          payloadMap,
          userType,
        );
      },
    );

    // 3. إنشاء قناة الإشعارات (Android 8+)
    await _localNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(_channel);

    // 4. إعداد استقبال الرسائل في الخلفية
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // 5. استقبال الرسائل أثناء فتح التطبيق (foreground)
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received a message in the foreground: ${message.messageId}');
      _showLocalNotification(message);
    });

    // 6. التعامل مع فتح التطبيق من خلال إشعار
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('📲 Opened from background by tapping notification');
      handleNotificationNavigation(
        navigatorKey.currentContext!,
        message.data,
        userType,
      );
    });

    // 7. الحصول على التوكن وتخزينه (يجب إضافة دالة الحفظ الخاصة بك)
    String? token = await _messaging.getToken();
    print('FCM Token: $token');
  }

  static Future<void> _showLocalNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    final data = message.data;
    print('🔔 Notification data: $data');

    final chatId = data['chatId'];
    final currentChatId = ChatSessionManager().currentChatId;

    print('➡️ chatId from message data: $chatId');

    if (chatId != null && chatId == currentChatId) {
      print('Skipping notification because user is already in the same chat.');
      return;
    }

    if (notification != null && android != null) {
      await _localNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _channel.id,
            _channel.name,
            channelDescription: _channel.description,
            icon: android.smallIcon,
            importance: Importance.high,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails(),
        ),
        payload: jsonEncode({
          'chatId': data['chatId'],
          'senderId': data['senderId'],
          'receiverId': data['receiverId'],
          'type': data['type'],
        }), // هنا تمرر كل البيانات التي تحتاجها
      );
    }
  }

  static Future<void> handleNotificationNavigation(
    BuildContext context,
    Map<String, dynamic> data,
    String userType,
  ) async {
    final chatId = data['chatId'];
    final senderId = data['senderId'];
    final receiverId = data['receiverId'];
    final type = data['type'];

    if (chatId == null || chatId.isEmpty) {
      print('❌ chatId is null or empty');
      return;
    }

    ChatSessionManager().currentChatId = chatId;

    if (userType == 'patient' && type == 'chat') {
      Navigator.of(
        context,
      ).pushReplacementNamed(Routes.patientScreen, arguments: 1);
    } else if (userType == 'doctor' && type == 'chat') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder:
              (_) => BlocProvider.value(
                value: GetIt.instance<ChatCubit>(),
                child: ChatScreen(
                  currentUserId: receiverId,
                  otherUserId: senderId,
                  userType: 'doctor',
                ),
              ),
        ),
      );
    }
  }

  static void setPendingNotification(
    Map<String, dynamic> data,
    String? userType,
  ) {
    _pendingNotificationData = data;
    _pendingUserType = userType;
  }

  static void processPendingNotificationIfNeeded() {
    if (_pendingNotificationData != null &&
        _pendingUserType != null &&
        navigatorKey.currentContext != null) {
      handleNotificationNavigation(
        navigatorKey.currentContext!,
        _pendingNotificationData!,
        _pendingUserType!,
      );
      _pendingNotificationData = null;
      _pendingUserType = null;
    }
  }
}
