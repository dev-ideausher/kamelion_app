import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/components/mentalGyms/active_workout_card.dart';
import 'package:kamelion/app/components/mentalGyms/suggest_workout_card.dart';
import 'package:kamelion/app/components/mental_gym_selector.dart';
import 'package:kamelion/app/components/workout_selector.dart';
import 'package:kamelion/app/modules/challenges/controllers/challenges_controller.dart';
import 'package:kamelion/app/modules/home/controllers/home_controller.dart';
import 'package:kamelion/app/modules/mentalGym/controllers/mental_gym_controller.dart';
import 'package:kamelion/app/routes/app_pages.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';
import 'package:kamelion/generated/locales.g.dart';

class AllChallenges extends StatelessWidget {
  const AllChallenges({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChallengesController>(builder: (controller) {
      return controller.isLoading.value
          ? Container(
              child: Padding(
                padding: EdgeInsets.only(top: 20.0.ksp),
                child: Center(
                  child: CircularProgressIndicator(color: context.brandColor1),
                ),
              ),
            )
          : Column(
              children: [
                20.kheightBox,
                if (Get.find<ChallengesController>().activeChallenges.length >
                    0)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 14.0.ksp),
                        child: Text(
                          "Active Challenges",
                          style: TextStyleUtil.genSans400(
                            fontSize: 16.ksp,
                            color: ColorUtil(context).black,
                            height: 1.2,
                          ),
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          Get.find<ChallengesController>()
                              .selectedScreenIndex
                              .value = 1;
                        },
                        child: Text(
                          LocaleKeys.view_all.tr,
                          style: TextStyleUtil.genSans500(
                            fontSize: 11.ksp,
                            color: ColorUtil(context).brandColor1,
                            height: 1.2,
                          ),
                        ),
                      ),
                      20.kwidthBox,
                    ],
                  ),
                if (Get.find<ChallengesController>().activeChallenges.length >
                    0)
                  Obx(
                    () => ActiveWorkoutCards(
                      progress: Get.find<ChallengesController>()
                              .activeChallenges[0]
                              .userProgress ??
                          0,
                      onsaved: () async {
                        bool res = await controller.saveChallenge(
                            challangeId: Get.find<ChallengesController>()
                                    .activeChallenges[0]
                                    .sId ??
                                "");
                        if (res) {
                          Get.find<ChallengesController>()
                                  .activeChallenges[0]
                                  .isSaved =
                              !Get.find<ChallengesController>()
                                  .activeChallenges[0]
                                  .isSaved!;

                          Get.find<ChallengesController>()
                              .activeChallenges
                              .refresh();
                        }

                        controller.getActiveChallenges();
                      },
                      isSaved: Get.find<ChallengesController>()
                              .activeChallenges[0]
                              .isSaved ??
                          false,
                      title: Get.find<ChallengesController>()
                              .activeChallenges[0]
                              .challengeTitle ??
                          "",
                      subtitle: Get.find<ChallengesController>()
                              .activeChallenges[0]
                              .challengeIntro ??
                          "",
                      imageUrl: Get.find<ChallengesController>()
                              .activeChallenges[0]
                              .image ??
                          "",
                      onTap: () {
                        Get.toNamed(Routes.CHALLENGE_DETAILS,
                            arguments: Get.find<ChallengesController>()
                                .activeChallenges[0]
                                .sId);
                      },
                    ),
                  ),
                10.kheightBox,
                Padding(
                  padding: EdgeInsets.only(left: 14.0.ksp),
                  child: MentalGymSelector(
                    title: LocaleKeys.categories.tr,
                    showViewAll: false,
                    mentalGymList:
                        Get.find<MentalGymController>().mentalGymCategoryList,
                  ),
                ),
                20.kheightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 14.0.ksp),
                      child: Text(
                        "Suggested Challenges",
                        style: TextStyleUtil.genSans400(
                          fontSize: 16.ksp,
                          color: ColorUtil(context).black,
                          height: 1.2,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Get.find<ChallengesController>().viewAllList =
                                Get.find<ChallengesController>()
                                    .suggestedChallenges;
                            Get.find<ChallengesController>()
                                .viewAllTitle
                                .value = "Suggested Challenges";
                            Get.find<ChallengesController>()
                                .selectedScreenIndex
                                .value = 4;
                          },
                          child: Text(
                            LocaleKeys.view_all.tr,
                            style: TextStyleUtil.genSans500(
                              fontSize: 11.ksp,
                              color: ColorUtil(context).brandColor1,
                              height: 1.2,
                            ),
                          ),
                        ),
                        20.kwidthBox,
                      ],
                    ),
                  ],
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (int i = 0;
                          i <
                              Get.find<ChallengesController>()
                                  .suggestedChallenges
                                  .length;
                          i++)
                        SuggestedWorkoutCards(
                          onSaved: () async {
                            bool res = await controller.saveChallenge(
                                challangeId: Get.find<ChallengesController>()
                                        .suggestedChallenges[i]
                                        .sId ??
                                    "");
                            if (res) {
                              Get.find<ChallengesController>()
                                      .suggestedChallenges[i]
                                      .isSaved =
                                  !Get.find<ChallengesController>()
                                      .suggestedChallenges[i]
                                      .isSaved!;

                              Get.find<ChallengesController>()
                                  .suggestedChallenges
                                  .refresh();
                            }

                            controller.getActiveChallenges();
                          },
                          isSaved: Get.find<ChallengesController>()
                                  .suggestedChallenges[i]
                                  .isSaved ??
                              false,
                          imageUrl: Get.find<ChallengesController>()
                                  .suggestedChallenges[i]
                                  .image ??
                              "",
                          subtitle: Get.find<ChallengesController>()
                                  .suggestedChallenges[i]
                                  .challengeIntro ??
                              "",
                          title: Get.find<ChallengesController>()
                                  .suggestedChallenges[i]
                                  .challengeTitle ??
                              "",
                          onTap: () {
                            Get.toNamed(Routes.CHALLENGE_DETAILS,
                                arguments: Get.find<ChallengesController>()
                                    .suggestedChallenges[i]
                                    .sId);
                          },
                        ),
                    ],
                  ),
                ),
                40.kheightBox,
              ],
            );
    });
  }
}
