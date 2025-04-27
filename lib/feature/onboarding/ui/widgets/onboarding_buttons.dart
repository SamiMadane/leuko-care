import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/helpers/extensions.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/core/routes/routes.dart';
import 'package:leuko_care/feature/onboarding/logic/onboarding_cubit.dart';
import 'package:leuko_care/feature/onboarding/logic/onboarding_state.dart';

class OnboardingButtons extends StatelessWidget {
  final PageController controller;

  const OnboardingButtons({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                context.read<OnboardingCubit>().previousPage();
                controller.previousPage(
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeInOut,
                );
              },
              child: Text(
                'Back',
                style: getSemiBoldTextStyle(fontSize: FontSizeManager.s16, color: ColorsManager.primaryColor)
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (state.isLastPage) {
                  context.pushNamed(Routes.userSelectionScreen);
                } else {
                  context.read<OnboardingCubit>().nextPage();
                  controller.nextPage(
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeInOut,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsManager.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(RadiusManager.r30),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: WidthManager.w30,
                  vertical: HeightManager.h10,
                ),
              ),
              child: Text(
                state.isLastPage ? 'Get Started' : 'Next',
                style:getSemiBoldTextStyle(fontSize: FontSizeManager.s16, color: ColorsManager.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
