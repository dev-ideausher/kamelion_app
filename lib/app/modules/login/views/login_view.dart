import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/custom_button.dart';
import 'package:kamelion/app/services/custom_textfield.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';
import 'package:kamelion/generated/locales.g.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(),
      // floatingActionButton: Obx(
      //   () => Padding(
      //     padding: EdgeInsets.all(20.ksp),
      //     child: CustomButton.outline(
      //       disabled: !controller.enabelLoginBotton.value,
      //       onTap: () {
      //         controller.login();
      //       },
      //       title: LocaleKeys.submit.tr,
      //     ),
      //   ),
      // ),
      body: Padding(
        padding: EdgeInsets.all(16.ksp),
        child: Form(
          key: controller.loginFormKey,
          child: ListView(
            children: [
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.welcomeTo.tr + " ",
                      style: TextStyleUtil.genSans500(
                        fontSize: 20.ksp,
                        color: ColorUtil(context).black,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      LocaleKeys.kamelion.tr,
                      style: TextStyleUtil.genSans500(
                        fontSize: 20.ksp,
                        color: ColorUtil(context).brandColor1,
                      ),
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
                " ${LocaleKeys.fullName.tr}",
                style: TextStyleUtil.genSans300(
                  fontSize: 12.ksp,
                  color: context.black,
                ),
              ),
              10.kheightBox,
              CustomTextField(
                hintText: LocaleKeys.fullNameHint.tr,
                controller: controller.fullNameController,
                onChange: (val) => controller.checkFormValidity(val),
              ),
              10.kheightBox,
              Text(
                " ${LocaleKeys.email.tr}",
                style: TextStyleUtil.genSans300(
                  fontSize: 12.ksp,
                  color: context.black,
                ),
              ),
              10.kheightBox,
              CustomTextField(
                hintText: LocaleKeys.emailHint.tr,
                controller: controller.emailController,
                onChange: (val) => controller.checkFormValidity(val),
              ),
              10.kheightBox,
              Text(
                " ${LocaleKeys.password.tr}",
                style: TextStyleUtil.genSans300(
                  fontSize: 12.ksp,
                  color: context.black,
                ),
              ),
              10.kheightBox,
              CustomTextField(
                hintText: LocaleKeys.passwordHint.tr,
                controller: controller.passwordController,
                onChange: (val) => controller.checkFormValidity(val),
              ),
              50.kheightBox,
              Obx(
                () => Padding(
                  padding: EdgeInsets.all(0.ksp),
                  child: CustomButton.outline(
                    disabled: !controller.enabelLoginBotton.value,
                    onTap: () {
                      controller.login();
                    },
                    title: LocaleKeys.submit.tr,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
