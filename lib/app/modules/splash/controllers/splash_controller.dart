import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/routes/app_pages.dart';
import 'package:kamelion/app/services/storage.dart';

class SplashController extends GetxController {
  //TODO: Implement SplashController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    directBasedOnLoginStatus();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  void directBasedOnLoginStatus() {
    Future.delayed(const Duration(milliseconds: 3000), () {
      Get.offAllNamed(
        Routes.AUTH_DIRECTION,
        // Get.find<GetStorageService>().isLoggedIn
        //     ? Routes.NAV_BAR
        //     : Routes.ONBOARDING,
      );
      // Get.offAllNamed(Routes.ONBOARDING);
    });
  }
}
