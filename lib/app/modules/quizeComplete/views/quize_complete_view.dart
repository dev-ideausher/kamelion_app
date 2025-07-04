import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kamelion/app/components/common_image_view.dart';
import 'package:kamelion/app/constants/image_constant.dart';
import 'package:kamelion/app/modules/workoutDetails/controllers/workout_details_controller.dart';
import 'package:kamelion/app/routes/app_pages.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/custom_button.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';
import 'package:kamelion/generated/locales.g.dart';
import '../controllers/quize_complete_controller.dart';

class QuizeCompleteView extends GetView<QuizeCompleteController> {
  const QuizeCompleteView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuizeCompleteController>(builder: (controller) {
      // controller.coinsEarned.value = 0;
      return controller.isQuizeComplete == null
          ? Container(
              child: Center(
                child: CircularProgressIndicator(color: context.brandColor1),
              ),
            )
          : Scaffold(
              backgroundColor: ColorUtil(context).completionScreenBg,
              appBar: AppBar(
                  backgroundColor: ColorUtil(context).completionScreenBg),
              body: !controller.isQuizeComplete!.value
                  ? Column(children: [
                      50.kheightBox,
                      Center(
                        child:
                            CommonImageView(svgPath: ImageConstant.lioCrying),
                      ),
                      30.kheightBox,
                      Text(
                        "Wiped out on the quiz?",
                        style: TextStyleUtil.genSans500(
                          fontSize: 24.ksp,
                          color: context.black,
                        ),
                      ),
                      12.kheightBox,
                      Text(
                        "No sweat—every mental rep counts. One more round for that brain gain!",
                        style: TextStyleUtil.genSans400(
                          fontSize: 12.ksp,
                          color: context.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      12.kheightBox,
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.all(12.0.ksp),
                        child: CustomButton.outline(
                          onTap: () {
                            // Get.back();
                            Get.back();
                          },
                          title: "Retry Workout",
                        ),
                      ),
                      // .kheightBox,
                      InkWell(
                        onTap: () {
                          Get.back();
                          Get.back();
                        },
                        child: Text(
                          "Go Home",
                          style: TextStyleUtil.genSans600(
                            fontSize: 14.ksp,
                            color: context.brandColor1,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      30.kheightBox,
                    ])
                  : Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        80.kheightBox,
                        Center(
                          child: CommonImageView(
                              svgPath: ImageConstant.kamelionGifting),
                        ),
                        30.kheightBox,
                        Text(
                          LocaleKeys.quiz_complete.tr,
                          style: TextStyleUtil.genSans500(
                            fontSize: 24.ksp,
                            color: context.black,
                          ),
                        ),
                        0.kheightBox,
                        controller.coinsEarned.value == 0
                            ? Padding(
                                padding: EdgeInsets.only(top: 12.0.ksp),
                                child: Text(
                                  "You have already earned coins for this workout",
                                  style: TextStyleUtil.genSans400(
                                    fontSize: 12.ksp,
                                    color: context.black,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            : Text(
                                LocaleKeys.total_kalicoins.tr,
                                style: TextStyleUtil.genSans400(
                                  fontSize: 12.ksp,
                                  color: context.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                        12.kheightBox,
                        controller.coinsEarned.value == 0
                            ? Container()
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    controller.coinsEarned.toString(),
                                    style: TextStyleUtil.genSans500(
                                      fontSize: 20.ksp,
                                      color: context.black,
                                    ),
                                  ),
                                  4.kwidthBox,
                                  CommonImageView(
                                      svgPath: ImageConstant.coinStack),
                                ],
                              ),
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.all(12.0.ksp),
                          child: CustomButton.outline(
                            onTap: () {
                              if ((Get.find<WorkoutDetailsController>()
                                          .mentalGymDetails!
                                          .value
                                          .mentalGym!
                                          .userProgress ??
                                      0) ==
                                  100) {
                                Get.offNamed(Routes.COURSE_COMPLETE);
                              } else {
                                Get.back();
                                Get.back();
                              }
                            },
                            title: controller.coinsEarned.value == 0
                                ? "Done"
                                : LocaleKeys.collect_kalicoins.tr,
                          ),
                        ),
                        30.kheightBox,
                      ],
                    ),
            );
    });
  }
}
