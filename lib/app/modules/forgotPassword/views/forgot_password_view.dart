import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kamelion/app/components/common_image_view.dart';
import 'package:kamelion/app/constants/image_constant.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/custom_button.dart';
import 'package:kamelion/app/services/custom_textfield.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';

import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton:
            controller.IsMailSend.value
                ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.ksp),
                  child: CustomButton.outline(
                    onTap: () {
                      Get.back();
                    },
                    title: "Return to login",
                    disabled: !controller.isMailValid.value,
                  ),
                )
                : Container(),
        body: SafeArea(
          child: Container(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.all(12.ksp),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:
                      controller.IsMailSend.value
                          ? [
                            (context.height * 0.4).kheightBox,
                            Text(
                              "We've sent you a password reset link. Check your inbox!",
                              textAlign: TextAlign.center,
                              style: TextStyleUtil.genSans500(
                                fontSize: 19.ksp,
                                height: 1.1,
                                color: ColorUtil(context).black,
                              ),
                            ),
                            20.kheightBox,
                            Text(
                              "Just hit the link to reset your password, then log back in!",
                              textAlign: TextAlign.center,
                              style: TextStyleUtil.genSans400(
                                fontSize: 12.ksp,
                                height: 1.2,
                                color: ColorUtil(context).black,
                              ),
                            ),
                            100.kheightBox,
                          ]
                          : [
                            40.kheightBox,
                            CommonImageView(
                              svgPath: ImageConstant.kamelionConfused,
                            ),
                            30.kheightBox,
                            Text(
                              "Did you forget your password?",
                              textAlign: TextAlign.center,
                              style: TextStyleUtil.genSans500(
                                fontSize: 19.ksp,
                                height: 1.1,
                                color: ColorUtil(context).black,
                              ),
                            ),
                            20.kheightBox,
                            Text(
                              "Just drop your registered email here, and we’ll send you a link to reset your password!",
                              textAlign: TextAlign.center,
                              style: TextStyleUtil.genSans400(
                                fontSize: 12.ksp,
                                height: 1.2,
                                color: ColorUtil(context).black,
                              ),
                            ),
                            180.kheightBox,
                            CustomTextField(
                              controller: controller.mailController,
                              onChange: (a) => controller.checkFormValidity(a),
                              prefixIconWidget: Padding(
                                padding: EdgeInsets.only(
                                  left: 8.ksp,
                                  right: 8.0.ksp,
                                ),
                                child: Icon(
                                  Icons.mail_outlined,
                                  color: context.greyDark,
                                ),
                              ),
                              hintText: "Enter registered email address",
                            ),
                            12.kheightBox,
                            CustomButton.outline(
                              onTap: () => controller.submitMail(),
                              title: "Proceed",
                              disabled: !controller.isMailValid.value,
                            ),
                          ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
