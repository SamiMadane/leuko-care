import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'auth_state.freezed.dart';

@freezed
class AuthState<T> with _$AuthState<T> {
  const factory AuthState.initial() = LoginInitial;

  const factory AuthState.loginLoading() = LoginLoading;
  const factory AuthState.loginSuccess(User user, String userType) =
      LoginSuccess;
  const factory AuthState.loginError(String error) = LoginError;

  // SignOut States
  const factory AuthState.signedOutStateLoading() = SignedOutStateLoading;
  const factory AuthState.signedOutStateSuccess() = SignedOutStateSuccess;
  const factory AuthState.signedOutStateError(String message) =
      SignedOutStateError;
  const factory AuthState.resetPasswordLoading() = ResetPasswordLoading;

  const factory AuthState.resetPasswordSuccess(String message) =
      ResetPasswordSuccess;
  const factory AuthState.resetPasswordFailure(String error) =
      ResetPasswordFailure;
}
