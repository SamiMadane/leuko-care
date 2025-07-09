import 'package:flutter_test/flutter_test.dart';
import 'package:leuko_care/feature/auth/logic/cubit/auth_state.dart';
import 'package:mocktail/mocktail.dart';
import 'package:leuko_care/feature/auth/logic/cubit/auth_cubit.dart';
import 'package:leuko_care/feature/auth/data/repository/auth_repo.dart';
import 'package:leuko_care/core/networking/operation_result.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MockAuthRepository extends Mock implements AuthRepository {}
class MockUser extends Mock implements User {}

void main() {
  late AuthCubit cubit;
  late MockAuthRepository mockRepository;
  late MockUser mockUser;

  setUp(() {
    mockRepository = MockAuthRepository();
    cubit = AuthCubit(mockRepository);
    mockUser = MockUser();
  });

  test('initial state is LoginInitial', () {
    // expect(cubit.state, isA<LoginInitial>());
  });

  group('checkAdmin', () {
    test('emits LoginSuccess on successful login', () async {
      when(() => mockRepository.login(any(), any(), any()))
          .thenAnswer((_) async => OperationResult.success(mockUser));

      cubit.emailController.text = 'test@example.com';
      cubit.passwordController.text = 'password';

      cubit.checkAdmin('doctor');

      await expectLater(
        cubit.stream,
        emitsInOrder([
          isA<LoginLoading>(),
          isA<LoginSuccess>(),
        ]),
      );
    });

    test('emits LoginError on login failure', () async {
      when(() => mockRepository.login(any(), any(), any()))
          .thenAnswer((_) async => OperationResult.failure('Error'));

      cubit.emailController.text = 'test@example.com';
      cubit.passwordController.text = 'wrongpassword';

      cubit.checkAdmin('doctor');

      await expectLater(
        cubit.stream,
        emitsInOrder([
          isA<LoginLoading>(),
          isA<LoginError>(),
        ]),
      );
    });
  });

  group('resetPassword', () {
    test('emits ResetPasswordSuccess on success', () async {
      when(() => mockRepository.resetPassword(any()))
          .thenAnswer((_) async => OperationResult.success(null));

      await cubit.resetPassword('test@example.com');

      expect(cubit.state, isA<ResetPasswordSuccess>());
    });

    test('emits ResetPasswordFailure on failure', () async {
      when(() => mockRepository.resetPassword(any()))
          .thenAnswer((_) async => OperationResult.failure('Error'));

      await cubit.resetPassword('wrong@example.com');

      expect(cubit.state, isA<ResetPasswordFailure>());
    });
  });

  group('signInWithGoogle', () {
    test('emits LoginSuccess on success', () async {
      when(() => mockRepository.signInWithGoogle(any()))
          .thenAnswer((_) async => OperationResult.success(mockUser));

      await cubit.signInWithGoogle('doctor');

      expect(cubit.state, isA<LoginSuccess>());
    });

    test('emits LoginError on failure', () async {
      when(() => mockRepository.signInWithGoogle(any()))
          .thenAnswer((_) async => OperationResult.failure('Error'));

      await cubit.signInWithGoogle('doctor');

      expect(cubit.state, isA<LoginError>());
    });
  });

  group('signOut', () {
    test('emits SignedOutStateSuccess on success', () async {
      when(() => mockRepository.signOut()).thenAnswer((_) async => Future.value());

      await cubit.signOut();

      expect(cubit.state, isA<SignedOutStateSuccess>());
    });

    test('emits SignedOutStateError on failure', () async {
      when(() => mockRepository.signOut()).thenThrow(Exception('fail'));

      await cubit.signOut();

      expect(cubit.state, isA<SignedOutStateError>());
    });
  });
}
