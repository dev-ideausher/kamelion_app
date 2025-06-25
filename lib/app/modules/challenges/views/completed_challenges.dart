import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/components/mentalGyms/active_workout_card.dart';
import 'package:kamelion/app/components/mentalGyms/suggest_workout_card.dart';
import 'package:kamelion/app/components/mental_gym_selector.dart';
import 'package:kamelion/app/components/workout_selector.dart';
import 'package:kamelion/app/modules/home/controllers/home_controller.dart';
import 'package:kamelion/app/modules/mentalGym/controllers/mental_gym_controller.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';
import 'package:kamelion/generated/locales.g.dart';

class CompletedChallenges extends StatelessWidget {
  const CompletedChallenges({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        20.kheightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 14.0.ksp),
              child: Text(
                "Completed Challenges",
                style: TextStyleUtil.genSans400(
                  fontSize: 16.ksp,
                  color: ColorUtil(context).black,
                  height: 1.2,
                ),
              ),
            ),
          ],
        ),
        ...Get.find<MentalGymController>().activeWorkouts.map((mood) {
          return ActiveWorkoutCards(
            isSaved: true,
            title:
                Get.find<MentalGymController>().activeMentalGymList[0].title ??
                "",
            subtitle:
                Get.find<MentalGymController>().activeMentalGymList[0].title ??
                "",
            imageUrl:
                Get.find<MentalGymController>()
                    .activeMentalGymList[0]
                    .thumbnail!
                    .url ??
                "",
            onTap: () {
              Get.find<MentalGymController>().getWorkoutDetails(
                Get.find<MentalGymController>().activeMentalGymList[0].sId ??
                    "",
              );
            },
          );
        }).toList(),
      ],
    );
  }
}
