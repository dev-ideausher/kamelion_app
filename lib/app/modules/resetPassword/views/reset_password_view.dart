import 'package:flutter/material.dart';
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
                  suffixIconWidget: controller.isOldPassWordVisible.value
                      ? InkWell(
                          onTap: () {
                            controller.isOldPassWordVisible.value = false;
                          },
                          child: Icon(Icons.remove_red_eye_outlined))
                      : InkWell(
                          onTap: () {
                            controller.isOldPassWordVisible.value = true;
                          },
                          child: Icon(Icons.visibility_off_outlined)),
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
                  suffixIconWidget: controller.isNewPassWordVisible.value
                      ? InkWell(
                          onTap: () {
                            controller.isNewPassWordVisible.value = false;
                          },
                          child: Icon(Icons.remove_red_eye_outlined))
                      : InkWell(
                          onTap: () {
                            controller.isNewPassWordVisible.value = true;
                          },
                          child: Icon(Icons.visibility_off_outlined)),
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
                  suffixIconWidget: controller.isreNewPassWordVisible.value
                      ? InkWell(
                          onTap: () {
                            controller.isreNewPassWordVisible.value = false;
                          },
                          child: Icon(Icons.remove_red_eye_outlined))
                      : InkWell(
                          onTap: () {
                            controller.isreNewPassWordVisible.value = true;
                          },
                          child: Icon(Icons.visibility_off_outlined)),
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
