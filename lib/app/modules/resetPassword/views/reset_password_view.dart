import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/custom_button.dart';
import 'package:kamelion/app/services/custom_textfield.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';
import 'package:kamelion/generated/locales.g.dart';
import '../controllers/reset_password_controller.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  const ResetPasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.ksp),
        child: CustomButton.outline(
          // disabled: !controller.enabelLoginBotton.value,
          onTap: () {
            controller.resetPassword();
          },
          title: "Submit",
        ),
      ),
      body: Obx(
        () => Padding(
          padding: EdgeInsets.all(16.ksp),
          child: Form(
            // key: controller.loginFormKey,
            child: ListView(
              children: [
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Reset Password",
                        style: TextStyleUtil.genSans500(
                          fontSize: 20.ksp,
                          color: ColorUtil(context).black,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
                6.kheightBox,
                Text(
                  " " + LocaleKeys.signupSubtitle.tr,
                  // 'The Feel-Good Wellbeing Platform You Deserve ',
                  style: TextStyleUtil.genSans300(
                    fontSize: 12.ksp,
                    color: ColorUtil(context).black,
                  ),
                  textAlign: TextAlign.left,
                ),
                30.kheightBox,
                Text(
                  " Old Password",
                  style: TextStyleUtil.genSans300(
                    fontSize: 12.ksp,
                    color: context.black,
                  ),
                ),
                5.kheightBox,
                CustomTextField(
                  controller: controller.oldPasswordController,
                  hintText: LocaleKeys.passwordHint.tr,
                  suffixIconConstraints: BoxConstraints(
                    minHeight: 32,
                    minWidth: 32,
                    maxHeight: 32,
                    maxWidth: 32,
                  ),
                  suffixIconWidget: controller.isOldPassWordVisible.value
                      ? InkWell(
                          onTap: () {
                            controller.isOldPassWordVisible.value = false;
                          },
                          child: Padding(
                            padding: EdgeInsets.only(right: 8.0.ksp),
                            child: SizedBox(
                              child: SvgPicture.asset(
                                "assets/svg/eye.svg",
                              ),
                            ),
                          ))
                      : InkWell(
                          onTap: () {
                            controller.isOldPassWordVisible.value = true;
                          },
                          child: Padding(
                            padding: EdgeInsets.only(right: 8.0.ksp),
                            child: SvgPicture.asset(
                              "assets/svg/eye_hide.svg",
                              height: 1.ksp,
                              width: 1.ksp,
                            ),
                          ),
                        ),
                  obscureText: !controller.isOldPassWordVisible.value,
                  // controller: controller.passwordController,
                  // onChange: (val) => controller.checkFormValidity(val),
                ),
                10.kheightBox,
                Text(
                  " New Password",
                  style: TextStyleUtil.genSans300(
                    fontSize: 12.ksp,
                    color: context.black,
                  ),
                ),
                5.kheightBox,
                CustomTextField(
                  controller: controller.newPasswordController,
                  hintText: LocaleKeys.passwordHint.tr,
                  suffixIconConstraints: BoxConstraints(
                    minHeight: 32,
                    minWidth: 32,
                    maxHeight: 32,
                    maxWidth: 32,
                  ),
                  suffixIconWidget: controller.isNewPassWordVisible.value
                      ? InkWell(
                          onTap: () {
                            controller.isNewPassWordVisible.value = false;
                          },
                          child: Padding(
                            padding: EdgeInsets.only(right: 8.0.ksp),
                            child: SizedBox(
                              child: SvgPicture.asset(
                                "assets/svg/eye.svg",
                              ),
                            ),
                          ))
                      : InkWell(
                          onTap: () {
                            controller.isNewPassWordVisible.value = true;
                          },
                          child: Padding(
                            padding: EdgeInsets.only(right: 8.0.ksp),
                            child: SvgPicture.asset(
                              "assets/svg/eye_hide.svg",
                              height: 1.ksp,
                              width: 1.ksp,
                            ),
                          ),
                        ),
                  obscureText: !controller.isNewPassWordVisible.value,
                  // controller: controller.passwordController,
                  // onChange: (val) => controller.checkFormValidity(val),
                ),
                10.kheightBox,
                Text(
                  " Confirm Password",
                  style: TextStyleUtil.genSans300(
                    fontSize: 12.ksp,
                    color: context.black,
                  ),
                ),
                5.kheightBox,
                CustomTextField(
                  controller: controller.reNewPasswordController,
                  hintText: LocaleKeys.passwordHint.tr,
                  suffixIconConstraints: BoxConstraints(
                    minHeight: 32,
                    minWidth: 32,
                    maxHeight: 32,
                    maxWidth: 32,
                  ),
                  suffixIconWidget: controller.isreNewPassWordVisible.value
                      ? InkWell(
                          onTap: () {
                            controller.isreNewPassWordVisible.value = false;
                          },
                          child: Padding(
                            padding: EdgeInsets.only(right: 8.0.ksp),
                            child: SizedBox(
                              child: SvgPicture.asset(
                                "assets/svg/eye.svg",
                              ),
                            ),
                          ))
                      : InkWell(
                          onTap: () {
                            controller.isreNewPassWordVisible.value = true;
                          },
                          child: Padding(
                            padding: EdgeInsets.only(right: 8.0.ksp),
                            child: SvgPicture.asset(
                              "assets/svg/eye_hide.svg",
                              height: 1.ksp,
                              width: 1.ksp,
                            ),
                          ),
                        ),
                  obscureText: !controller.isreNewPassWordVisible.value,
                  // controller: controller.passwordController,
                  // onChange: (val) => controller.checkFormValidity(val),
                ),

                50.kheightBox,
                // Obx(
                //   () =>

                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
