import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/components/common_image_view.dart';
import 'package:kamelion/app/constants/image_constant.dart';
import 'package:kamelion/app/routes/app_pages.dart';
import 'package:kamelion/app/services/auth.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/custom_button.dart';
import 'package:kamelion/app/services/custom_textfield.dart';
import 'package:kamelion/app/services/dio/api_service.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/snackbar.dart';
import 'package:kamelion/app/services/storage.dart';
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
  RxBool isFormValid = false.obs;

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
    final isEmailValid = email.isNotEmpty;
    final isPasswordValid = password.length > 0;
    final isNameValid = name.isNotEmpty;
    final isConfirmPasswordValid = confirmPassword.length > 0;

    enabelSignUpBotton.value =
        isNameValid &&
        isEmailValid &&
        isPasswordValid &&
        isConfirmPasswordValid;

    update();
  }

  void licenceKeyBottomSheet(BuildContext context) async {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    final password = passwordController.text;
    if (!emailRegex.hasMatch(emailController.text)) {
      showMySnackbar(msg: 'Email is invalid');
      return;
    }
    final passwordRegex = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#\$%^&*()_+\-=\[\]{};:"\\|,.<>\/?]).{8,}$',
    );
    if (!passwordRegex.hasMatch(password)) {
      showMySnackbar(
        msg:
            'Password must be at least 8 characters, include uppercase, lowercase, number, and special character.',
      );
      return;
    }

    final confirmPassword = confirmPasswordController.text;

    if (confirmPassword != password) {
      showMySnackbar(msg: 'Passwords do not match');
      return;
    }

    try {
      // bool res = await Auth().createEmailPass(
      //   email: emailController.text.trim(),
      //   pass: passwordController.text.trim(),
      // );
      // if (res) {
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
                        Get.toNamed(
                          Routes.GET_SCHOOL,
                          arguments: {
                            "name": fullNameController.text,
                            "email": emailController.text,
                          },
                        );
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
      // }
    } catch (e) {
      showMySnackbar(msg: e.toString());
    }
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
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
                      CustomCodeInputFormatter(),
                    ],
                    prefixIconWidget: Padding(
                      padding: EdgeInsets.all(10.0.ksp),
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

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Include at least one uppercase letter';
    }

    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Include at least one lowercase letter';
    }

    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Include at least one number';
    }

    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Include at least one special character';
    }

    return null; // Password is valid
  }

  void validateLisenseKey() {
    enabelLisenseKeyBotton.value = lisenceKeyController.value.text.isNotEmpty;
    update();
  }

  // void verifyLisenceKey() async {
  //   verifyingLisenceKey.value = true;
  //   await Future.delayed(Duration(seconds: 2));
  //   verifyingLisenceKey.value = false;
  //   licenseKeyVerified = true.obs;
  //   await Future.delayed(Duration(seconds: 1));
  //   Get.toNamed(Routes.GET_STARTED);
  // }

  Future<void> verifyLisenceKey() async {
    try {
      var response;
      verifyingLisenceKey.value = true;
      response = await APIManager.verifyLisenceKey(
        body: {
          // "email": emailController.text.trim(),
          "licensekey": lisenceKeyController.value.text.trim(),
        },
      );

      if (response.statusCode == 200) {
        bool res = await Auth().createEmailPass(
          email: emailController.text.trim(),
          pass: passwordController.text.trim(),
        );
        if (res) {
          var resSignUp = await APIManager.signUp(
            body: {
              "name": fullNameController.text.trim(),
              "email": emailController.text.trim(),
            },
          );
          if (resSignUp.data['data'] != null && resSignUp.data['status']) {
            verifyingLisenceKey.value = false;
            licenseKeyVerified = true.obs;
            Get.find<GetStorageService>().isLoggedIn = true;
            Get.offAllNamed(Routes.GET_STARTED);
          }
        }
      }
      verifyingLisenceKey.value = false;
    } on DioException catch (dioError) {
      showMySnackbar(msg: dioError.response?.data['message'] ?? "");
      verifyingLisenceKey.value = false;
    } catch (e) {
      verifyingLisenceKey.value = false;
      showMySnackbar(msg: e.toString());
    }
  }
}

class CustomCodeInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Keep only letters and digits
    String filtered = newValue.text.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '');

    // Convert to uppercase
    filtered = filtered.toUpperCase();

    // Add hyphens after every 3 characters
    StringBuffer buffer = StringBuffer();
    for (int i = 0; i < filtered.length; i++) {
      if (i != 0 && i % 3 == 0) {
        buffer.write('-');
      }
      buffer.write(filtered[i]);
    }

    String formatted = buffer.toString();

    // Limit to 11 characters: XXX-XXX-XXX
    if (formatted.length > 11) {
      formatted = formatted.substring(0, 11);
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
