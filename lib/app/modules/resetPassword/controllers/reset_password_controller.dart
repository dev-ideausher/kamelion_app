import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/modules/home/controllers/home_controller.dart';
import 'package:kamelion/app/routes/app_pages.dart';
import 'package:kamelion/app/services/auth.dart';
import 'package:kamelion/app/services/dialog_helper.dart';
import 'package:kamelion/app/services/snackbar.dart';

class ResetPasswordController extends GetxController {
  //TODO: Implement ResetPasswordController

  final count = 0.obs;
  RxBool isOldPassWordVisible = false.obs;
  RxBool isNewPassWordVisible = false.obs;
  RxBool isreNewPassWordVisible = false.obs;
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController reNewPasswordController = TextEditingController();
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

  void resetPassword() async {
    if (oldPasswordController.text == "") {
      showMySnackbar(
        msg: 'Enter your old password',
      );
      return;
    }
    if (newPasswordController.text == "") {
      showMySnackbar(
        msg: 'Enter your new password',
      );
      return;
    }
    final password = newPasswordController.text;

    final passwordRegex = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#\$%^&*()_+\-=\[\]{};:"\\|,.<>\/?€£¥₹]).{8,}$',
    );
    if (!passwordRegex.hasMatch(password)) {
      showMySnackbar(
        msg:
            'Password must be at least 8 characters, include uppercase, lowercase, number, and special character.',
      );
      return;
    }

    final confirmPassword = reNewPasswordController.text;

    if (confirmPassword != password) {
      showMySnackbar(msg: 'New passwords do not match');
      return;
    }

    try {
      DialogHelper.showLoading();
      final user = await FirebaseAuth.instance.currentUser;
      print(Get.find<HomeController>().currentUser.value.email!);
      print(oldPasswordController.text.trim());
      final cred = EmailAuthProvider.credential(
          email: Get.find<HomeController>().currentUser.value.email!,
          password: oldPasswordController.text.trim());

      user?.reauthenticateWithCredential(cred).then((value) {
        user.updatePassword(newPasswordController.text.trim()).then((_) {
          // DialogHelper.showSuccess("Password changed successfully");

          Get.back();
          DialogHelper.hideDialog();
          showMySnackbar(msg: "Password changes successfully");
          Auth auth = Auth();
          auth.logOutUser();
          //Success, do something
        }).catchError((error) {
          DialogHelper.hideDialog();
          //Error, show something
          showMySnackbar(msg: error.toString());
        });
      }).catchError((e) {
        DialogHelper.hideDialog();
        if (e.code == "invalid-credential") {
          showMySnackbar(msg: "You’ve entered the wrong password.");
        } else {
          showMySnackbar(msg: e.message.toString());
        }
      });
    } catch (e) {
      DialogHelper.hideDialog();
      showMySnackbar(msg: e.toString());
    }
  }
}
