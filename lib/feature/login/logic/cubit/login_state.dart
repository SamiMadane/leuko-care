import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'login_state.freezed.dart';


@freezed
class LoginState<T> with _$LoginState<T> {
  const factory LoginState.initial() = _LoginInitial;

  const factory LoginState.loginLoading() = LoginLoading;
  const factory LoginState.loginSuccess(User user) = LoginSuccess;
  const factory LoginState.loginError(String error) = LoginError;
}
