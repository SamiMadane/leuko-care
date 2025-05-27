import 'package:shared_preferences/shared_preferences.dart';

class LocaleStorage {
  static const _key = 'app_locale';
  static late String _cachedLocale;

  /// تحميل اللغة المخزنة مسبقًا (مرة واحدة في البداية)
  static Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_key) ?? 'ar';
    _cachedLocale = code;
  }

  /// استرجاع اللغة الحالية
  static String get locale => _cachedLocale;

  /// تغيير اللغة وحفظها
  static Future<void> setLocale(String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, code);
    _cachedLocale = code;
  }
}
