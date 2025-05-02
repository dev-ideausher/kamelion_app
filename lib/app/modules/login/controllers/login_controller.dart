import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/routes/app_pages.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController

  final count = 0.obs;
  final loginFormKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  RxBool enabelLoginBotton = false.obs;
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

  void checkFormValidity(String value) {
    final name = fullNameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;
    final isEmailValid = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$',
    ).hasMatch(email);
    final isPasswordValid = password.length >= 6;
    final isNameValid = name.isNotEmpty;

    enabelLoginBotton.value = isNameValid && isEmailValid && isPasswordValid;

    update();
  }

  void login() {
    Get.toNamed(Routes.NAVIGATION_BAR);
  }
}
