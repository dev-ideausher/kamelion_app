import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kamelion/app/components/common_image_view.dart';
import 'package:kamelion/app/components/explore_communities_box.dart';
import 'package:kamelion/app/components/feelings_selection_widget.dart';
import 'package:kamelion/app/components/home_app_bar.dart';
import 'package:kamelion/app/components/mental_gym_selector.dart';
import 'package:kamelion/app/components/personal_insight_box.dart';
import 'package:kamelion/app/components/todays_mood.dart';
import 'package:kamelion/app/components/workout_selector.dart';
import 'package:kamelion/app/constants/image_constant.dart';
import 'package:kamelion/app/modules/mentalGym/controllers/mental_gym_controller.dart';

import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';
import 'package:kamelion/generated/locales.g.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: ColorUtil(context).scaffoldBg, // Notification bar color
        // statusBarIconBrightness: Brightness.light, // Icons: light or dark
      ),
    );
    return GetBuilder<HomeController>(
      builder: (controller) {
        return controller.isLoading.value
            ? Container(
                child: Center(
                  child: CircularProgressIndicator(color: context.brandColor1),
                ),
              )
            : Scaffold(
                backgroundColor: ColorUtil(context).scaffoldBg,
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        HomeAppBar(
                          streakCount: controller.currentUser.value.streakCount
                              .toString(),
                          coincount:
                              controller.currentUser.value.rewards.toString(),
                          userName:
                              (controller.currentUser.value.nickname ?? "User")
                                      .capitalizeFirst ??
                                  "User",
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20.kw, right: 20.kw),
                          child: Column(
                            children: [
                              20.kheightBox,
                              controller.currentMoodsList.isEmpty
                                  ? FeelingSelectionWidget(
                                      moodsToShow: controller.moodsToShow,
                                    )
                                  : Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 0.0.ksp),
                                              child: Text(
                                                LocaleKeys.todays_mood.tr,
                                                style: TextStyleUtil.genSans600(
                                                  fontSize: 20.kh,
                                                  color:
                                                      ColorUtil(context).black,
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                controller
                                                    .showMoodPopup(context);
                                              },
                                              child: Row(
                                                children: [
                                                  Text(
                                                    LocaleKeys.add.tr,
                                                    style: TextStyleUtil
                                                        .genNunitoSans700(
                                                      fontSize: 14.kh,
                                                      color: ColorUtil(context)
                                                          .brandColor1,
                                                      // height: 1.2,
                                                    ),
                                                  ),
                                                  4.kwidthBox,
                                                  CommonImageView(
                                                    svgPath:
                                                        ImageConstant.addIcon,
                                                    height: 16.kh,
                                                    width: 16.kh,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        16.kheightBox,
                                        ...controller.currentMoodsList
                                            .map(
                                              (element) => TodaysMood(
                                                feelings: element.feelings
                                                        ?.join(",") ??
                                                    "",
                                                activities:
                                                    element.activities ?? "",
                                                time: DateFormat.jm()
                                                    .format(DateTime.parse(
                                                            element.createdAt
                                                                as String)
                                                        .toLocal())
                                                    .toString(),
                                                desc: (element.note ?? "")
                                                        .capitalizeFirst ??
                                                    "",
                                                mood: (element.mood ?? "")
                                                        .capitalizeFirst ??
                                                    "",
                                                moodImage:
                                                    controller.getMoodImage(
                                                  mood: element.mood ?? "",
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      ],
                                    ),
                              20.kheightBox,
                              MentalGymSelector(
                                mentalGymList: Get.find<MentalGymController>()
                                    .mentalGymCategoryList,
                              ),
                              20.kheightBox,
                              WorkoutSelector(
                                  workoutList: controller.mentalGymList),
                              24.kheightBox,
                              PersonalInsightBox(),
                              24.kheightBox,
                              ExporleCommuntiesBox(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }
}
