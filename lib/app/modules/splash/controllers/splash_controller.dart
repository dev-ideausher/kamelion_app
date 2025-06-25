import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttermoji/fluttermojiFunctions.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/routes/app_pages.dart';
import 'package:kamelion/app/services/dio/api_service.dart';
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

  void directBasedOnLoginStatus() async {
    log(await FluttermojiFunctions().encodeMySVGtoString());
    Future.delayed(const Duration(milliseconds: 1000), () async {
      if (Get.find<GetStorageService>().isLoggedIn) {
        var user = await APIManager.getUser();
        if (user.data["data"]["answers"] == null) {
          Get.offAllNamed(Routes.GET_STARTED);
        } else if (user.data["data"]["nickname"] == null) {
          Get.offAllNamed(Routes.CREATE_AVATAR);
        } else {
          Get.offAllNamed(Routes.NAVIGATION_BAR);
        }
      } else {
        Get.offAllNamed(Routes.AUTH_DIRECTION);
      }
      // Get.offAllNamed(Routes.ONBOARDING);
    });
  }
}
