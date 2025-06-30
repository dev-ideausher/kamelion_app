import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttermoji/fluttermojiFunctions.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/routes/app_pages.dart';
import 'package:kamelion/app/services/dialog_helper.dart';
import 'package:kamelion/app/services/dio/api_service.dart';
import 'package:kamelion/app/services/snackbar.dart';
import 'package:kamelion/generated/locales.g.dart';

class CreateAvatarController extends GetxController {
  //TODO: Implement CreateAvatarController

  final count = 0.obs;
  String userAvatar = "";
  TextEditingController nickNameController = TextEditingController();
  String fromScreen = Routes.ONBOARDING_QUESTIONS;
  GlobalKey avatarKey = GlobalKey();

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

  void submitAvatar() async {
    if (fromScreen == Routes.EDIT_PROFILE) {
      Get.back();
      return;
    }
    userAvatar = await FluttermojiFunctions().encodeMySVGtoString();

    Get.toNamed(Routes.AVATAR_NAME);
  }

  void submitName() async {
    if (nickNameController.text.isEmpty) {
      showMySnackbar(msg: LocaleKeys.enterNickname.tr);
    } else {
      try {
        var user = await APIManager.getUser();
        var response = await APIManager.submitOnboardingAnswer(
          body: {
            "nickname": nickNameController.text,
            "avatardetails": userAvatar,
            "userType": "User",
          },
          id: user.data["data"]["_id"],
        );

        if (response.statusCode == 200) {
          Get.offAllNamed(Routes.WAVE_ONBOARDING);
         // Get.offAllNamed(Routes.NAVIGATION_BAR, arguments: true);
        } else {
          debugPrint(
            "An error occurred while getting vendor profile: ${response.data['message']}",
          );
        }
        update();
        return;
      } catch (e) {
        debugPrint("An exception occurred while getting vendor details! $e");
        showMySnackbar(title: "Error", msg: e.toString());
        return;
      }

      // Get.toNamed(Routes.NAVIGATION_BAR);
    }
  }
}
