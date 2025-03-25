import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/feature/login/data/repository/admin_login_repo.dart';
import 'package:leuko_care/feature/login/logic/cubit/admin_login_state.dart';

class AdminLoginCubit extends Cubit<AdminLoginState> {
  final AdminLoginRepository loginRepository;
  AdminLoginCubit(this.loginRepository) : super(AdminLoginState.initial());

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void checkAdmin() async {
    emit(const AdminLoginLoading());
    final result = await loginRepository.adminLogin(emailController.text, passwordController.text);
    result.when(
      success: (user) {
        user != null
            ? emit(AdminLoginSuccess(user))
            : emit(AdminLoginError("User not found"));
      },
      failure: (error) => emit(AdminLoginError(error)),
    );
  }

    Future<void> signInWithGoogle() async {
    emit(const AdminLoginLoading());
      final result = await loginRepository.signInWithGoogle();
      result.when(
        success: (user) => {
          print ("signInWithGoogle success and user is $user"), 
            user != null
            ? emit(AdminLoginSuccess(user))
            : emit(AdminLoginError("Failed to sign in with Google"))
        },
        failure: (error) {
          print ("signInWithGoogle failure and error is $error");
          emit(AdminLoginError(error));
        }
      );
  }
}
