import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:leuko_care/core/resources/assets_manager.dart';
import 'package:leuko_care/feature/auth/logic/cubit/auth_state.dart';
import 'package:leuko_care/feature/auth/ui/views/login_screen.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/feature/auth/logic/cubit/auth_cubit.dart';

import '../../../test_helpers.dart';

// Mock Cubit
class MockAuthCubit extends Mock implements AuthCubit {}

void main() {
  late MockAuthCubit mockCubit;

  setUp(() {
    mockCubit = MockAuthCubit();
    when(() => mockCubit.emailController).thenReturn(TextEditingController());
    when(
      () => mockCubit.passwordController,
    ).thenReturn(TextEditingController());
    when(() => mockCubit.formKey).thenReturn(GlobalKey<FormState>());
    when(() => mockCubit.userTypeData).thenReturn({
      'doctor': {
        'image': AssetsManager.loginDoctorImage,
        'title': 'Welcome, Doctor',
      },
    });
    when(() => mockCubit.state).thenReturn(LoginInitial());

    when(() => mockCubit.stream).thenAnswer((_) => const Stream.empty());
  });

  Widget createWidgetUnderTest() {
    return buildTestableWidget(
      BlocProvider<AuthCubit>.value(
        value: mockCubit,
        child: const LoginScreen(userType: 'doctor'),
      ),
    );
  }

  testWidgets(
    'LoginScreen displays all expected widgets and handles validation',
    (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // Verify presence of input fields and buttons
      expect(find.byType(TextFormField), findsNWidgets(2)); // email & password
      expect(find.text('Login'), findsOneWidget);
      expect(find.text('Or login with'), findsOneWidget);
      expect(find.text('Sign in with Google'), findsOneWidget);
      final context = tester.element(find.byType(LoginScreen));
      expect(find.text('forgot_password'.tr(context: context)), findsOneWidget);
      // Tap login without entering anything
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      // Expect form validation error (using default validator text)
      expect(find.text('Please enter a valid email'), findsWidgets);

      // Simulate entering email & password
      mockCubit.emailController.text = 'test@example.com';
      mockCubit.passwordController.text = 'Test123@';

      // Tap login again
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      // Expect login to be called
      verify(() => mockCubit.login('doctor')).called(1);
    },
  );

  testWidgets('Forgot password dialog opens', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();
    final context = tester.element(find.byType(LoginScreen));

    await tester.tap(find.text('forgot_password'.tr(context: context)));
    await tester.pump();

    // Check for dialog
    expect(find.byType(Dialog), findsOneWidget);
    expect(
      find.text('enter_email_to_reset'.tr(context: context)),
      findsOneWidget,
    );
  });

  testWidgets('Google sign-in triggers cubit method', (
    WidgetTester tester,
  ) async {
    // تهيئة الميثود في mock
    when(() => mockCubit.signInWithGoogle(any())).thenAnswer((_) async {});
    await tester.binding.setSurfaceSize(const Size(800, 1200));

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    // تأكد من وجود النص أولاً
    expect(find.text('Sign in with Google'), findsOneWidget);

    // نفذ الـ tap
    await tester.tap(find.text('Sign in with Google'));
    await tester.pumpAndSettle();

    // تحقق أن الميثود استدعي
    verify(() => mockCubit.signInWithGoogle('doctor')).called(1);
  });
}
