import 'package:easy_localization/easy_localization.dart';

import 'package:leuko_care/core/resources/assets_manager.dart';
import 'package:leuko_care/feature/onboarding/data/models/onboarding_model.dart';

 List<OnboardingModel> onboardingPages = [
  OnboardingModel(
    title: 'Welcome to LeukoAI'.tr(),
    subtitle: 'An intelligent assistant for early leukemia detection & smart patient care.'.tr(),
    imagePath: AssetsManager.onboarding1Image,
  ),
  OnboardingModel(
    title: 'AI-Powered Diagnosis'.tr(),
    subtitle: 'Upload blood samples and let AI help in fast, accurate analysis.'.tr(),
    imagePath: AssetsManager.onboarding2Image,
  ),
  OnboardingModel(
    title: 'Tailored for Everyone'.tr(),
    subtitle: 'Tailored experience for every role — manage, diagnose, and track with ease.'.tr(),
    imagePath: AssetsManager.onboarding3Image,
  ),
];
