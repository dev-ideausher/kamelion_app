import 'package:flutter/material.dart';
import 'package:fluttermoji/fluttermojiCircleAvatar.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/components/avatar.dart';
import 'package:kamelion/app/components/common_image_view.dart';
import 'package:kamelion/app/constants/image_constant.dart';
import 'package:kamelion/app/models/leadeboard_user_model.dart';
import 'package:kamelion/app/routes/app_pages.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';
import 'package:kamelion/generated/locales.g.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  ProfileView({super.key});
  final controller = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('ProfileView'), centerTitle: true),
      body: GetBuilder<ProfileController>(builder: (controller) {
        return controller.isLoading.value
            ? Center(
                child: CircularProgressIndicator(color: context.brandColor1),
              )
            : Column(
                children: [
                  ProfileAppBar(
                    tabController: controller.profilePageTabController,
                    title1: LocaleKeys.leaderboard.tr,
                    title2: LocaleKeys.rewards.tr,
                    backgroundColor: ColorUtil(context).shadowColor,
                    selectedTabColor: ColorUtil(context).white,
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: controller.profilePageTabController,
                      children: [
                        Container(
                          height: context.height * 0.6,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                30.kheightBox,
                                CustomTabBar(
                                  backgroundColor:
                                      ColorUtil(context).brandColor5,
                                  selectedTabColor:
                                      ColorUtil(context).brandColor1,
                                  tabController:
                                      controller.leaderboardTabController,
                                  title1: LocaleKeys.leaderboard.tr,
                                  title2: LocaleKeys.my_stats.tr,
                                  labelColor: ColorUtil(context).white,
                                  unselectedLabelColor:
                                      ColorUtil(context).brandColor1,
                                  height: MediaQuery.of(context).size.height *
                                      0.045,
                                  width:
                                      MediaQuery.of(context).size.width * 0.65,
                                ),
                                Container(
                                  height: context.height * 0.7,
                                  child: TabBarView(
                                    controller:
                                        controller.leaderboardTabController,
                                    children: [
                                      SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            30.kheightBox,
                                            Row(
                                              children: [
                                                16.kwidthBox,
                                                Text(
                                                  LocaleKeys.leaderboard.tr,
                                                  style:
                                                      TextStyleUtil.genSans500(
                                                    fontSize: 14.5.ksp,
                                                    color: ColorUtil(context)
                                                        .black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            25.kheightBox,
                                            LeaderboardRow(),
                                            20.kheightBox,
                                            LeaderList(controller: controller),
                                            50.kheightBox,
                                          ],
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          20.kheightBox,
                                          Row(
                                            children: [
                                              16.kwidthBox,
                                              Text(
                                                LocaleKeys.my_stats.tr,
                                                style: TextStyleUtil.genSans400(
                                                  fontSize: 14.5.ksp,
                                                  color:
                                                      ColorUtil(context).black,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            height: context.height * 0.6,
                                            child: GridView.builder(
                                              padding: EdgeInsets.all(12.ksp),
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount:
                                                    2, // Number of columns
                                                crossAxisSpacing: 12.ksp,
                                                mainAxisSpacing: 12.ksp,
                                                childAspectRatio:
                                                    1.6, // Adjust if needed
                                              ),
                                              itemCount: 4, // Your image list
                                              itemBuilder: (context, index) {
                                                return StateCard(
                                                  color: [
                                                    ColorUtil(context)
                                                        .greenCardBg,
                                                    ColorUtil(context)
                                                        .brandColor3,
                                                    ColorUtil(context).redBg,
                                                    ColorUtil(context).pitcgBg,
                                                  ][index],
                                                  icon: controller
                                                      .statesIcon[index],
                                                  value: controller
                                                      .statesValue[index],
                                                  count: (context == 0
                                                          ? controller
                                                              .myStatesData
                                                              .value
                                                              .totalCompletedQuizzes
                                                          : index == 1
                                                              ? controller
                                                                  .myStatesData
                                                                  .value
                                                                  .totalCompletedQuizzes
                                                              : index == 2
                                                                  ? controller
                                                                      .myStatesData
                                                                      .value
                                                                      .totalCompletedQuizzes
                                                                  : controller
                                                                      .myStatesData
                                                                      .value
                                                                      .totalCompletedQuizzes)
                                                      .toString(),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              10.kheightBox,
                              Row(
                                children: [
                                  16.kwidthBox,
                                  Text(
                                    LocaleKeys.rewards.tr,
                                    style: TextStyleUtil.genSans500(
                                      fontSize: 14.5.ksp,
                                      color: ColorUtil(context).black,
                                    ),
                                  ),
                                ],
                              ),
                              10.kheightBox,
                              Container(
                                height: context.height * 0.35,
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(vertical: 10.0.ksp),
                                  child: Wrap(
                                    spacing: 11.ksp,
                                    runSpacing: 11.ksp,
                                    children: [
                                      ImageConstant.rewardCard1,
                                      ImageConstant.rewardCard2,
                                      // ImageConstant.rewardCard3,
                                      // ImageConstant.rewardCard4,
                                    ].map((imageUrl) {
                                      return ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: CommonImageView(
                                          imagePath: imageUrl,
                                          height: 100.ksp,
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),

                              // 10.kheightBox,
                              // Row(
                              //   children: [
                              //     16.kwidthBox,
                              //     Text(
                              //       LocaleKeys.other_benefits.tr,
                              //       style: TextStyleUtil.genSans500(
                              //         fontSize: 14.5.ksp,
                              //         color: ColorUtil(context).black,
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              // 10.kheightBox,
                              // Container(
                              //   height: context.height * 0.5,
                              //   child: SingleChildScrollView(
                              //     child: Padding(
                              //       padding: EdgeInsets.symmetric(vertical: 10.0.ksp),
                              //       child: Wrap(
                              //         spacing: 11.ksp,
                              //         runSpacing: 11.ksp,
                              //         children:
                              //             [
                              //               ImageConstant.rewardCard5,
                              //               ImageConstant.rewardCard6,
                              //               ImageConstant.rewardCard7,
                              //               ImageConstant.rewardCard8,
                              //             ].map((imageUrl) {
                              //               return ClipRRect(
                              //                 borderRadius: BorderRadius.circular(12),
                              //                 child: CommonImageView(
                              //                   imagePath: imageUrl,
                              //                   height: 100.ksp,
                              //                 ),
                              //               );
                              //             }).toList(),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
      }),
    );
  }
}

class ProfileAppBar extends StatelessWidget {
  ProfileAppBar({
    super.key,
    required this.tabController,
    required this.backgroundColor,
    required this.selectedTabColor,
    required this.title1,
    required this.title2,
  });
  TabController tabController;
  String title1, title2;
  Color selectedTabColor, backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height * 0.275, // 30% of screen height
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorUtil(context).brandColor3, // Change to your brand color
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.ksp),
          bottomRight: Radius.circular(20.ksp),
        ),
        boxShadow: [
          BoxShadow(
            color: ColorUtil(context).black.withOpacity(0.1),
            blurRadius: 10.ksp,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      padding: EdgeInsets.only(left: 20.ksp, right: 20.ksp),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            10.kheightBox,
            Row(
              children: [
                Spacer(),
                InkWell(
                  onTap: () {
                    Get.toNamed(Routes.SETTINGS);
                  },
                  child: CircleAvatar(
                    backgroundColor: ColorUtil(context).brandColor4,
                    child: CommonImageView(svgPath: ImageConstant.settingIcon),
                  ),
                ),
              ],
            ),
            10.kheightBox,
            Text(
              "Leaderboards",
              style: TextStyleUtil.genSans500(fontSize: 18.ksp),
            ),
            10.kheightBox,
            CustomTabBar(
              backgroundColor: backgroundColor,
              selectedTabColor: selectedTabColor,
              tabController: tabController,
              title1: title1,
              title2: title2,
              labelColor: ColorUtil(context).shadowColor,
              unselectedLabelColor: ColorUtil(context).white,
              height: MediaQuery.of(context).size.height * 0.055,
              width: MediaQuery.of(context).size.width * 0.9,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTabBar extends StatelessWidget {
  CustomTabBar({
    super.key,
    required this.tabController,
    required this.backgroundColor,
    required this.selectedTabColor,
    required this.title1,
    required this.title2,
    required this.labelColor,
    required this.unselectedLabelColor,
    required this.height,
    required this.width,
  });
  TabController tabController;
  String title1, title2;
  double height, width;
  Color selectedTabColor, backgroundColor, unselectedLabelColor, labelColor;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(24.ksp), // Rounded corners
        ),
        child: TabBar(
          controller: tabController,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(16.ksp),
            color: selectedTabColor,
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          padding: EdgeInsets.all(3.ksp),
          labelColor: labelColor,
          unselectedLabelColor: unselectedLabelColor,
          dividerHeight: 0,
          indicatorWeight: 0,
          labelPadding: EdgeInsets.all(0),
          tabs: [Tab(text: title1), Tab(text: title2)],
        ),
      ),
    );
  }
}

class LeaderboardRow extends StatelessWidget {
  const LeaderboardRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Avatar().showAvatar(
              avatarDetails: Get.find<ProfileController>()
                      .leaderBoardList[1]
                      .user!
                      .avatardetails ??
                  "",
              bgColor: ColorUtil(context).blueBg,
              radius: 26.ksp,
            ),
            // FluttermojiCircleAvatar(
            //   backgroundColor: ColorUtil(context).blueBg,
            //   radius: 26.ksp,
            // ),
            CommonImageView(svgPath: ImageConstant.silverMedal),
          ],
        ),
        22.kwidthBox,
        Transform.translate(
          offset: Offset(0, -17), // move upwards by 10 pixels
          child: Column(
            children: [
              Avatar().showAvatar(
                avatarDetails: Get.find<ProfileController>()
                        .leaderBoardList[0]
                        .user!
                        .avatardetails ??
                    "",
                bgColor: ColorUtil(context).blueBg,
                radius: 35.ksp,
              ),
              // FluttermojiCircleAvatar(
              //   backgroundColor: ColorUtil(context).blueBg,
              //   radius: 35.ksp,
              // ),
              CommonImageView(svgPath: ImageConstant.goldMedal),
            ],
          ),
        ),
        22.kwidthBox,
        Column(
          children: [
            Avatar().showAvatar(
              avatarDetails: Get.find<ProfileController>()
                      .leaderBoardList[2]
                      .user!
                      .avatardetails ??
                  "",
              bgColor: ColorUtil(context).blueBg,
              radius: 26.ksp,
            ),
            // FluttermojiCircleAvatar(
            //   backgroundColor: ColorUtil(context).blueBg,
            //   radius: 26.ksp,
            // ),
            CommonImageView(svgPath: ImageConstant.bronzeModel),
          ],
        ),
      ],
    );
  }
}

class LeaderList extends StatelessWidget {
  LeaderList({super.key, required this.controller});
  var controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.ksp),
      padding: EdgeInsets.all(6.ksp),
      decoration: BoxDecoration(
        color: ColorUtil(context).brandColor5,
        borderRadius: BorderRadius.circular(8.ksp),
        border: Border.all(color: ColorUtil(context).brandBorderColor),
      ),
      child: Column(
        children: [
          ...controller.leaderBoardList.asMap().entries.map((entry) {
            int index = entry.key;
            LeaderBoardUserModel value = entry.value;
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        index == 0
                            ? CommonImageView(
                                svgPath: ImageConstant.goldMedal,
                                height: 15.ksp,
                              )
                            : index == 1
                                ? CommonImageView(
                                    svgPath: ImageConstant.silverMedal,
                                    height: 15.ksp,
                                  )
                                : index == 2
                                    ? CommonImageView(
                                        svgPath: ImageConstant.bronzeModel,
                                        height: 15.ksp,
                                      )
                                    : Text(index.toString()),
                        16.kwidthBox,
                        Avatar().showAvatar(
                          avatarDetails: value.user?.avatardetails ?? "",
                          bgColor: ColorUtil(context).blueBg,
                          radius: 14.ksp,
                        ),
                        // FluttermojiCircleAvatar(
                        //   backgroundColor: ColorUtil(context).blueBg,
                        //   radius: 14.ksp,
                        // ),
                        16.kwidthBox,
                        Text(
                          value.user?.nickname ?? "",
                          style: TextStyleUtil.genSans400(
                            fontSize: 12.ksp,
                            color: ColorUtil(context).black,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '${value.totalXP} xp',
                      style: TextStyleUtil.genSans500(
                        fontSize: 10.ksp,
                        color: ColorUtil(context).black,
                      ),
                    ),
                  ],
                ),
                ((controller.leaderboardList.length - 1) != index)
                    ? Divider(color: ColorUtil(context).brandBorderColor)
                    : Container(),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }
}

class StateCard extends StatelessWidget {
  StateCard({
    super.key,
    required this.count,
    required this.icon,
    required this.value,
    required this.color,
  });

  String icon, count, value;
  Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.ksp),
        color: color,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          20.kheightBox,
          Row(
            children: [
              15.kwidthBox,
              CommonImageView(svgPath: icon),
              10.kwidthBox,
              Text(count, style: TextStyleUtil.genSans600(fontSize: 25.ksp)),
            ],
          ),
          Row(
            children: [
              15.kwidthBox,
              Text(value, style: TextStyleUtil.genSans600(fontSize: 12.ksp)),
            ],
          ),
        ],
      ),
    );
  }
}
