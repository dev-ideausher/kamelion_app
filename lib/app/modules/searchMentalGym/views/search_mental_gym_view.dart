import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kamelion/app/components/mentalGyms/active_workout_card.dart';
import 'package:kamelion/app/components/mentalGyms/mental_gyms_appbar.dart';
import 'package:kamelion/app/modules/mentalGym/controllers/mental_gym_controller.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';
import 'package:kamelion/generated/locales.g.dart';

import '../controllers/search_mental_gym_controller.dart';

class SearchMentalGymView extends GetView<SearchMentalGymController> {
  const SearchMentalGymView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => controller.isLoading.value
            ? Center(
                child: CircularProgressIndicator(color: context.brandColor1),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 0,
                      ),
                      decoration: BoxDecoration(
                        color: ColorUtil(context).brandColor1,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      child: SafeArea(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    color: context.white,
                                    size: 16.ksp,
                                  ),
                                ),
                              ],
                            ),
                            10.kheightBox,
                            Row(
                              children: [
                                2.kwidthBox,
                                Text(
                                  LocaleKeys.mentalGyms.tr,
                                  style: TextStyleUtil.genSans500(
                                    color: ColorUtil(context).white,
                                    fontSize: 19.5.ksp,
                                  ),
                                ),
                              ],
                            ),
                            0.kheightBox,
                          ],
                        ),
                      ),
                    ),
                    20.kheightBox,
                    controller.searchedMentalGymList.isEmpty
                        ? Text(
                            "No Mental Gym Found",
                            style: TextStyleUtil.genSans400(
                              fontSize: 14.ksp,
                              color: context.black,
                            ),
                          )
                        : Container(),
                    ...controller.searchedMentalGymList.map((mood) {
                      return ActiveWorkoutCards(
                        isSaved: true,
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
              ),
      ),
    );
  }
}
