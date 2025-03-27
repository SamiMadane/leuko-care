import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/resourses/assets_manager.dart';
import 'package:leuko_care/feature/login/data/repository/login_repo.dart';
import 'package:leuko_care/feature/login/logic/cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepository loginRepository;
  LoginCubit(this.loginRepository) : super(LoginState.initial());

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  Map<String, Map<String, dynamic>> userTypeData = {
      'admin': {
        'title': 'Admin Login',
        'image': AssetsManager.login,
      },
      'doctor': {
        'title': 'Doctor Login',
        'image':  AssetsManager.login,
      },
      'patient': {
        'title': 'Patient Login',
        'image':  AssetsManager.login,
      },
    };

  void checkAdmin(String userType) async {
    emit(const LoginLoading());
    final result = await loginRepository.adminLogin(emailController.text, passwordController.text,userType);
    result.when(
      success: (user) {
        user != null
            ? emit(LoginSuccess(user))
            : emit(LoginError("User not found"));
      },
      failure: (error) => emit(LoginError(error)),
    );
  }

    Future<void> signInWithGoogle(String userType) async {
    emit(const LoginLoading());
      final result = await loginRepository.signInWithGoogle(userType);
      result.when(
        success: (user) => {
          print ("signInWithGoogle success and user is $user"), 
            user != null
            ? emit(LoginSuccess(user))
            : emit(LoginError("Failed to sign in with Google"))
        },
        failure: (error) {
          print ("signInWithGoogle failure and error is $error");
          emit(LoginError(error));
        }
      );
  }
}
