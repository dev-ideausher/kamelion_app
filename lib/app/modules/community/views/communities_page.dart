import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/instance_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:kamelion/app/components/community/community_card.dart';
import 'package:kamelion/app/components/community/post_card.dart';
import 'package:kamelion/app/components/mental_gym_selector.dart';
import 'package:kamelion/app/constants/image_constant.dart';
import 'package:kamelion/app/models/mental_gym_category_model.dart';
import 'package:kamelion/app/modules/community/controllers/community_controller.dart';
import 'package:kamelion/app/modules/home/controllers/home_controller.dart';
import 'package:kamelion/app/modules/mentalGym/controllers/mental_gym_controller.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';
import 'package:kamelion/generated/locales.g.dart';

class CommunitiesPage extends StatelessWidget {
  CommunitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          30.kheightBox,
          MentalGymSelector(
            isMentalGym: false,
            title: LocaleKeys.categories.tr,
            showViewAll: false,
            mentalGymList:
                Get.find<MentalGymController>().mentalGymCategoryList,
          ),
          if (Get.find<CommunityController>().yourCommunityList.isNotEmpty)
            20.kheightBox,
          if (Get.find<CommunityController>().yourCommunityList.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10.0.ksp),
                  child: Text(
                    'Your Communities',
                    style: TextStyleUtil.genSans400(
                      fontSize: 15.6.ksp,
                      color: ColorUtil(context).black,
                      height: 1.2,
                    ),
                  ),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.find<CommunityController>()
                            .selectedScreenIndex
                            .value = 1;
                        Get.find<CommunityController>().viewAllList =
                            Get.find<CommunityController>().yourCommunityList;
                        Get.find<CommunityController>().viewAllTitle.value =
                            "Your Communities";
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
          if (Get.find<CommunityController>().yourCommunityList.isNotEmpty)
            10.kheightBox,
          if (Get.find<CommunityController>().yourCommunityList.isNotEmpty)
            SingleChildScrollView(
              controller: Get.find<CommunityController>().scrollController,
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (
                    int i = 0;
                    i <
                        Get.find<CommunityController>()
                            .yourCommunityList
                            .length;
                    i++
                  )
                    Padding(
                      padding: EdgeInsets.all(4.0.ksp),
                      child: CommmunityCard(
                        userAvatarDetails:
                            Get.find<CommunityController>()
                                .yourCommunityList[i]
                                .userId
                                ?.avatardetails ??
                            "",
                        review:
                            Get.find<CommunityController>()
                                        .yourCommunityList[i]
                                        .status ==
                                    "approved"
                                ? null
                                : Get.find<CommunityController>()
                                    .yourCommunityList[i]
                                    .status,
                        imageURL:
                            Get.find<CommunityController>()
                                .yourCommunityList[i]
                                .profileImage!
                                .url ??
                            "",
                        title:
                            Get.find<CommunityController>()
                                .yourCommunityList[i]
                                .name ??
                            "",
                        ownerName:
                            Get.find<HomeController>()
                                .currentUser
                                .value
                                .nickname ??
                            "",
                        peopleCount:
                            Get.find<CommunityController>()
                                .yourCommunityList[i]
                                .numberOfMembers
                                .toString(),
                        postCount:
                            Get.find<CommunityController>()
                                .yourCommunityList[i]
                                .numberofPosts
                                .toString(),
                        onTap: () {
                          // Get.find<CommunityController>().getYourCommunities();
                          if (Get.find<CommunityController>()
                                  .yourCommunityList[i]
                                  .status ==
                              "pending") {
                            Get.find<CommunityController>()
                                .showCommunityStatusPopup(
                                  id:
                                      Get.find<CommunityController>()
                                          .yourCommunityList[i]
                                          .sId ??
                                      "",
                                  status:
                                      Get.find<CommunityController>()
                                          .yourCommunityList[i]
                                          .status ??
                                      "",
                                  context: context,
                                  image: ImageConstant.highfivePicture,
                                  title: "Still Under Review!",
                                  desc:
                                      "Your request is still in the queue! We're picking out the coolest communities just for you, so hang tight! 🎉",
                                );
                          } else if (Get.find<CommunityController>()
                                  .yourCommunityList[i]
                                  .status ==
                              "rejected") {
                            Get.find<CommunityController>()
                                .showCommunityStatusPopup(
                                  id:
                                      Get.find<CommunityController>()
                                          .yourCommunityList[i]
                                          .sId ??
                                      "",
                                  status:
                                      Get.find<CommunityController>()
                                          .yourCommunityList[i]
                                          .status ??
                                      "",
                                  context: context,
                                  image: ImageConstant.highfivePicture,
                                  title: "Sorry, Not this time. ",
                                  desc:
                                      Get.find<CommunityController>()
                                          .yourCommunityList[i]
                                          .reason ??
                                      "",
                                );
                          } else if (!(Get.find<CommunityController>()
                                  .yourCommunityList[i]
                                  .hasOpened ??
                              true)) {
                            Get.find<CommunityController>()
                                .showCommunityStatusPopup(
                                  communitySelected:
                                      Get.find<CommunityController>()
                                          .yourCommunityList[i],
                                  id:
                                      Get.find<CommunityController>()
                                          .yourCommunityList[i]
                                          .sId ??
                                      "",
                                  status:
                                      Get.find<CommunityController>()
                                          .yourCommunityList[i]
                                          .status ??
                                      "",
                                  context: context,
                                  image: ImageConstant.highfivePicture,
                                  title: "Awesome, your request is all set!",
                                  desc:
                                      "Exciting news! Your community request has been approved. Enjoy! 🎉",
                                );
                          } else {
                            Get.find<CommunityController>()
                                .goToCommunityPostsPage(
                                  Get.find<CommunityController>()
                                      .yourCommunityList[i],
                                );
                          }
                        },
                      ),
                    ),
                ],
              ),
            ),
          20.kheightBox,
          if (Get.find<CommunityController>().savedPost.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10.0.ksp),
                  child: Text(
                    'Saved Posts',
                    style: TextStyleUtil.genSans400(
                      fontSize: 15.6.ksp,
                      color: ColorUtil(context).black,
                      height: 1.2,
                    ),
                  ),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.find<CommunityController>()
                            .selectedScreenIndex
                            .value = 3;
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
          if (Get.find<CommunityController>().savedPost.isNotEmpty)
            10.kheightBox,
          if (Get.find<CommunityController>().savedPost.isNotEmpty)
            SavedPostCard(
              isFromSaved: true,
              userAvatarDetails:
                  Get.find<CommunityController>()
                      .savedPost[0]
                      .userId!
                      .avatardetails ??
                  "",
              communityId: "",
              isMine:
                  Get.find<CommunityController>().savedPost[0].userId?.sId ==
                  Get.find<HomeController>().currentUser.value,
              isLiked:
                  Get.find<CommunityController>().savedPost[0].isLiked ?? false,
              postId: Get.find<CommunityController>().savedPost[0].sId ?? "",
              commentCount:
                  Get.find<CommunityController>().savedPost[0].commentCount
                      .toString() ??
                  "",
              likecount:
                  Get.find<CommunityController>().savedPost[0].likeCount
                      .toString() ??
                  "",
              date:
                  DateFormat(' MMM d yyyy').format(
                    DateTime.parse(
                      Get.find<CommunityController>().savedPost[0].createdAt ??
                          "",
                    ),
                  ) ??
                  "",
              name:
                  Get.find<CommunityController>().savedPost[0].userId?.nickname
                      .toString() ??
                  "",
              text:
                  Get.find<CommunityController>().savedPost[0].description
                      .toString() ??
                  "",
            ),
          if (Get.find<CommunityController>().savedPost.isNotEmpty)
            10.kheightBox,
          if (Get.find<CommunityController>().trendingCommunityList.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10.0.ksp),
                  child: Text(
                    'Trending Communities',
                    style: TextStyleUtil.genSans400(
                      fontSize: 15.6.ksp,
                      color: ColorUtil(context).black,
                      height: 1.2,
                    ),
                  ),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.find<CommunityController>()
                            .selectedScreenIndex
                            .value = 2;
                        Get.find<CommunityController>().viewAllList =
                            Get.find<CommunityController>()
                                .trendingCommunityList;
                        Get.find<CommunityController>().viewAllTitle.value =
                            "Trending Communities";
                        Get.find<CommunityController>().scrollController
                            .animateTo(
                              0.0,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
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
          if (Get.find<CommunityController>().trendingCommunityList.isNotEmpty)
            10.kheightBox,
          if (Get.find<CommunityController>().trendingCommunityList.isNotEmpty)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (
                    int i = 0;
                    i <
                        Get.find<CommunityController>()
                            .trendingCommunityList
                            .length;
                    i++
                  )
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.ksp),
                      child: CommmunityCard(
                        userAvatarDetails:
                            Get.find<CommunityController>()
                                .trendingCommunityList[i]
                                .userId
                                ?.avatardetails ??
                            "",
                        imageURL:
                            Get.find<CommunityController>()
                                .trendingCommunityList[i]
                                .profileImage!
                                .url ??
                            "",
                        title:
                            Get.find<CommunityController>()
                                .trendingCommunityList[i]
                                .name ??
                            "",
                        ownerName:
                            Get.find<CommunityController>()
                                .trendingCommunityList[i]
                                .nickname ??
                            "",
                        peopleCount:
                            Get.find<CommunityController>()
                                .trendingCommunityList[i]
                                .numberOfMembers
                                .toString(),
                        postCount:
                            Get.find<CommunityController>()
                                .trendingCommunityList[i]
                                .numberofPosts
                                .toString(),
                        onTap: () {
                          Get.find<CommunityController>()
                              .goToCommunityPostsPage(
                                Get.find<CommunityController>()
                                    .trendingCommunityList[i],
                              );
                        },
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
