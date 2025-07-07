import 'package:flutter_test/flutter_test.dart';
import 'package:leuko_care/feature/onboarding/logic/onboarding_cubit.dart';

void main() {
  group('OnboardingCubit Tests', () {
    late OnboardingCubit cubit;

    setUp(() {
      cubit = OnboardingCubit();
    });

    tearDown(() {
      cubit.close();
    });

    test('initial state is correct', () {
      expect(cubit.state.currentPage, 0);
      expect(cubit.state.isLastPage, false);
    });

    test('changePage updates currentPage and isLastPage correctly', () {
      cubit.changePage(1);
      expect(cubit.state.currentPage, 1);
      expect(cubit.state.isLastPage, false);

      cubit.changePage(2);
      expect(cubit.state.currentPage, 2);
      expect(cubit.state.isLastPage, true);
    });

    test('nextPage increments page until last page', () {
      cubit.nextPage();
      expect(cubit.state.currentPage, 1);
      expect(cubit.state.isLastPage, false);

      cubit.nextPage();
      expect(cubit.state.currentPage, 2);
      expect(cubit.state.isLastPage, true);

      cubit.nextPage();
      expect(cubit.state.currentPage, 2);
      expect(cubit.state.isLastPage, true);
    });

    test('previousPage decrements page until first page', () {
      cubit.changePage(2);
      expect(cubit.state.currentPage, 2);

      cubit.previousPage();
      expect(cubit.state.currentPage, 1);
      expect(cubit.state.isLastPage, false);

      cubit.previousPage();
      expect(cubit.state.currentPage, 0);
      expect(cubit.state.isLastPage, false);

      cubit.previousPage();
      expect(cubit.state.currentPage, 0);
      expect(cubit.state.isLastPage, false);
    });
  });
}
