import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/routes/app_pages.dart';
import 'package:kamelion/app/services/dialog_helper.dart';
import 'package:kamelion/app/services/snackbar.dart';

class ForgotPasswordController extends GetxController {
  //TODO: Implement ForgotPasswordController

  final count = 0.obs;
  RxBool IsMailSend = false.obs;
  RxBool isMailValid = false.obs;
  TextEditingController mailController = TextEditingController();
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

  submitMail() async {
    if (mailController.text.isNotEmpty) {
      try {
        DialogHelper.showLoading();
        final FirebaseAuth _auth = FirebaseAuth.instance;
        var r = await _auth.sendPasswordResetEmail(email: mailController.text);
        DialogHelper.hideDialog();
        IsMailSend.value = true;
        // showMySnackbar(msg: 'Password reset email sent');
      } on FirebaseAuthException catch (e) {
        DialogHelper.hideDialog();
        String message = 'An error occurred';
        if (e.code == 'user-not-found') {
          message = 'No user found with this email';
        } else if (e.code == 'invalid-email') {
          message = 'Invalid email address';
        }
        showMySnackbar(msg: message);
      } catch (e) {
        showMySnackbar(msg: e.toString());
      }
    }
  }

  void checkFormValidity(String value) {
    final email = mailController.text.trim();
    isMailValid.value = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$',
    ).hasMatch(email);

    update();
  }
}
