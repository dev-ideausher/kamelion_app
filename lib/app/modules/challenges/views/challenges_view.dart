import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kamelion/app/components/activities/challenges_app_bar.dart';
import 'package:kamelion/app/modules/challenges/views/badges_view.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';
import 'package:kamelion/generated/locales.g.dart';

import '../controllers/challenges_controller.dart';

class ChallengesView extends GetView<ChallengesController> {
  const ChallengesView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: Column(
          children: [
            ChallengesAppBar(
              tabController: controller.challengePageTabController,
              title1: "Challenges",
              title2: "Badges",
              backgroundColor: ColorUtil(context).lightBrand3Color,
              selectedTabColor: ColorUtil(context).lightBrand2Color,
            ),
            Expanded(
              child: TabBarView(
                controller: controller.challengePageTabController,
                children: [
                  Container(
                    height: context.height * 0.6,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          16.kheightBox,
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                15.kwidthBox,
                                InkWell(
                                  onTap: () {
                                    controller.selectedScreenIndex.value = 0;
                                  },
                                  child: _buildTag(
                                    "All Challenges",
                                    context,
                                    controller.selectedScreenIndex.value == 0,
                                  ),
                                ),
                                15.kwidthBox,
                                InkWell(
                                  onTap: () {
                                    controller.selectedScreenIndex.value = 1;
                                  },
                                  child: _buildTag(
                                    "Active Challenges",
                                    context,
                                    controller.selectedScreenIndex.value == 1,
                                  ),
                                ),
                                15.kwidthBox,
                                InkWell(
                                  onTap: () {
                                    controller.selectedScreenIndex.value = 2;
                                  },
                                  child: _buildTag(
                                    "Completed Challenges",
                                    context,
                                    controller.selectedScreenIndex.value == 2,
                                  ),
                                ),
                                15.kwidthBox,
                              ],
                            ),
                          ),
                          controller.screensList[controller
                              .selectedScreenIndex
                              .value],
                        ],
                      ),
                    ),
                  ),
                  BadgesView(),
                ],
              ),
            ),
            // Expanded(
            //   child: SingleChildScrollView(
            //     child: Column(
            //       children: [
            //         16.kheightBox,
            //         SingleChildScrollView(
            //           scrollDirection: Axis.horizontal,
            //           child: Row(
            //             // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //             children: [
            //               15.kwidthBox,
            //               InkWell(
            //                 onTap: () {
            //                   controller.selectedScreenIndex.value = 0;
            //                 },
            //                 child: _buildTag(
            //                   "All Challenges",
            //                   context,
            //                   controller.selectedScreenIndex.value == 0,
            //                 ),
            //               ),
            //               15.kwidthBox,
            //               InkWell(
            //                 onTap: () {
            //                   controller.selectedScreenIndex.value = 1;
            //                 },
            //                 child: _buildTag(
            //                   "Active Challenges",
            //                   context,
            //                   controller.selectedScreenIndex.value == 1,
            //                 ),
            //               ),
            //               15.kwidthBox,
            //               InkWell(
            //                 onTap: () {
            //                   controller.selectedScreenIndex.value = 2;
            //                 },
            //                 child: _buildTag(
            //                   "Completed Challenges",
            //                   context,
            //                   controller.selectedScreenIndex.value == 2,
            //                 ),
            //               ),
            //               15.kwidthBox,
            //             ],
            //           ),
            //         ),
            //         controller.screensList[controller
            //             .selectedScreenIndex
            //             .value],
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

Widget _buildTag(String label, BuildContext context, bool isSelected) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.ksp, vertical: 3.ksp),
    decoration: BoxDecoration(
      color: !isSelected ? context.greyBg2 : context.brandColor1Light,
      borderRadius: BorderRadius.circular(20.ksp),
    ),
    child: Text(
      label,
      style: TextStyleUtil.genSans500(
        fontSize: 10.ksp,
        color: !isSelected ? context.lightBlack : context.brandColor1,
      ),
    ),
  );
}
