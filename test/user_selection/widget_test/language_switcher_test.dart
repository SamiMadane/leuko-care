import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:leuko_care/feature/user_selection/ui/widgets/language_switcher.dart';

import '../../test_helpers.dart'; // دالة buildTestableWidget الخاصة بك

void main() {
  testWidgets('LanguageSwitcher toggles language text on tap', (tester) async {
    // بدء بـ اللغة الإنجليزية
    await tester.pumpWidget(
      buildTestableWidget(const LanguageSwitcher(), locale: const Locale('en')),
    );

    await tester.pumpAndSettle();

    // نص الودجت يجب أن يكون "العربية" (يعني اللغة المقابلة)
    expect(find.text('العربية'), findsOneWidget);

    // اضغط على الودجت
    await tester.tap(find.byKey(const Key('language_switcher_gesture_detector')));
    await tester.pumpAndSettle();

    // النص يجب أن يتغير إلى "English"
    expect(find.text('English'), findsOneWidget);

    // اضغط مرة ثانية للتبديل إلى العربية
    await tester.tap(find.byKey(const Key('language_switcher_gesture_detector')));
    await tester.pumpAndSettle();

    // النص يعود إلى "العربية"
    expect(find.text('العربية'), findsOneWidget);
  });
}
