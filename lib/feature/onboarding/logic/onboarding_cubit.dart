import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/feature/onboarding/data/datasources/onboarding_data.dart';
import 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(const OnboardingState());

  void changePage(int index) {
    emit(state.copyWith(
      currentPage: index,
      isLastPage: index == onboardingPages.length - 1,
    ));
  }

  void nextPage() {
    final newPage = state.currentPage + 1;
    if (newPage < onboardingPages.length) {
      emit(state.copyWith(
        currentPage: newPage,
        isLastPage: newPage == onboardingPages.length - 1,
      ));
    }
  }

  void previousPage() {
    final newPage = state.currentPage - 1;
    if (newPage >= 0) {
      emit(state.copyWith(
        currentPage: newPage,
        isLastPage: false,
      ));
    }
  }
}
