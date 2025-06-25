import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/components/mentalGyms/active_workout_card.dart';
import 'package:kamelion/app/components/mentalGyms/suggest_workout_card.dart';
import 'package:kamelion/app/modules/mentalGym/controllers/mental_gym_controller.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';
import 'package:kamelion/generated/locales.g.dart';

class SavedWorkouts extends StatelessWidget {
  const SavedWorkouts({super.key});

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
                LocaleKeys.saved_workouts.tr,
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
          return SuggestedWorkoutCards(
            isSaved: false,
            imageUrl: "",
            title: "",
            subtitle: "",
            onTap: () {
              Get.find<MentalGymController>().getWorkoutDetails(mood.sid);
            },
          );
        }).toList(),
      ],
    );
  }
}
