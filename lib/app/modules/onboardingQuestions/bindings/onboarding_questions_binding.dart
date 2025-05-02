import 'package:get/get.dart';

import '../controllers/onboarding_questions_controller.dart';

class OnboardingQuestionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnboardingQuestionsController>(
      () => OnboardingQuestionsController(),
    );
  }
}
