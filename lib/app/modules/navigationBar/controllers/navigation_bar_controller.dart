import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttermoji/fluttermojiCircleAvatar.dart';
import 'package:fluttermoji/fluttermojiController.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/models/user_model.dart';
import 'package:kamelion/app/modules/profile/controllers/profile_controller.dart';
import 'package:kamelion/app/routes/app_pages.dart';
import 'package:kamelion/app/services/auth.dart';
import 'package:kamelion/app/services/dio/api_service.dart';
import 'package:kamelion/app/services/snackbar.dart';
import 'package:kamelion/generated/locales.g.dart';

class NavigationBarController extends GetxController {
  //TODO: Implement NavigationBarController

  final count = 0.obs;
  var selectedIndex = 0.obs;
  @override
  void onInit() {
    super.onInit();
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

  void changePage(int index) {
    selectedIndex.value = index;
    if (index == 4) {
      final profileController = Get.isRegistered<ProfileController>()
          ? Get.find<ProfileController>()
          : Get.put(ProfileController());
      profileController.isLoading.value = true;
      profileController.getLeaderBoardStats();
      profileController.getMyStats();
      profileController.isLoading.value = false;
    }
  }
}
