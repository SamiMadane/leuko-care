import 'package:flutter/material.dart';
import 'package:leuko_care/core/localization/local_storage.dart';

class LocaleSettings {
  static const Map<String, String> languages = {
    'ar': 'العربية',
    'en': 'English',
  };

  List<Locale> get locales => languages.keys.map((code) => Locale(code)).toList();

  Locale get defaultLocale => Locale(LocaleStorage.locale);
}
