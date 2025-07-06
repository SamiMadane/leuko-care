
// This class represents the full state of the Onboarding screen.
// Instead of creating multiple separate states (like Loading, Success, Error),
// we use a 'Single State Class'.tr() approach, which is perfect for simple screens
// that only need to track a few variables.
//
// We use immutability and provide a `copyWith` method to easily create new instances
// with updated fields without modifying the original state.
//
// This approach keeps the code clean, simple, and scalable for future improvements.
//
class OnboardingState {
  final int currentPage;
  final bool isLastPage;

  const OnboardingState({this.currentPage = 0, this.isLastPage = false});

  OnboardingState copyWith({int? currentPage, bool? isLastPage}) {
    return OnboardingState(
      currentPage: currentPage ?? this.currentPage,
      isLastPage: isLastPage ?? this.isLastPage,
    );
  }
}
