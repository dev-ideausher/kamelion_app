import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kamelion/app/components/home_app_bar.dart';
import 'package:kamelion/app/modules/workoutDetails/views/video_player.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/responsive_size.dart';

import '../../../../generated/locales.g.dart';
import '../../../components/common_image_view.dart';
import '../../../components/community/community_card.dart';
import '../../../components/mentalGyms/active_workout_card.dart';
import '../../../components/mentalGyms/suggest_workout_card.dart';
import '../../../routes/app_pages.dart';
import '../../../services/text_style_util.dart';
import '../../mentalGym/controllers/mental_gym_controller.dart';
import '../controllers/home_search_controller.dart';

class HomeSearchView extends GetView<HomeSearchController> {
  const HomeSearchView({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: DefaultTabController(
          length: 4,
          child: Column(
            children: [
              // --- HEADER + SEARCH FIELD ---
              Container(
                decoration: BoxDecoration(
                  color: ColorUtil(context).brandColor1,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(20.ksp),
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 12.ksp),
                child: Column(
                  children: [
                    // back button + title
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: Get.back,
                          child: Container(
                            height: 25.ksp,
                            width: 25.ksp,
                            decoration: BoxDecoration(
                              color: context.lightBrandColor,
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 4.0.ksp),
                              child: Center(
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  size: 11.ksp,
                                  color: context.white,
                                ),
                              ),
                            ),
                          ),
                        ).paddingOnly(left: 8),
                        Spacer(),
                        Text(
                          'Search',
                          style: TextStyleUtil.genSans500(
                            fontSize: 18.ksp,
                          ),
                        ),
                        Spacer(flex: 2),
                      ],
                    ).paddingOnly(bottom: 8.ksp),
                    // search field
                    TextFormField(
                      focusNode: controller.focusNode,
                      onFieldSubmitted: (val) {
                        controller.getHomeSearch(searchQuery: val);
                      },
                      controller: controller.searchController,
                      decoration: InputDecoration(
                        hintText: LocaleKeys.search_for_anything.tr,
                        fillColor: Colors.white,
                        filled: true,
                        prefixIcon: Icon(Icons.search),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ).paddingSymmetric(horizontal: 16.ksp),
                  ],
                ),
              ),

              // --- TABS ---
              Obx(
                () => !controller.isSearched.value
                    ? Container(
                        child: Padding(
                          padding: EdgeInsets.all(8.0.ksp),
                          child: Text(
                            "Search a keyword to get data",
                            style: TextStyleUtil.genNunitoSans400(
                                fontSize: 14.ksp, color: context.black),
                          ),
                        ),
                      )
                    : TabBar(
                        labelColor: context.black,
                        unselectedLabelColor: Colors.grey,
                        // dividerColor: context.brandColor1,
                        // labelPadding: EdgeInsets.symmetric(horizontal: 0),
                        indicatorColor: context.brandColor1,
                        labelStyle:
                            TextStyleUtil.genNunitoSans400(fontSize: 8.ksp),
                        tabs: [
                          Tab(
                            text: 'Communities',
                          ),
                          Tab(text: 'Challenges'),
                          Tab(text: 'Mental Gyms'),
                          Tab(text: 'Workouts'),
                        ],
                      ),
              ),

              // --- TAB VIEWS ---
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return TabBarView(
                    children: [
                      // 1) Communities
                      controller.communities.isEmpty
                          ? Padding(
                              padding: EdgeInsets.all(8.0.ksp),
                              child: Text(
                                "No data found",
                                textAlign: TextAlign.center,
                                style: TextStyleUtil.genNunitoSans400(
                                    fontSize: 14.ksp, color: context.black),
                              ),
                            )
                          : ListView.builder(
                              padding: EdgeInsets.all(8),
                              itemCount: controller.communities.length,
                              itemBuilder: (_, i) {
                                final c = controller.communities[i];
                                return CommmunityCard(
                                  onTap: () {
                                    Get.toNamed(Routes.COMMUNITY_POSTS,
                                        arguments: c);
                                  },
                                  ownerName: 'test',
                                  peopleCount: c.numberOfMembers.toString(),
                                  title: c.name ?? "",
                                  postCount: c.numberofPosts.toString(),
                                  imageURL: c.profileImage!.url ?? "",
                                  userAvatarDetails: "",
                                );
                              },
                            ),

                      // 2) Challenges
                      controller.challenges.isEmpty
                          ? Padding(
                              padding: EdgeInsets.all(8.0.ksp),
                              child: Text(
                                "No data found",
                                textAlign: TextAlign.center,
                                style: TextStyleUtil.genNunitoSans400(
                                    fontSize: 14.ksp, color: context.black),
                              ),
                            )
                          : ListView.builder(
                              padding: EdgeInsets.all(8),
                              itemCount: controller.challenges.length,
                              itemBuilder: (_, i) {
                                final ch = controller.challenges[i];
                                return SuggestedWorkoutCards(
                                  isSaved: false,
                                  imageUrl: ch.image,
                                  subtitle: ch.challengeIntro ?? "",
                                  title: ch.challengeTitle,
                                  onTap: () {
                                    Get.toNamed(Routes.CHALLENGE_DETAILS,
                                        arguments: ch.id);
                                  },
                                );
                              },
                            ),

                      // 3) Mental Gyms

                      controller.mentalGyms.isEmpty
                          ? Padding(
                              padding: EdgeInsets.all(8.0.ksp),
                              child: Text(
                                "No data found",
                                textAlign: TextAlign.center,
                                style: TextStyleUtil.genNunitoSans400(
                                    fontSize: 14.ksp, color: context.black),
                              ),
                            )
                          : ListView.builder(
                              padding: EdgeInsets.all(8),
                              itemCount: controller.mentalGyms.length,
                              itemBuilder: (_, i) {
                                final mg = controller.mentalGyms[i];
                                return ActiveWorkoutCards(
                                  isSaved: true,
                                  title: mg.title ?? "",
                                  subtitle: mg.category!
                                          .map((c) => c.title)
                                          .join(', ') ??
                                      "",
                                  imageUrl: mg.thumbnail!.url ?? "",
                                  onTap: () {
                                    Get.toNamed(Routes.WORKOUT_DETAILS,
                                        arguments: mg.sId);
                                  },
                                );
                              },
                            ),

                      // 4) Workouts
                      controller.workouts.isEmpty
                          ? Padding(
                              padding: EdgeInsets.all(8.0.ksp),
                              child: Text(
                                "No data found",
                                textAlign: TextAlign.center,
                                style: TextStyleUtil.genNunitoSans400(
                                    fontSize: 14.ksp, color: context.black),
                              ),
                            )
                          : ListView.builder(
                              padding: EdgeInsets.all(8),
                              itemCount: controller.workouts.length,
                              itemBuilder: (_, i) {
                                final w = controller.workouts[i];
                                return InkWell(
                                  onTap: () async {
                                    Get.toNamed(Routes.WORKOUT_DETAILS,
                                        arguments: w.mentalGymId);
                                    // if (!(
                                    //   .mentalGymDetails!
                                    //                 .value.mentalGym!.isJoined ??
                                    //             false)) {
                                    //           await controller.joinMentalGym(
                                    //               controller.mentalGymDetails!
                                    //                       .value.mentalGym!.sId ??
                                    //                   "");
                                    //         }
                                    // Get.to(VideoPlayerScreen(), arguments: {
                                    //   // "https://kamelion.s3.eu-north-1.amazonaws.com/public/profilePics/27889d38-928d-4ebe-805f-b93023e50bd4-Mental%20Health%20in%20Schools_%20We%E2%80%99re%20Doing%20it%20Wrong%20_%20Maya%20Dawson%20_%20TEDxYouth_CherryCreek.mp4",
                                    //   'videoUrl': w. .video!.url ?? "",
                                    //   'workoutId': workout.sId,
                                    // });
                                  },
                                  child: Card(
                                    elevation: 4,
                                    shadowColor: Colors.grey.withOpacity(0.2),
                                    shape: RoundedRectangleBorder(
                                      side:
                                          BorderSide(color: context.greyBorder),
                                      borderRadius:
                                          BorderRadius.circular(4.ksp),
                                    ),
                                    color: ColorUtil(context).white,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(8.0.ksp),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(4.ksp),
                                            ),
                                            child: CommonImageView(
                                              url: w.thumbnail?.url,
                                              // svgPath: ImageConstant.dummyCoverImage,
                                              height: 90.ksp,
                                              width: 100.w,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 8.0.ksp,
                                                  ),
                                                  child: Text(
                                                    w.title ?? "",
                                                    style: TextStyleUtil
                                                        .genSans400(
                                                      fontSize: 12.ksp,
                                                      color: ColorUtil(context)
                                                          .black,
                                                      height: 1.2,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 8.0.ksp,
                                                    vertical: 2.ksp,
                                                  ),
                                                  child: Text(
                                                    w.description ?? "",
                                                    style: TextStyleUtil
                                                        .genSans400(
                                                      fontSize: 10.ksp,
                                                      color: ColorUtil(context)
                                                          .greyDark,
                                                      height: 1.2,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            // InkWell(
                                            //   child: Icon(
                                            //     Icons.bookmark_outline,
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                        0.kheightBox,
                                        Row(
                                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            10.kwidthBox,
                                            Text(
                                              LocaleKeys.earn_kalikoins.tr,
                                              style: TextStyleUtil.genSans500(
                                                fontSize: 10.ksp,
                                                color: ColorUtil(context)
                                                    .brandColor1,
                                                // fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            50.kwidthBox,
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 8.ksp,
                                                vertical: 2.ksp,
                                              ),
                                              decoration: BoxDecoration(
                                                color: ColorUtil(context)
                                                    .lighPitchBg,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20.ksp),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(
                                                    Icons.trending_up,
                                                    size: 12.ksp,
                                                    color: ColorUtil(context)
                                                        .darkRedText,
                                                  ),
                                                  5.kwidthBox,
                                                  Text(
                                                    LocaleKeys.trending.tr,
                                                    style: TextStyleUtil
                                                        .genSans500(
                                                      fontSize: 10.ksp,
                                                      color: ColorUtil(context)
                                                          .darkRedText,
                                                      // fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        10.kheightBox,
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                    ],
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
