import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/routes/app_pages.dart';
import 'package:kamelion/app/services/snackbar.dart';
import 'package:kamelion/generated/locales.g.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthDirectionController extends GetxController {
  //TODO: Implement AuthDirectionController

  final count = 0.obs;
  RxBool termsAccepted = false.obs;
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

  changeCheckboxValue(bool val) {
    termsAccepted.value = val;
    // update();
  }

  void openWebLink(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      ); // Opens in browser
    } else {
      throw '${LocaleKeys.cannotLaunchUrl.tr} $url';
    }
  }

  void signUpDirection() {
    if (termsAccepted.value) {
      Get.toNamed(Routes.SIGN_UP);
    } else {
      showMySnackbar(msg: LocaleKeys.acceptTermsRequest.tr);
    }
  }
}
