import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingIndicator extends StatelessWidget {
  final PageController controller;
  final int count;

  const OnboardingIndicator({super.key, required this.controller, required this.count});

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: controller,
      count: count,
      effect: ExpandingDotsEffect(
        activeDotColor: ColorsManager.primaryColor,
        dotColor: Colors.grey.shade400,
        dotHeight: 8,
        dotWidth: 8,
        spacing: 6,
      ),
    );
  }
}
