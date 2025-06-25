import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/components/mentalGyms/active_workout_card.dart';
import 'package:kamelion/app/components/mentalGyms/suggest_workout_card.dart';
import 'package:kamelion/app/components/mental_gym_selector.dart';
import 'package:kamelion/app/components/workout_selector.dart';
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
    return Column(
      children: [
        20.kheightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 14.0.ksp),
              child: Text(
                "All Challenges",
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
                    Get.find<MentalGymController>().selectedScreenIndex.value =
                        1;
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
        ActiveWorkoutCards(
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
            Get.toNamed(Routes.CHALLENGE_DETAILS);
          },
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
                Text(
                  LocaleKeys.view_all.tr,
                  style: TextStyleUtil.genSans500(
                    fontSize: 11.ksp,
                    color: ColorUtil(context).brandColor1,
                    height: 1.2,
                  ),
                ),
                20.kwidthBox,
              ],
            ),
          ],
        ),
        SuggestedWorkoutCards(
          isSaved: false,
          imageUrl: "",
          subtitle: "",
          title: "",
          onTap: () {
            Get.find<MentalGymController>().getWorkoutDetails('');
          },
        ),
      ],
    );
  }
}
