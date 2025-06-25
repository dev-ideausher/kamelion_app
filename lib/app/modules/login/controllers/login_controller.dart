import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/routes/app_pages.dart';
import 'package:kamelion/app/services/auth.dart';
import 'package:kamelion/app/services/dialog_helper.dart';
import 'package:kamelion/app/services/dio/api_service.dart';
import 'package:kamelion/app/services/snackbar.dart';
import 'package:kamelion/app/services/storage.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController

  final count = 0.obs;
  final loginFormKey = GlobalKey<FormState>();
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
    final email = emailController.text.trim();
    final password = passwordController.text;
    final isEmailValid = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$',
    ).hasMatch(email);
    final isPasswordValid = password.length >= 6;

    enabelLoginBotton.value = isEmailValid && isPasswordValid;

    update();
  }

  void login() async {
    if (enabelLoginBotton.value) {
      try {
        DialogHelper.showLoading();
        bool res = await Auth().loginEmailPass(
          email: emailController.text.trim(),
          pass: passwordController.text.trim(),
        );
        if (res) {
          var response = await APIManager.login();
          if (response.statusCode == 200) {
            DialogHelper.hideDialog();
            Get.find<GetStorageService>().isLoggedIn = true;
            Get.offAllNamed(Routes.NAVIGATION_BAR);
          }
        }
        DialogHelper.hideDialog();
      } on DioException catch (dioError) {
        DialogHelper.hideDialog();
        showMySnackbar(msg: dioError.response?.data['message'] ?? "");
      } catch (e) {
        DialogHelper.hideDialog();
        showMySnackbar(msg: e.toString(), title: "Error");
      }
    }
  }
}
