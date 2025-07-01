import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kamelion/app/components/activities/activities_app_bar.dart';
import 'package:kamelion/app/components/common_image_view.dart';
import 'package:kamelion/app/constants/image_constant.dart';
import 'package:kamelion/app/modules/home/controllers/home_controller.dart';
import 'package:kamelion/app/routes/app_pages.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';
import 'package:kamelion/app/wave_button.dart';

import '../controllers/activities_controller.dart';

class ActivitiesView extends GetView<ActivitiesController> {
  const ActivitiesView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: Column(
              children: [
                ActivitiesAppBar(),
                Padding(
                  padding: EdgeInsets.all(12.0.ksp),
                  child: Column(
                    children: [
                      20.kheightBox,
                      _activitiesCard(
                        onTap: () {
                          // Get.find<HomeController>().showMoodPopup(context);
                          Get.toNamed(Routes.MOOD_TRACKER);
                        },
                        fireCount: Get.find<HomeController>()
                            .currentUser
                            .value
                            .moodStreakCount
                            .toString(),
                        fireIcon: ImageConstant.fireIconGreen,
                        imageIcon: ImageConstant.moodTrackerIcon,
                        title: "Mood Tracker",
                        subTitle: "Track your mood",
                        cardColor: context.brandColor5,
                        borderColor: context.brandBorderColor,
                        fireBg: context.lightGreenBg,
                      ),
                      10.kheightBox,
                      _activitiesCard(
                        onTap: () {
                          Get.toNamed(Routes.CHALLENGES);
                        },
                        fireCount: "0",
                        fireIcon: ImageConstant.fireIconRed,
                        imageIcon: ImageConstant.challengesIcon,
                        title: "Challenges",
                        subTitle: "Exciting challenges",
                        cardColor: context.lightRed2Bg,
                        borderColor: context.lighPinkBg,
                        fireBg: context.lightRed3Bg,
                      ),
                      10.kheightBox,
                      _activitiesCard(
                        onTap: () {
                          Get.toNamed(Routes.JOURNALING);
                        },
                        fireCount: "0",
                        fireIcon: ImageConstant.fireIconYellow,
                        imageIcon: ImageConstant.bookIconYellow,
                        title: "Journalling",
                        subTitle: "Note down every detail",
                        cardColor: context.normalMoodBg,
                        borderColor: context.lightYellow2Border,
                        fireBg: context.lightYellow2Bg,
                      ),
                      10.kheightBox,
                      _activitiesCard(
                        fireCount: "6",
                        fireIcon: ImageConstant.fireIconGreen,
                        imageIcon: ImageConstant.faceLeftIcon,
                        title: "Personality Quizzes",
                        subTitle: "Check your personality",
                        cardColor: context.lightOrangeBg,
                        borderColor: context.lighPinkBg,
                        fireBg: context.lightGreenBg,
                        isShowFire: false,
                      ),
                      40.kheightBox,
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: -70.ksp,
            left: (context.width / 2) - 60.ksp,
            child: WaveSemiCircleButton(
              icon: Icons.play_arrow,
              color: Colors.blue,
              onTap: () {
                Get.toNamed(Routes.SUPPORT);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _activitiesCard extends StatelessWidget {
  _activitiesCard({
    super.key,
    required this.fireCount,
    required this.fireIcon,
    required this.title,
    required this.subTitle,
    required this.imageIcon,
    required this.borderColor,
    required this.cardColor,
    required this.fireBg,
    this.isShowFire = true,
    this.onTap,
  });

  String imageIcon, fireIcon, title, fireCount, subTitle;
  Color borderColor, cardColor, fireBg;
  bool isShowFire = true;
  Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {},
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 14.ksp, vertical: 10.ksp),
        decoration: BoxDecoration(
          color: cardColor,
          border: Border.all(color: borderColor, width: 1.5.ksp),
          borderRadius: BorderRadius.circular(10.ksp), // Rounded corners
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CommonImageView(svgPath: imageIcon),
            15.kwidthBox,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: TextStyleUtil.genSans400(
                          fontSize: 16.ksp,
                          color: context.black,
                        ),
                      ),
                      isShowFire
                          ? Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 6.ksp,
                                vertical: 0.ksp,
                              ),
                              decoration: BoxDecoration(
                                color: fireBg,
                                border: Border.all(
                                  color: Colors.transparent,
                                  width: 1.5.ksp,
                                ),
                                borderRadius: BorderRadius.circular(
                                  10.ksp,
                                ), // Rounded corners
                              ),
                              child: Row(
                                children: [
                                  CommonImageView(svgPath: fireIcon),
                                  4.kwidthBox,
                                  Text(
                                    fireCount,
                                    style: TextStyleUtil.genSans300(
                                      fontSize: 10.ksp,
                                      color: context.black,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                    ],
                  ),
                  Text(
                    subTitle,
                    style: TextStyleUtil.genSans400(
                      fontSize: 10.ksp,
                      color: context.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
