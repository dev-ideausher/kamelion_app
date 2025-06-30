import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../services/breathe_wave.dart';
import '../controllers/wave_onboarding_controller.dart';

class WaveOnboardingView extends GetView<WaveOnboardingController> {
  const WaveOnboardingView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(WaveOnboardingController());
    return Scaffold(
      backgroundColor: Color(0xFF4CAF50),

      body:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          WaveBreathingButton(onTap: () {  },)
        ],
      ),
    );
  }
}
