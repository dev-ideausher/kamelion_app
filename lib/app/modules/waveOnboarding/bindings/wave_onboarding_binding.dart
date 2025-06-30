import 'package:get/get.dart';

import '../controllers/wave_onboarding_controller.dart';

class WaveOnboardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WaveOnboardingController>(
      () => WaveOnboardingController(),
    );
  }
}
