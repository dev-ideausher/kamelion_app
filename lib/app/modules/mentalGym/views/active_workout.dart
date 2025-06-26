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

class ActiveWorkouts extends StatelessWidget {
  const ActiveWorkouts({super.key});
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
                  Get.find<MentalGymController>().viewAllTitle.value,
                  style: TextStyleUtil.genSans400(
                    fontSize: 16.ksp,
                    color: ColorUtil(context).black,
                    height: 1.2,
                  ),
                ),
              ),
            ],
          ),
          ...Get.find<MentalGymController>().viewAllMentalGymList.map((mood) {
            return ActiveWorkoutCards(
              isSaved: mood.isSaved ?? false,
              onsaved: () async {
                bool res = await Get.find<MentalGymController>().saveMentalGym(
                  mentalGymId: mood.sId ?? "",
                );
                if (res) {
                  final controller = Get.find<MentalGymController>();
                  final index = controller.viewAllMentalGymList.indexOf(mood);
                  final updated = mood.copyWith(
                    isSaved: !(mood.isSaved ?? false),
                  );
                  controller.viewAllMentalGymList[index] = updated;
                  controller.viewAllMentalGymList.refresh();
                }
              },
              title: mood.title ?? "",
              subtitle: mood.title ?? "",
              imageUrl: mood.thumbnail!.url ?? "",
              onTap: () {
                Get.find<MentalGymController>().getWorkoutDetails(
                  mood.sId ?? "",
                );
              },
            );
          }).toList(),
        ],
      ),
    );
  }
}
