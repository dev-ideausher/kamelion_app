import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/custom_button.dart';
import 'package:kamelion/app/services/custom_textfield.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';
import 'package:kamelion/generated/locales.g.dart';
import '../controllers/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      // floatingActionButtonLocation: FloatingActionButtonLocation.,
      appBar: AppBar(),
      // floatingActionButton: Obx(
      //   () => Padding(
      //     padding: EdgeInsets.all(20.ksp),
      //     child: CustomButton.outline(
      //       disabled: !controller.enabelSignUpBotton.value,
      //       onTap: () {
      //         if (controller.enabelSignUpBotton.value) {
      //           controller.licenceKeyBottomSheet(context);
      //         }
      //       },
      //       title: LocaleKeys.verify.tr,
      //     ),
      //   ),
      // ),
      body: Padding(
        padding: EdgeInsets.all(16.ksp),
        child: Form(
          key: controller.signUpFormKey,
          child: ListView(
            children: [
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.welcomeTo.tr + " ",
                      style: TextStyleUtil.genSans600(
                        fontSize: 20.ksp,
                        color: ColorUtil(context).black,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      LocaleKeys.kamelion.tr,
                      style: TextStyleUtil.genSans600(
                        fontSize: 20.ksp,
                        color: ColorUtil(context).brandColor1,
                      ),
                    ),
                  ],
                ),
              ),
              8.kheightBox,
              Text(
                " " + LocaleKeys.signupSubtitle.tr,
                style: TextStyleUtil.genNunitoSans500(
                  fontSize: 16.ksp,
                  color: ColorUtil(context).greyScaleText,
                ),
                textAlign: TextAlign.left,
              ),
              30.kheightBox,
              Text(
                " ${LocaleKeys.fullName.tr}",
                style: TextStyleUtil.genNunitoSans500(
                  fontSize: 12.ksp,
                  color: context.greyScaleText,
                ),
              ),
              6.kheightBox,
              CustomTextField(
                hintText: LocaleKeys.fullNameHint.tr,
                controller: controller.fullNameController,
                onChange: (val) => controller.checkFormValidity(val),
              ),
              16.kheightBox,
              Text(
                " ${LocaleKeys.email.tr}",
                style: TextStyleUtil.genNunitoSans500(
                  fontSize: 12.ksp,
                  color: context.greyScaleText,
                ),
              ),
              6.kheightBox,
              CustomTextField(
                hintText: LocaleKeys.emailHint.tr,
                controller: controller.emailController,
                onChange: (val) => controller.checkFormValidity(val),
              ),
              16.kheightBox,
              Text(
                " ${LocaleKeys.password.tr}",
                style: TextStyleUtil.genNunitoSans500(
                  fontSize: 12.ksp,
                  color: context.greyScaleText,
                ),
              ),
              6.kheightBox,
              CustomTextFieldPassword(
                isPassword: true,
                hintText: LocaleKeys.passwordHint.tr,
                controller: controller.passwordController,
                onChange: (val) => controller.checkFormValidity(val),
              ),
              16.kheightBox,
              Text(
                " ${LocaleKeys.confirmPassword.tr}",
                style: TextStyleUtil.genNunitoSans500(
                  fontSize: 12.ksp,
                  color: context.greyScaleText,
                ),
              ),
              6.kheightBox,
              CustomTextFieldPassword(
                isPassword: true,
                hintText: LocaleKeys.confirmPasswordHint.tr,
                controller: controller.confirmPasswordController,
                onChange: (val) => controller.checkFormValidity(val),
              ),
              150.kheightBox,
              Obx(
                () => Padding(
                  padding: EdgeInsets.all(0.ksp),
                  child: CustomButton.outline(
                    disabled: !controller.enabelSignUpBotton.value,
                    onTap: () {
                      if (controller.enabelSignUpBotton.value) {
                        controller.licenceKeyBottomSheet(context);
                      }
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
