import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/components/mentalGyms/active_workout_card.dart';
import 'package:kamelion/app/components/mentalGyms/suggest_workout_card.dart';
import 'package:kamelion/app/components/mental_gym_selector.dart';
import 'package:kamelion/app/components/workout_selector.dart';
import 'package:kamelion/app/modules/challengeDetails/controllers/challenge_details_controller.dart';
import 'package:kamelion/app/modules/challenges/controllers/challenges_controller.dart';
import 'package:kamelion/app/modules/home/controllers/home_controller.dart';
import 'package:kamelion/app/modules/mentalGym/controllers/mental_gym_controller.dart';
import 'package:kamelion/app/routes/app_pages.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';
import 'package:kamelion/generated/locales.g.dart';

class ActiveChallenges extends StatelessWidget {
  const ActiveChallenges({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChallengesController>(builder: (controller) {
      return controller.isLoading.value
          ? Container(
              child: Center(
                child: CircularProgressIndicator(color: context.brandColor1),
              ),
            )
          : Column(
              children: [
                20.kheightBox,
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
                  ],
                ),
                ...Get.find<ChallengesController>()
                    .activeChallenges
                    .map((mood) {
                  return ActiveWorkoutCards(
                    progress: mood.userProgress ?? 0,
                    onsaved: () async {
                      bool res = await controller.saveChallenge(
                          challangeId: mood.sId ?? "");
                      if (res) {
                        mood.isSaved = !mood.isSaved!;

                        Get.find<ChallengesController>()
                            .activeChallenges
                            .refresh();
                      }
                      controller.getActiveChallenges();
                    },
                    isSaved: mood.isSaved ?? false,
                    title: mood.challengeTitle ?? "",
                    subtitle: mood.challengeIntro ?? "",
                    imageUrl: mood.image ?? "",
                    onTap: () {
                      Get.toNamed(Routes.CHALLENGE_DETAILS,
                          arguments: mood.sId);
                    },
                  );
                }).toList(),
              ],
            );
    });
  }
}
