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

class AllWorkouts extends StatelessWidget {
  const AllWorkouts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        20.kheightBox,
        if (Get.find<MentalGymController>().activeMentalGymList.length > 0)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 14.0.ksp),
                child: Text(
                  'Active Mental Gyms',
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
                      Get.find<MentalGymController>().changeTab(1);
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
        if (Get.find<MentalGymController>().activeMentalGymList.length > 0)
          Obx(
            () => ActiveWorkoutCards(
              onsaved: () async {
                print(
                  Get.find<MentalGymController>()
                      .activeMentalGymList[0]
                      .isSaved,
                );
                bool res = await Get.find<MentalGymController>().saveMentalGym(
                  mentalGymId: Get.find<MentalGymController>()
                          .activeMentalGymList[0]
                          .sId ??
                      "",
                );
                if (res) {
                  Get.find<MentalGymController>()
                          .activeMentalGymList[0]
                          .isSaved =
                      !Get.find<MentalGymController>()
                          .activeMentalGymList[0]
                          .isSaved!;

                  Get.find<MentalGymController>().activeMentalGymList.refresh();
                }
              },
              isSaved: Get.find<MentalGymController>()
                      .activeMentalGymList[0]
                      .isSaved ??
                  false,
              title: Get.find<MentalGymController>()
                      .activeMentalGymList[0]
                      .title ??
                  "",
              subtitle: Get.find<MentalGymController>()
                      .activeMentalGymList[0]
                      .title ??
                  "",
              imageUrl: Get.find<MentalGymController>()
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
            ),
          ),
        10.kheightBox,
        MentalGymSelector(
          title: LocaleKeys.categories.tr,
          showViewAll: false,
          mentalGymList: Get.find<MentalGymController>().mentalGymCategoryList,
        ),
        20.kheightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 14.0.ksp),
              child: Text(
                "Suggested Mental Gym",
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
                    Get.find<MentalGymController>().changeTab(2);
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
        if (Get.find<MentalGymController>().suggestedMentalGym.length > 0)
          Obx(
            () => SuggestedWorkoutCards(
              isSaved: Get.find<MentalGymController>()
                      .suggestedMentalGym[0]
                      .isSaved ??
                  false,
              onSaved: () async {
                bool res = await Get.find<MentalGymController>().saveMentalGym(
                  mentalGymId: Get.find<MentalGymController>()
                          .suggestedMentalGym[0]
                          .sId ??
                      "",
                );
                if (res) {
                  Get.find<MentalGymController>()
                      .suggestedMentalGym[0]
                      .isSaved = !(Get.find<MentalGymController>()
                          .suggestedMentalGym[0]
                          .isSaved ??
                      false);
                  Get.find<MentalGymController>().suggestedMentalGym.refresh();
                }
              },
              imageUrl: Get.find<MentalGymController>()
                      .suggestedMentalGym[0]
                      .thumbnail!
                      .url ??
                  "",
              subtitle:
                  Get.find<MentalGymController>().suggestedMentalGym[0].title ??
                      "",
              title:
                  Get.find<MentalGymController>().suggestedMentalGym[0].title ??
                      "",
              onTap: () {
                Get.find<MentalGymController>().getWorkoutDetails(
                  Get.find<MentalGymController>().suggestedMentalGym[0].sId ??
                      "",
                );
              },
            ),
          ),
      ],
    );
  }
}
