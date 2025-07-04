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
          // Obx(
          //   () => SingleChildScrollView(
          //     scrollDirection: Axis.horizontal,
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.start,
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         ...Get.find<MentalGymController>()
          //             .activeMentalGymList
          //             .map((item) {
          //           return Padding(
          //             padding: EdgeInsets.symmetric(horizontal: 0.0.ksp),
          //             child: ActiveWorkoutCards(
          //               onsaved: () async {
          //                 print(
          //                   item.isSaved,
          //                 );
          //                 bool res = await Get.find<MentalGymController>()
          //                     .saveMentalGym(
          //                   mentalGymId: item.sId ?? "",
          //                 );
          //                 if (res) {
          //                   item.isSaved = !item.isSaved!;

          //                   Get.find<MentalGymController>()
          //                       .activeMentalGymList
          //                       .refresh();
          //                 }
          //               },
          //               isSaved: item.isSaved ?? false,
          //               title: item.title ?? "",
          //               subtitle: item.title ?? "",
          //               imageUrl: item.thumbnail!.url ?? "",
          //               onTap: () {
          //                 Get.find<MentalGymController>().getWorkoutDetails(
          //                   item.sId ?? "",
          //                 );
          //               },
          //             ),
          //           );
          //         }),
          //       ],
          //     ),
          //   ),
          // ),
          Obx(
            () => SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: Get.find<MentalGymController>()
                    .activeMentalGymList
                    .asMap()
                    .entries
                    .map((entry) {
                  int index = entry.key;
                  var item = entry.value;
                  return ActiveWorkoutCards(
                    progress: item.userProgress ?? 0,
                    onsaved: () async {
                      bool res =
                          await Get.find<MentalGymController>().saveMentalGym(
                        mentalGymId: item.sId ?? "",
                      );
                      if (res) {
                        item.isSaved = !item.isSaved!;

                        Get.find<MentalGymController>()
                            .activeMentalGymList
                            .refresh();
                      }
                    },
                    isSaved: item.isSaved ?? false,
                    title: item.title ?? "",
                    subtitle:
                        item.category!.map((c) => c.title).join(', ') ?? "",
                    imageUrl: item.thumbnail!.url ?? "",
                    onTap: () {
                      Get.find<MentalGymController>().getWorkoutDetails(
                        item.sId ?? "",
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          ),
        10.kheightBox,
        MentalGymSelector(
          title: LocaleKeys.categories.tr,
          showViewAll: false,
          mentalGymList: Get.find<MentalGymController>().mentalGymCategoryList,
        ),
        20.kheightBox,
        if (Get.find<MentalGymController>().suggestedMentalGym.length > 0)
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
          //   Obx(
          //     () => SingleChildScrollView(
          //       scrollDirection: Axis.horizontal,
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           ...Get.find<MentalGymController>()
          //               .suggestedMentalGym
          //               .map((item) {
          //             return Padding(
          //               padding: EdgeInsets.symmetric(horizontal: 0.0.ksp),
          //               child: SuggestedWorkoutCards(
          //                 isSaved: item.isSaved ?? false,
          //                 onSaved: () async {
          //                   bool res = await Get.find<MentalGymController>()
          //                       .saveMentalGym(
          //                     mentalGymId: item.sId ?? "",
          //                   );
          //                   if (res) {
          //                     item.isSaved = !item.isSaved!;
          //                     Get.find<MentalGymController>()
          //                         .suggestedMentalGym
          //                         .refresh();
          //                   }
          //                 },
          //                 imageUrl: item.thumbnail!.url ?? "",
          //                 subtitle: item.title ?? "",
          //                 title: item.title ?? "",
          //                 onTap: () {
          //                   Get.find<MentalGymController>().getWorkoutDetails(
          //                     item.sId ?? "",
          //                   );
          //                 },
          //               ),
          //             );
          //           }),
          //         ],
          //       ),
          //     ),
          //   ),
          Obx(
            () => SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: Get.find<MentalGymController>()
                      .suggestedMentalGym
                      .asMap()
                      .entries
                      .map((entry) {
                    int index = entry.key;
                    var item = entry.value;
                    return SuggestedWorkoutCards(
                      isSaved: item.isSaved ?? false,
                      onSaved: () async {
                        bool res =
                            await Get.find<MentalGymController>().saveMentalGym(
                          mentalGymId: item.sId ?? "",
                        );
                        if (res) {
                          item.isSaved = !(item.isSaved ?? false);
                          Get.find<MentalGymController>()
                              .suggestedMentalGym
                              .refresh();
                        }
                      },
                      imageUrl: item.thumbnail!.url ?? "",
                      subtitle:
                          item.category!.map((c) => c.title).join(', ') ?? "",
                      title: item.title ?? "",
                      onTap: () {
                        Get.find<MentalGymController>().getWorkoutDetails(
                          item.sId ?? "",
                        );
                      },
                    );
                  }).toList()),
            ),
          ),
        20.kheightBox,
        if (Get.find<HomeController>().popularMentalGyms.length > 0)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 14.0.ksp),
                child: Text(
                  "Popular Mental Gym",
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
                      Get.find<MentalGymController>().changeTab(3);
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
        if (Get.find<HomeController>().popularMentalGyms.length > 0)
          //   Obx(
          //     () => SingleChildScrollView(
          //       scrollDirection: Axis.horizontal,
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           ...Get.find<MentalGymController>()
          //               .suggestedMentalGym
          //               .map((item) {
          //             return Padding(
          //               padding: EdgeInsets.symmetric(horizontal: 0.0.ksp),
          //               child: SuggestedWorkoutCards(
          //                 isSaved: item.isSaved ?? false,
          //                 onSaved: () async {
          //                   bool res = await Get.find<MentalGymController>()
          //                       .saveMentalGym(
          //                     mentalGymId: item.sId ?? "",
          //                   );
          //                   if (res) {
          //                     item.isSaved = !item.isSaved!;
          //                     Get.find<MentalGymController>()
          //                         .suggestedMentalGym
          //                         .refresh();
          //                   }
          //                 },
          //                 imageUrl: item.thumbnail!.url ?? "",
          //                 subtitle: item.title ?? "",
          //                 title: item.title ?? "",
          //                 onTap: () {
          //                   Get.find<MentalGymController>().getWorkoutDetails(
          //                     item.sId ?? "",
          //                   );
          //                 },
          //               ),
          //             );
          //           }),
          //         ],
          //       ),
          //     ),
          //   ),
          Obx(
            () => SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: Get.find<HomeController>()
                      .popularMentalGyms
                      .asMap()
                      .entries
                      .map((entry) {
                    int index = entry.key;
                    var item = entry.value;
                    return SuggestedWorkoutCards(
                      isSaved: item.isSaved ?? false,
                      onSaved: () async {
                        bool res =
                            await Get.find<MentalGymController>().saveMentalGym(
                          mentalGymId: item.sId ?? "",
                        );
                        if (res) {
                          item.isSaved = !(item.isSaved ?? false);
                          Get.find<MentalGymController>()
                              .suggestedMentalGym
                              .refresh();
                        }
                      },
                      imageUrl: item.thumbnail!.url ?? "",
                      subtitle:
                          item.category!.map((c) => c.title).join(', ') ?? "",
                      title: item.title ?? "",
                      onTap: () {
                        Get.find<MentalGymController>().getWorkoutDetails(
                          item.sId ?? "",
                        );
                      },
                    );
                  }).toList()),
            ),
          ),
      ],
    );
  }
}
