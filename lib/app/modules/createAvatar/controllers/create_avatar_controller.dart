import 'package:flutter/widgets.dart';
import 'package:fluttermoji/fluttermojiFunctions.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/routes/app_pages.dart';
import 'package:kamelion/app/services/snackbar.dart';
import 'package:kamelion/generated/locales.g.dart';

class CreateAvatarController extends GetxController {
  //TODO: Implement CreateAvatarController

  final count = 0.obs;
  String userAvatar = "";
  TextEditingController nickNameController = TextEditingController();
  String fromScreen = Routes.ONBOARDING_QUESTIONS;
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
    print(userAvatar);
    Get.toNamed(Routes.AVATAR_NAME);
  }

  void submitName() {
    if (nickNameController.text.isEmpty) {
      showMySnackbar(msg: LocaleKeys.enterNickname.tr);
    } else {
      Get.toNamed(Routes.NAVIGATION_BAR);
    }
  }
}
