import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  static Future<void> init() async {
    // طلب الأذونات
    await _messaging.requestPermission();

    // الاستماع للرسائل في الخلفية والواجهة
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // تعامل مع الرسالة
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // تعامل مع فتح الإشعار
    });

    // احصل على التوكن (Token) لتسجيله في قاعدة البيانات إن لزم
    String? token = await _messaging.getToken();
    print("FCM Token: $token");
  }
}
