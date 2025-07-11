import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kamelion/app/modules/challenges/controllers/challenges_controller.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';

class BadgesView extends StatelessWidget {
  const BadgesView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChallengesController>(builder: (controller) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0.ksp),
        child: controller.isLoading.value
            ? Scaffold(
                body: Padding(
                  padding: EdgeInsets.only(top: 20.0.ksp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(color: context.brandColor1),
                    ],
                  ),
                ),
              )
            : GridView.builder(
                itemCount: Get.find<ChallengesController>().badgesList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 items per row
                  crossAxisSpacing: 6.ksp,
                  mainAxisSpacing: 10.ksp,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Get.find<ChallengesController>().showBadgeDetails(
                        context: context,
                        badgeImage: Get.find<ChallengesController>()
                                .badgesList[index]
                                .badgeImage
                                ?.url ??
                            "",
                        title: Get.find<ChallengesController>()
                                .badgesList[index]
                                .name ??
                            "",
                        subTitle: Get.find<ChallengesController>()
                                .badgesList[index]
                                .description ??
                            "",
                        progress: Get.find<ChallengesController>()
                                .badgesList[index]
                                .progress ??
                            0,
                        totalValue: Get.find<ChallengesController>()
                                .badgesList[index]
                                .conditionValue ??
                            0,
                      );
                    },
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Get.find<ChallengesController>()
                                        .badgesList[index]
                                        .progress ==
                                    Get.find<ChallengesController>()
                                        .badgesList[index]
                                        .conditionValue
                                ? context.brandColor1Light
                                : context.greyLightBg,
                            border: Border.all(
                                color: Get.find<ChallengesController>()
                                            .badgesList[index]
                                            .progress ==
                                        Get.find<ChallengesController>()
                                            .badgesList[index]
                                            .conditionValue
                                    ? context.brandBorderColor
                                    : context.greyBorder),
                            borderRadius: BorderRadius.circular(
                                14.ksp), // Rounded corners
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3.0.ksp),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // 20.kheightBox,
                                ClipOval(
                                  child: Image.network(
                                    Get.find<ChallengesController>()
                                            .badgesList[index]
                                            .badgeImage
                                            ?.url ??
                                        "",
                                    // 'https://plus.unsplash.com/premium_photo-1714138490043-40cbd9d982dc?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8YmFkZ2V8ZW58MHx8MHx8fDA%3D',
                                    width: 65.ksp,
                                    height: 65.ksp,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                20.kheightBox,
                                Text(
                                  Get.find<ChallengesController>()
                                              .badgesList[index]
                                              .progress ==
                                          Get.find<ChallengesController>()
                                              .badgesList[index]
                                              .conditionValue
                                      ? (Get.find<ChallengesController>()
                                              .badgesList[index]
                                              .name ??
                                          "")
                                      : (Get.find<ChallengesController>()
                                              .badgesList[index]
                                              .description ??
                                          ""),
                                  style: TextStyleUtil.genSans600(
                                    fontSize: Get.find<ChallengesController>()
                                                .badgesList[index]
                                                .progress ==
                                            Get.find<ChallengesController>()
                                                .badgesList[index]
                                                .conditionValue
                                        ? 13.ksp
                                        : 10.ksp,
                                    color: context.black,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                6.kheightBox,
                                Get.find<ChallengesController>()
                                            .badgesList[index]
                                            .progress ==
                                        Get.find<ChallengesController>()
                                            .badgesList[index]
                                            .conditionValue
                                    ? Text(
                                        "Yay! You’ve earned it",
                                        style: TextStyleUtil.genSans400(
                                            fontSize: 10.ksp,
                                            color: context.black),
                                      )
                                    : Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.0.ksp),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: LinearProgressIndicator(
                                                minHeight: 5,
                                                backgroundColor:
                                                    Colors.grey[300],
                                                value: (Get.find<
                                                            ChallengesController>()
                                                        .badgesList[index]
                                                        .progress! /
                                                    Get.find<
                                                            ChallengesController>()
                                                        .badgesList[index]
                                                        .conditionValue!),
                                                color: context.brandColor1,
                                              ),
                                            ),
                                            10.kwidthBox,
                                            Text(
                                              "${Get.find<ChallengesController>().badgesList[index].progress!}/${Get.find<ChallengesController>().badgesList[index].conditionValue!}",
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
                        ),
                        Get.find<ChallengesController>()
                                    .badgesList[index]
                                    .progress ==
                                Get.find<ChallengesController>()
                                    .badgesList[index]
                                    .conditionValue
                            ? Container()
                            : Container(
                                decoration: BoxDecoration(
                                  color: context.greyLightBg.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(
                                      14.ksp), // Rounded corners
                                ),
                              ),
                      ],
                    ),
                  );
                },
              ),
      );
    });
  }
}
