import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kamelion/app/components/activities/challenge_details_app_bar.dart';
import 'package:kamelion/app/components/workoutDetails/workout_details_appbar.dart';
import 'package:kamelion/app/routes/app_pages.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/custom_button.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';

import '../controllers/challenge_details_controller.dart';

class ChallengeDetailsView extends GetView<ChallengeDetailsController> {
  const ChallengeDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: context.scaffoldBg,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: controller.isLoading.value == true
            ? Container()
            : Container(
                // height: 80.ksp,
                decoration: BoxDecoration(color: context.white),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // if (controller.challengeDetails != null)
                    // controller.challengeDetails!.value
                    false
                        ? Flexible(
                            child: Padding(
                              padding: EdgeInsets.all(16.0.ksp),
                              child: CustomButton.outline(
                                onTap: () {
                                  controller.quiteChallenge();
                                },
                                title: 'Quit Challenge',
                                color: context.redBg,
                                buttonColor: context.redBg,
                              ),
                            ),
                          )
                        : Flexible(
                            child: Padding(
                              padding: EdgeInsets.all(16.0.ksp),
                              child: CustomButton.outline(
                                onTap: () {
                                  controller.challengeDetails!.value.isActive!
                                      ? controller.completeChallenge()
                                      : controller.startChallenge();
                                },
                                title:
                                    controller.challengeDetails!.value.isActive!
                                        ? 'Mark Challenge Done'
                                        : 'Start Challenge',
                                color: context.redBg,
                                buttonColor: context.redBg,
                              ),
                            ),
                          ),
                    // 2.kheightBox,
                    controller.challengeDetails!.value.isActive!
                        ? Flexible(
                            child: InkWell(
                              onTap: () {
                                controller.quiteChallenge();
                              },
                              child: Text(
                                "Quit Challenge",
                                style: TextStyleUtil.genSans600(
                                  fontSize: 14.ksp,
                                  color: context.redBg,
                                ),
                              ),
                            ),
                          )
                        : Container(),
                    10.kheightBox
                  ],
                ),
              ),
        body: GetBuilder<ChallengeDetailsController>(builder: (controller) {
          return controller.isLoading.value
              ? Container(
                  margin: EdgeInsets.only(top: 14.ksp),
                  child: Center(
                    child:
                        CircularProgressIndicator(color: context.brandColor1),
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      ChallengeDetailsAppBar(
                        isSaved: (controller.challengeDetails?.value.isSaved ??
                                false)
                            .obs,
                        title:
                            controller.challengeDetails?.value.challengeTitle ??
                                "",
                        days: controller.challengeDetails?.value.totalDuration
                                .toString() ??
                            "",
                      ),
                      15.kheightBox,
                      Row(
                        children: [
                          18.kwidthBox,
                          Text(
                            "Introduction",
                            style: TextStyleUtil.genSans500(
                              fontSize: 14.ksp,
                              color: context.black,
                            ),
                          ),
                        ],
                      ),
                      12.kheightBox,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 14.ksp),
                        child: Text(
                          controller.challengeDetails?.value.challengeIntro ??
                              "",
                          // "Building friendships is an essential part of the human experience. It involves creating bonds with others that can enrich our lives, provide support, and foster a sense of belonging. Whether through shared interests, experiences, or simply spending time together, the journey of forming friendships can lead to lasting connections that bring joy and fulfillment.",
                          style: TextStyleUtil.genSans400(
                            fontSize: 12.ksp,
                            color: ColorUtil(context).black,
                          ),
                        ),
                      ),
                      // 16.kheightBox,
                      // Row(
                      //   children: [
                      //     18.kwidthBox,
                      //     Text(
                      //       "What to do",
                      //       style: TextStyleUtil.genSans500(
                      //         fontSize: 14.ksp,
                      //         color: context.black,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // 12.kheightBox,
                      // Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 14.ksp),
                      //   child: Text(
                      //     "Capture a thought each day, or aim for 50 characters!",
                      //     style: TextStyleUtil.genSans400(
                      //       fontSize: 12.ksp,
                      //       color: ColorUtil(context).black,
                      //     ),
                      //   ),
                      // ),
                      // 16.kheightBox,
                      // Row(
                      //   children: [
                      //     18.kwidthBox,
                      //     Text(
                      //       "Why it matters",
                      //       style: TextStyleUtil.genSans500(
                      //         fontSize: 14.ksp,
                      //         color: context.black,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // 12.kheightBox,
                      // Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 14.ksp),
                      //   child: Text(
                      //     "Building friendships is an essential part of the human experience. It involves creating bonds with others that can enrich our lives, provide support, and foster a sense of belonging. Whether through shared interests, experiences, or simply spending time together, the journey of forming friendships can lead to lasting connections that bring joy and fulfillment.",
                      //     style: TextStyleUtil.genSans400(
                      //       fontSize: 12.ksp,
                      //       color: ColorUtil(context).black,
                      //     ),
                      //   ),
                      // ),

                      // 16.kheightBox,
                    ],
                  ),
                );
        }),
      ),
    );
  }
}
