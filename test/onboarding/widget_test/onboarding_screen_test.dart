import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:leuko_care/feature/onboarding/logic/onboarding_cubit.dart';
import 'package:leuko_care/feature/onboarding/ui/views/onboarding_screen.dart';
import 'package:leuko_care/core/routes/routes.dart';

import '../../test_helpers.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}
// Fake class to provide a fallback instance of Route<dynamic> for mocktail
// This is required because mocktail needs a dummy Route object to use as
// a parameter when verifying NavigatorObserver methods like didPush.
// Without registering this fallback, tests that verify navigation calls
// will fail due to missing fallback values for Route<dynamic>.
class FakeRoute extends Fake implements Route<dynamic> {}

void main() {

   setUpAll(() {
    registerFallbackValue(FakeRoute());
  });
  testWidgets('shows first page and changes page on swipe', (tester) async {
    final onboardingCubit = OnboardingCubit();

    await tester.pumpWidget(
      buildTestableWidget(
        BlocProvider.value(
          value: onboardingCubit,
          child: const OnboardingScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(onboardingCubit.state.currentPage, 0);
    expect(find.byType(Image), findsOneWidget);

    await tester.drag(find.byType(PageView), const Offset(-400, 0));
    await tester.pumpAndSettle();

    expect(onboardingCubit.state.currentPage, 1);
  });

  testWidgets('changes page when Next button is pressed', (tester) async {
    final onboardingCubit = OnboardingCubit();

    await tester.pumpWidget(
      buildTestableWidget(
        BlocProvider.value(
          value: onboardingCubit,
          child: const OnboardingScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    final nextButton = find.text('Next');
    expect(nextButton, findsOneWidget);

    await tester.tap(nextButton);
    await tester.pumpAndSettle();

    expect(onboardingCubit.state.currentPage, 1);
  });

  testWidgets('Back button returns to previous page', (tester) async {
    final onboardingCubit = OnboardingCubit();
    onboardingCubit.changePage(1); // نبدأ من الصفحة الثانية

    await tester.pumpWidget(
      buildTestableWidget(
        BlocProvider.value(
          value: onboardingCubit,
          child: const OnboardingScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    final backButton = find.text('Back');
    expect(backButton, findsOneWidget);

    await tester.tap(backButton);
    await tester.pumpAndSettle();

    expect(onboardingCubit.state.currentPage, 0);
  });

  testWidgets('navigates to UserSelectionScreen when Get Started is pressed', (
    tester,
  ) async {
    final onboardingCubit = OnboardingCubit();
    final mockObserver = MockNavigatorObserver();

    await tester.pumpWidget(
      buildTestableWidget(
        BlocProvider.value(
          value: onboardingCubit,
          child: MaterialApp(
            navigatorObservers: [mockObserver],
            routes: {
              Routes.userSelectionScreen:
                  (context) => const Placeholder(), //  بنستخدم شاشة افتراضية بدل الشاشة الحقيقية لانه احنا بنختبر منطق انه انتقل للشاشة بهاد ال route
            },
            home: const OnboardingScreen(),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // السحب مرتين حتى نصل إلى الصفحة الأخيرة لاننا نستعمل page view
    await tester.drag(find.byType(PageView), const Offset(-400, 0)); // للصفحة 1
    await tester.pumpAndSettle();
    await tester.drag(find.byType(PageView), const Offset(-400, 0)); // للصفحة 2
    await tester.pumpAndSettle();

    final getStartedButton = find.text('Get Started');
    expect(getStartedButton, findsOneWidget);

    await tester.tap(getStartedButton);
    await tester.pumpAndSettle();
    // التحقق من أنه بعد الضغط على الزر تم  تفعيل push 
    verify(() => mockObserver.didPush(any(), any())).called(greaterThan(0));
    expect(find.byType(Placeholder), findsOneWidget);
  });
}
