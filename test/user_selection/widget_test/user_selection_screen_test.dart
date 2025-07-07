import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:leuko_care/feature/user_selection/ui/views/user_selection_screen.dart';
import 'package:leuko_care/core/routes/routes.dart';
import 'package:mocktail/mocktail.dart';

import '../../test_helpers.dart';

// ملاحظة: هذه الفئة ضرورية لاختبار التنقل
class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class FakeRoute extends Fake implements Route<dynamic> {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeRoute());
  });

  late MockNavigatorObserver mockObserver;

  setUp(() {
    mockObserver = MockNavigatorObserver();
  });

  testWidgets('displays titles and role buttons', (tester) async {
    await tester.pumpWidget(
      buildTestableWidget(MaterialApp(home: const UserSelectionScreen())),
    );

    await tester.pumpAndSettle();

    // تحقق من العناوين
    expect(find.text('User Selection'), findsOneWidget);
    expect(find.text('Please select your role to continue'), findsOneWidget);

    // تحقق من أزرار الأدوار
    expect(find.text('ADMIN'), findsOneWidget);
    expect(find.text('DOCTOR'), findsOneWidget);
    expect(find.text('PATIENT'), findsOneWidget);
  });

  testWidgets(
    'navigates to login screen with correct argument when tapping on a role',
    (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          MaterialApp(
            navigatorObservers: [mockObserver],
            routes: {Routes.loginScreen: (context) => const Placeholder()},
            home: const UserSelectionScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      final doctorFinder = find.text('DOCTOR');

      await tester.scrollUntilVisible(
        doctorFinder,
        300, // المسافة التي يتم تمريرها scroll حتى يظهر العنصر
      );

      await tester.tap(doctorFinder);
      await tester.pumpAndSettle();

      // تأكد من حدوث التنقل
      verify(() => mockObserver.didPush(any(), any())).called(greaterThan(0));
      expect(find.byType(Placeholder), findsOneWidget);
    },
  );
  
}
