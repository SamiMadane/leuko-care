import 'package:leuko_care/core/resources/assets_manager.dart';
import 'package:leuko_care/feature/onboarding/data/models/onboarding_model.dart';

const List<OnboardingModel> onboardingPages = [
  OnboardingModel(
    title: 'Welcome to LeukoAI',
    subtitle: 'An intelligent assistant for early leukemia detection & smart patient care.',
    imagePath: AssetsManager.onboarding1Image,
  ),
  OnboardingModel(
    title: 'AI-Powered Diagnosis',
    subtitle: 'Upload blood samples and let AI help in fast, accurate analysis.',
    imagePath: AssetsManager.onboarding2Image,
  ),
  OnboardingModel(
    title: 'Tailored for Everyone',
    subtitle: 'Tailored experience for every role — manage, diagnose, and track with ease.',
    imagePath: AssetsManager.onboarding3Image,
  ),
];
