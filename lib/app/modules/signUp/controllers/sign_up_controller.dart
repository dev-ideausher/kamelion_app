import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/components/common_image_view.dart';
import 'package:kamelion/app/constants/image_constant.dart';
import 'package:kamelion/app/routes/app_pages.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/custom_button.dart';
import 'package:kamelion/app/services/custom_textfield.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';
import 'package:kamelion/generated/locales.g.dart';

class SignUpController extends GetxController {
  //TODO: Implement SignUpController

  final count = 0.obs;
  final signUpFormKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  Rx<TextEditingController> lisenceKeyController = TextEditingController().obs;
  RxBool enabelSignUpBotton = false.obs;
  RxBool enabelLisenseKeyBotton = false.obs;
  RxBool verifyingLisenceKey = false.obs;
  RxBool licenseKeyVerified = false.obs;

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
    final confirmPassword = confirmPasswordController.text;
    final isEmailValid = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$',
    ).hasMatch(email);
    final isPasswordValid = password.length >= 6;
    final isNameValid = name.isNotEmpty;
    final isConfirmPasswordValid = confirmPassword == password;

    enabelSignUpBotton.value =
        isNameValid &&
        isEmailValid &&
        isPasswordValid &&
        isConfirmPasswordValid;

    update();
  }

  void licenceKeyBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom:
                MediaQuery.of(
                  context,
                ).viewInsets.bottom, // Handle keyboard pushing up
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20.0.ksp),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Wrap content height
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  16.kheightBox,
                  Text(
                    LocaleKeys.licenseKeyQuestion.tr,
                    style: TextStyleUtil.genSans500(
                      fontSize: 15.ksp,
                      color: ColorUtil(context).black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  30.kheightBox,
                  CustomButton.outline(
                    onTap: () {
                      licenceKeyFieldBottomSheet(context);
                    },
                    title: LocaleKeys.yesIHaveOne.tr,
                  ),
                  25.kheightBox,
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.GET_STARTED, arguments: false);
                    },
                    child: Text(
                      LocaleKeys.noNotRightNow.tr,
                      style: TextStyleUtil.genSans400(
                        fontSize: 14.ksp,
                        color: ColorUtil(context).brandColor1,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  30.kheightBox,
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void licenceKeyFieldBottomSheet(BuildContext context) {
    lisenceKeyController.value.clear();
    validateLisenseKey();
    verifyingLisenceKey = false.obs;
    licenseKeyVerified = false.obs;
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom:
                MediaQuery.of(
                  context,
                ).viewInsets.bottom, // Handle keyboard pushing up
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20.0.ksp),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Wrap content height
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  16.kheightBox,
                  Text(
                    LocaleKeys.licenseKeyQuestion.tr,
                    style: TextStyleUtil.genSans500(
                      fontSize: 15.ksp,
                      color: ColorUtil(context).black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  30.kheightBox,
                  CustomTextField(
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(right: 8.0.ksp),
                      child: SizedBox(
                        width: 10.ksp,
                        child: CommonImageView(
                          svgPath: ImageConstant.keyLogo,
                          width: 10.ksp,
                        ),
                      ),
                    ),
                    hintText: LocaleKeys.enterLicenseKeyHint.tr,
                    controller: lisenceKeyController.value,
                    onChange: (val) => validateLisenseKey(),
                  ),
                  16.kheightBox,
                  Obx(
                    () => CustomButton.outline(
                      disabled: !enabelLisenseKeyBotton.value,
                      onTap: () => verifyLisenceKey(),
                      leading: Padding(
                        padding: EdgeInsets.only(bottom: 4.ksp),
                        child: SizedBox(
                          height: 12.ksp,
                          width: 12.ksp,
                          child:
                              verifyingLisenceKey.value
                                  ? CircularProgressIndicator(
                                    color: ColorUtil(context).white,
                                    strokeWidth: 2.ksp,
                                  )
                                  : licenseKeyVerified.value
                                  ? Icon(
                                    Icons.check,
                                    weight: 2,
                                    color: ColorUtil(context).white,
                                  )
                                  : Container(),
                        ),
                      ),
                      title:
                          !licenseKeyVerified.value
                              ? LocaleKeys.verify.tr
                              : LocaleKeys.verified.tr,
                    ),
                  ),
                  30.kheightBox,
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void validateLisenseKey() {
    enabelLisenseKeyBotton.value = lisenceKeyController.value.text.isNotEmpty;
    update();
  }

  void verifyLisenceKey() async {
    verifyingLisenceKey.value = true;
    await Future.delayed(Duration(seconds: 2));
    verifyingLisenceKey.value = false;
    licenseKeyVerified = true.obs;
    await Future.delayed(Duration(seconds: 1));
    Get.toNamed(Routes.GET_STARTED);
  }
}
