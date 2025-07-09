import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/resources/assets_manager.dart';
import 'package:leuko_care/feature/auth/data/repository/auth_repo.dart';
import 'package:leuko_care/feature/auth/logic/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository loginRepository;
  AuthCubit(this.loginRepository) : super(AuthState.initial());

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Map<String, Map<String, dynamic>> userTypeData = {
    'admin': {
      'title': 'Welcome, Admin'.tr(),
      'image': AssetsManager.loginAdminImage,
    },
    'doctor': {
      'title': 'Welcome, Doctor'.tr(),
      'image': AssetsManager.loginDoctorImage,
    },
    'patient': {
      'title': 'Welcome, Patient'.tr(),
      'image': AssetsManager.loginPatientImage,
    },
  };

  void login(String userType) async {
    emit(LoginLoading());

    final result = await loginRepository.login(
      emailController.text,
      passwordController.text,
      userType,
    );
    result.when(
      success: (user) {
        user != null
            ? emit(LoginSuccess(user, userType))
            : emit(LoginError('User not found'.tr()));
      },
      failure: (error) => emit(LoginError(error)),
    );
  }

  Future<void> resetPassword(String email) async {
    emit(const ResetPasswordLoading());

    final result = await loginRepository.resetPassword(email);
    result.when(
      success: (_) {
        emit(
           ResetPasswordSuccess("reset_password_success".tr()),
        );
      },
      failure: (error) {
        emit(ResetPasswordFailure(error));
      },
    );
  }

  Future<void> updateLanguageInFirestore({
    required String userId,
    required String userType,
  }) async {
    if (userType == 'admin') return;

    await loginRepository.updateUserLanguage(userId, userType);
  }

  Future<void> signInWithGoogle(String userType) async {
    emit(const LoginLoading());
    final result = await loginRepository.signInWithGoogle(userType);
    result.when(
      success:
          (user) => {
            print("signInWithGoogle success and user is $user"),
            user != null
                ? emit(LoginSuccess(user, userType))
                : emit(LoginError('Failed to sign in with Google'.tr())),
          },
      failure: (error) {
        print("signInWithGoogle failure and error is $error");
        emit(LoginError(error));
      },
    );
  }

  Future<void> signOut() async {
    emit(SignedOutStateLoading());
    try {
      await loginRepository.signOut();
      emit(SignedOutStateSuccess());
    } catch (e) {
      emit(SignedOutStateError(e.toString()));
    }
  }
}
