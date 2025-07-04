import 'package:flutter/material.dart';
import 'package:fluttermoji/fluttermojiController.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kamelion/app/modules/community/controllers/community_controller.dart';
import 'package:kamelion/app/modules/home/controllers/home_controller.dart';
import 'package:kamelion/app/modules/profile/controllers/profile_controller.dart';
import 'package:kamelion/app/routes/app_pages.dart';
import 'package:kamelion/app/services/dio/api_service.dart';
import 'package:kamelion/app/services/snackbar.dart';

class EditProfileController extends GetxController {
  //TODO: Implement EditProfileController

  final count = 0.obs;
  final loginFormKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final nicknameController = TextEditingController();
  RxString avatarDetails =
      (Get.find<HomeController>().currentUser.value.avatardetails ?? "").obs;
  RxBool enabelLoginBotton = false.obs;
  RxBool isLoading = false.obs;
  @override
  void onInit() async {
    isLoading.value = true;
    fullNameController.text =
        Get.find<HomeController>().currentUser.value.name ?? "";
    emailController.text =
        Get.find<HomeController>().currentUser.value.email ?? "";
    nicknameController.text =
        Get.find<HomeController>().currentUser.value.nickname ?? "";
    FluttermojiController controller = FluttermojiController();
    await controller.setFluttermoji(fluttermojiNew: avatarDetails.value);
    isLoading.value = false;
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

  void checkFormValidity() {
    final name = fullNameController.text.trim();
    final email = emailController.text.trim();
    final nickname = nicknameController.text;
    final isEmailValid = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$',
    ).hasMatch(email);
    final isNicknameValid = nickname.isNotEmpty;
    final isNameValid = name.isNotEmpty;

    enabelLoginBotton.value = isNameValid && isEmailValid && isNicknameValid;

    update();
  }

  void updateProfile() async {
    try {
      var response = await APIManager.updateUser(
        isOverlayLoader: true,
        body: {
          "nickname": nicknameController.text.trim(),
          "name": fullNameController.text.trim(),
          "userType": "User",
        },
        id: Get.find<HomeController>().currentUser.value.sId ?? "",
      );

      if (response.statusCode == 200) {
        Get.back();
        Get.find<HomeController>().getUser();
        Get.find<ProfileController>().getLeaderBoardStats();
        Get.find<CommunityController>().getYourCommunities();
        Get.find<CommunityController>().getTrendingCommunities();
        Get.find<CommunityController>().getSavedCommunities();
        showMySnackbar(msg: response.data['message'] ?? "");
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
