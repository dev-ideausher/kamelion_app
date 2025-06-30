import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/components/common_image_view.dart';
import 'package:kamelion/app/constants/image_constant.dart';
import 'package:kamelion/app/constants/link_constants.dart';
import 'package:kamelion/app/routes/app_pages.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/custom_button.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';
import 'package:kamelion/generated/locales.g.dart';

import '../controllers/auth_direction_controller.dart';

class AuthDirectionView extends GetView<AuthDirectionController> {
  const AuthDirectionView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            child: CommonImageView(
              width: double.infinity,
              fit: BoxFit.cover,
              imagePath: ImageConstant.authDirectionBg,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: CommonImageView(
                    imagePath: ImageConstant.curveWhiteContainer,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 8.ksp,
                    horizontal: 16.0.ksp,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              LocaleKeys.welcomeTo.tr + " ",
                              style: TextStyleUtil.genSans600(
                                fontSize: 20.ksp,
                                color: ColorUtil(context).black,
                              ),
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
                      12.kheightBox,
                      Text(
                        LocaleKeys.platformDescription.tr,
                        // 'The Feel-Good Wellbeing Platform You Deserve ',
                        style: TextStyleUtil.genSans300(
                          fontSize: 12.ksp,
                          color: ColorUtil(context).black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      40.kheightBox,
                      Obx(
                        () => Row(
                          children: [
                            Checkbox(
                             side: BorderSide(color: context.grey,),


                              value: controller.termsAccepted.value,
                              activeColor: context.brandColor1,
                              onChanged: (value) {
                                controller.changeCheckboxValue(
                                  !controller.termsAccepted.value,
                                );
                               },
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  controller.changeCheckboxValue(
                                    !controller.termsAccepted.value,
                                  );
                                  // setState(() {
                                  //   _agreed = !_agreed;
                                  // });
                                },
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyleUtil.genNunitoSans400(
                                      fontSize: 16.kh,
                                      color: context.greyScaleText,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: LocaleKeys.agreeText.tr + " ",

                                        // 'I agree to Kamelion\'s '
                                      ),
                                      TextSpan(
                                        text: LocaleKeys.termsAndConditions.tr,
                                        // 'Terms and Conditions',
                                        style: TextStyleUtil.genNunitoSans700(
                                          fontSize: 16.kh,
                                          color: context.brandColorGreen2,
                                        ),
                                        recognizer:
                                            TapGestureRecognizer()
                                              ..onTap = () {
                                                controller.openWebLink(
                                                  LinkConstants()
                                                      .termsAndConditionsKamelion,
                                                );
                                              },
                                        // Optional: add a link or show a dialog
                                      ),
                                      TextSpan(
                                        text: " " + LocaleKeys.and.tr + " ",
                                        // ' and '
                                      ),
                                      TextSpan(
                                        text: LocaleKeys.privacyPolicy.tr,
                                        // 'Privacy Policy.',
                                        recognizer:
                                            TapGestureRecognizer()
                                              ..onTap = () {
                                                controller.openWebLink(
                                                  LinkConstants()
                                                      .privacyPolicyKamelion,
                                                );
                                              },
                                        style: TextStyleUtil.genNunitoSans700(
                                          fontSize: 16.kh,
                                          color: context.brandColorGreen2,
                                        ),
                                        // Optional: add a link or show a dialog
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      20.kheightBox,
                      CustomButton.outline(
                        onTap: () {
                          print("");
                          controller.signUpDirection();
                        },
                        title: LocaleKeys.iAmNewHere.tr,
                        color: context.white,
                      ),
                      30.kheightBox,
                      InkWell(
                        onTap: () {
                          Get.toNamed(Routes.LOGIN);
                        },
                        child: Text(
                          LocaleKeys.alreadyHaveAccount.tr,
                          style: TextStyleUtil.genNunitoSans600(
                            fontSize: 18.kh,
                            color: ColorUtil(context).brandColor1,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      50.kheightBox,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
