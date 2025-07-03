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

class CompletedChallenges extends StatelessWidget {
  const CompletedChallenges({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          20.kheightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 14.0.ksp),
                child: Text(
                  Get.find<ChallengesController>().viewAllTitle.value,
                  style: TextStyleUtil.genSans400(
                    fontSize: 16.ksp,
                    color: ColorUtil(context).black,
                    height: 1.2,
                  ),
                ),
              ),
            ],
          ),
          ...Get.find<ChallengesController>().viewAllList.map((mood) {
            // print(Get.find<ChallengesController>().viewAllList[0].sId);
            return ActiveWorkoutCards(
              progress: mood.userProgress ?? 0,
              onsaved: () async {
                bool res = await Get.find<ChallengesController>()
                    .saveChallenge(challangeId: mood.sId ?? "");
                if (res) {
                  mood.isSaved = !(mood.isSaved ?? false);

                  Get.find<ChallengesController>().viewAllList.refresh();
                }
                Get.find<ChallengesController>().getActiveChallenges();
                Get.find<ChallengesController>().getSuggestedChallenges();
                Get.find<ChallengesController>().getCompletedChallenges();
                Get.find<ChallengesController>().getSavedChallenges();
              },
              isSaved: mood.isSaved ?? false,
              title: mood.challengeTitle ?? "",
              subtitle: mood.challengeIntro ?? "",
              imageUrl: mood.image ?? "",
              onTap: () {
                Get.toNamed(Routes.CHALLENGE_DETAILS, arguments: mood.sId);
              },
            );
          }).toList(),
        ],
      ),
    );
  }
}
