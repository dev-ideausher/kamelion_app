import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kamelion/app/components/community/community_app_bar.dart';
import 'package:kamelion/app/modules/home/controllers/home_controller.dart';
import 'package:kamelion/app/modules/mentalGym/controllers/mental_gym_controller.dart';
import 'package:kamelion/app/routes/app_pages.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';
import 'package:kamelion/generated/locales.g.dart';

import '../controllers/community_controller.dart';

class CommunityView extends GetView<CommunityController> {
  CommunityView({super.key});
  final CommunityController controller = Get.put(CommunityController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CommunityController>(
      builder: (controller) {
        return controller.isLoading.value
            ? Center(
                child: CircularProgressIndicator(color: context.brandColor1),
              )
            : Scaffold(
                backgroundColor: context.scaffoldBg,
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    Get.toNamed(Routes.CREATE_COMMUNITY)?.then((result) async {
                      if (result == true) {
                        await controller.getYourCommunities();
                        await controller.getTrendingCommunities();
                        await controller.getSavedCommunities();
                        await controller.getAllCommunities();
                      }
                    });
                  },
                  shape: const CircleBorder(),
                  backgroundColor: context.brandColor1,
                  child: Icon(Icons.add, color: context.white),
                ),
                body: Column(
                  children: [
                    CommunityAppBar(
                      userName: Get.find<HomeController>()
                              .currentUser
                              .value
                              .nickname!
                              .capitalizeFirst ??
                          "",
                    ),
                    Obx(
                      () => Expanded(
                        child: RefreshIndicator(
                          onRefresh: () async {
                            await controller.getYourCommunities();
                            await controller.getTrendingCommunities();
                            await controller.getSavedCommunities();
                            await controller.getAllCommunities();
                          },
                          color: context.brandColor1,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                16.kheightBox,
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      15.kwidthBox,
                                      InkWell(
                                        onTap: () {
                                          controller.selectedScreenIndex.value =
                                              0;
                                        },
                                        child: _buildTag(
                                          "Communities",
                                          context,
                                          controller
                                                  .selectedScreenIndex.value ==
                                              0,
                                        ),
                                      ),
                                      12.kwidthBox,
                                      InkWell(
                                        onTap: () {
                                          controller.selectedScreenIndex.value =
                                              1;
                                          controller.viewAllList =
                                              controller.allCommunityList;
                                          controller.viewAllTitle.value =
                                              "All Communities";
                                        },
                                        child: _buildTag(
                                          "All Communities",
                                          context,
                                          controller
                                                  .selectedScreenIndex.value ==
                                              1,
                                        ),
                                      ),
                                      12.kwidthBox,
                                      InkWell(
                                        onTap: () {
                                          controller.selectedScreenIndex.value =
                                              2;
                                          controller.viewAllList =
                                              controller.yourCommunityList;
                                          controller.viewAllTitle.value =
                                              "Your Communities";
                                        },
                                        child: _buildTag(
                                          "Your Communities",
                                          context,
                                          controller
                                                  .selectedScreenIndex.value ==
                                              2,
                                        ),
                                      ),
                                      12.kwidthBox,
                                      InkWell(
                                        onTap: () {
                                          controller.selectedScreenIndex.value =
                                              3;
                                          controller.viewAllList =
                                              controller.trendingCommunityList;
                                          controller.viewAllTitle.value =
                                              "Trending Communities";
                                        },
                                        child: _buildTag(
                                          "Trending Communities",
                                          context,
                                          controller
                                                  .selectedScreenIndex.value ==
                                              3,
                                        ),
                                      ),
                                      12.kwidthBox,
                                      InkWell(
                                        onTap: () {
                                          controller.selectedScreenIndex.value =
                                              4;
                                          controller.viewAllList =
                                              controller.trendingCommunityList;
                                          controller.viewAllTitle.value =
                                              "Saved Post";
                                        },
                                        child: _buildTag(
                                          "Saved Post",
                                          context,
                                          controller
                                                  .selectedScreenIndex.value ==
                                              4,
                                        ),
                                      ),
                                      12.kwidthBox,
                                      for (int i = 0;
                                          i <
                                              Get.find<MentalGymController>()
                                                  .mentalGymCategoryList
                                                  .length;
                                          i++)
                                        Padding(
                                          padding:
                                              EdgeInsets.only(right: 10.ksp),
                                          child: InkWell(
                                            onTap: () {
                                              controller
                                                  .getCommunitiesByCategory(
                                                categoryName: Get.find<
                                                            MentalGymController>()
                                                        .mentalGymCategoryList[
                                                            i]
                                                        .title ??
                                                    "",
                                                id: Get.find<
                                                            MentalGymController>()
                                                        .mentalGymCategoryList[
                                                            i]
                                                        .sId ??
                                                    "",
                                                index: i + 5,
                                              );
                                            },
                                            child: _buildTag(
                                              Get.find<MentalGymController>()
                                                      .mentalGymCategoryList[i]
                                                      .title ??
                                                  "",
                                              context,
                                              controller.selectedScreenIndex
                                                      .value ==
                                                  i + 5,
                                            ),
                                          ),
                                        ),
                                      15.kwidthBox,
                                      // InkWell(
                                      //   onTap: () {
                                      //     controller.selectedScreenIndex.value = 2;
                                      //   },
                                      //   child: _buildTag(
                                      //     "Social Life",
                                      //     context,
                                      //     controller.selectedScreenIndex.value == 2,
                                      //   ),
                                      // ),
                                      // 15.kwidthBox,
                                    ],
                                  ),
                                ),
                                controller.selectedScreenIndex.value == 0
                                    ? controller.screensList[
                                        controller.selectedScreenIndex.value]
                                    : (controller.selectedScreenIndex.value ==
                                                1 ||
                                            controller.selectedScreenIndex
                                                    .value ==
                                                2 ||
                                            controller.selectedScreenIndex
                                                    .value ==
                                                3)
                                        ? controller.screensList[1]
                                        : controller.selectedScreenIndex
                                                    .value ==
                                                4
                                            ? controller.screensList[2]
                                            : controller.screensList[3],
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
      },
    );
  }
}

Widget _buildTag(String label, BuildContext context, bool isSelected) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.ksp, vertical: 3.ksp),
    decoration: BoxDecoration(
      color: !isSelected ? context.greyBg2 : context.brandColor1Light,
      borderRadius: BorderRadius.circular(20.ksp),
    ),
    child: Text(
      label,
      style: TextStyleUtil.genSans500(
        fontSize: 10.ksp,
        color: !isSelected ? context.lightBlack : context.brandColor1,
      ),
    ),
  );
}
