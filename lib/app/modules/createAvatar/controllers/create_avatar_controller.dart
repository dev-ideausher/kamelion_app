import 'dart:typed_data';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttermoji/fluttermojiFunctions.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/components/common_image_view.dart';
import 'package:kamelion/app/constants/image_constant.dart';
import 'package:kamelion/app/modules/home/controllers/home_controller.dart';
import 'package:kamelion/app/routes/app_pages.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/custom_button.dart';
import 'package:kamelion/app/services/dialog_helper.dart';
import 'package:kamelion/app/services/dio/api_service.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/snackbar.dart';
import 'package:kamelion/app/services/text_style_util.dart';
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

  void submitAvatar({BuildContext? context}) async {
    if (fromScreen == Routes.EDIT_PROFILE) {
      showDialog(
        context: context!,
        builder: (context) => Dialog(
          backgroundColor: context.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.ksp),
          ),
          child: Container(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.all(12.ksp),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CommonImageView(
                    svgPath: ImageConstant.smileIconBordered,
                  ),
                  6.kheightBox,
                  Text("Change your avatar for 50 Kalikoins?",
                      textAlign: TextAlign.center,
                      style: TextStyleUtil.genNunitoSans700(
                          fontSize: 14.ksp, color: context.black)),
                  6.kheightBox,
                  Text("You can always come back and change it again ",
                      textAlign: TextAlign.center,
                      style: TextStyleUtil.genNunitoSans400(
                          fontSize: 10.ksp, color: context.black)),
                  10.kheightBox,
                  CustomButton.outline(
                      onTap: () {
                        updateAvatar();
                      },
                      title: 'Save'),
                  6.kheightBox,
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      width: double.infinity,
                      height: 48.kh,
                      padding: EdgeInsets.symmetric(vertical: 0.ksp),
                      decoration: BoxDecoration(
                        color: context.white,
                        borderRadius: BorderRadius.circular(8.ksp),
                        border: Border.all(
                          color: context.greyBorder, // Border color
                          width: 2, // Border thickness
                        ),
                      ),
                      child: Center(
                        child: Text("Cancel",
                            textAlign: TextAlign.center,
                            style: TextStyleUtil.genNunitoSans700(
                                fontSize: 11.ksp, color: context.black)),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );

      // userAvatar = await FluttermojiFunctions().encodeMySVGtoString();
      // Get.back();

      return;
    }
    userAvatar = await FluttermojiFunctions().encodeMySVGtoString();

    Get.toNamed(Routes.AVATAR_NAME);
  }

  void updateAvatar() async {
    try {
      DialogHelper.showLoading();
      userAvatar = await FluttermojiFunctions().encodeMySVGtoString();

      var response = await APIManager.submitOnboardingAnswer(
        body: {
          "avatardetails": userAvatar,
        },
        id: Get.find<HomeController>().currentUser.value.sId ?? "",
      );

      if (response.statusCode == 200) {
        Get.find<HomeController>().getUser();
        Get.back();
        Get.back();
        Get.back();
        Get.back();
        DialogHelper.hideDialog();
        showMySnackbar(msg: response.data['message'] ?? "");
        return;
        // Get.offAllNamed(Routes.NAVIGATION_BAR, arguments: true);
      } else {
        debugPrint(
          "An error occurred while getting vendor profile: ${response.data['message']}",
        );
        DialogHelper.hideDialog();
      }
      update();
      return;
    } on DioException catch (dioError) {
      showMySnackbar(msg: dioError.message ?? "");
      DialogHelper.hideDialog();
    } catch (e) {
      debugPrint("An exception occurred while getting vendor details! $e");
      showMySnackbar(title: "Error", msg: e.toString());
      DialogHelper.hideDialog();
      return;
    }
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
