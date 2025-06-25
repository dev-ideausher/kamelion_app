import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'colors.dart';
import 'responsive_size.dart';

class DialogHelper {
  static void showLoading([String? message]) {
    Get.dialog(
      WillPopScope(
        child: SizedBox(
          child: Center(
            child: CircularProgressIndicator(color: Get.context?.brandColor1),
          ),
        ),
        onWillPop: () => Future.value(false),
      ),
      barrierDismissible: false,
      barrierColor: const Color(0xff141A31).withOpacity(.4),
      useSafeArea: true,
    );
  }

  //hide loading
  static Future<void> hideDialog() async {
    if (Get.isDialogOpen!) Get.until((route) => !Get.isDialogOpen!);
  }
}
