import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'admin_login_state.freezed.dart';


@freezed
class AdminLoginState<T> with _$AdminLoginState<T> {
  const factory AdminLoginState.initial() = _AdminLoginInitial;

  const factory AdminLoginState.adminLoginLoading() = AdminLoginLoading;
  const factory AdminLoginState.adminLoginSuccess(User user) = AdminLoginSuccess;
  const factory AdminLoginState.adminLoginError(String error) = AdminLoginError;
}
