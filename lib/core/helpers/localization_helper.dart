import 'dart:convert';
import 'package:flutter/services.dart';

Future<String> getLocalizedText({
  required String key,
  required String languageCode, 
  Map<String, String>? namedArgs,
}) async {
  try {
    final jsonString = await rootBundle.loadString('assets/lang/$languageCode.json');
    final Map<String, dynamic> translations = json.decode(jsonString);

    String? value = translations[key];
    if (value == null) return key;

    if (namedArgs != null) {
      namedArgs.forEach((placeholder, replacement) {
        value = value!.replaceAll('{$placeholder}', replacement);
      });
    }

    return value!;
  } catch (e) {
    print("Error loading localized text: $e");
    return key;
  }
}
