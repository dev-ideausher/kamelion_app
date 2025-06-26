import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:kamelion/app/components/community/community_card.dart';
import 'package:kamelion/app/components/mental_gym_selector.dart';
import 'package:kamelion/app/modules/community/controllers/community_controller.dart';
import 'package:kamelion/app/modules/home/controllers/home_controller.dart';
import 'package:kamelion/app/modules/mentalGym/controllers/mental_gym_controller.dart';
import 'package:kamelion/app/routes/app_pages.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';

class CommunityViewAll extends StatelessWidget {
  const CommunityViewAll({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () =>
          Get.find<CommunityController>().isLoading.value
              ? Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  60.kheightBox,
                  Center(
                    child: CircularProgressIndicator(
                      color: context.brandColor1,
                    ),
                  ),
                ],
              )
              : Column(
                children: [
                  30.kheightBox,
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10.0.ksp),
                        child: Text(
                          Get.find<CommunityController>().viewAllTitle.value ??
                              "",
                          style: TextStyleUtil.genSans400(
                            fontSize: 15.6.ksp,
                            color: ColorUtil(context).black,
                            height: 1.2,
                          ),
                        ),
                      ),
                    ],
                  ),
                  6.kheightBox,
                  ...Get.find<CommunityController>().viewAllList.map((mood) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.ksp,
                        vertical: 2.ksp,
                      ),
                      child: CommmunityCard(
                        userAvatarDetails: mood.userId?.avatardetails ?? "",
                        title: mood.name ?? "",
                        ownerName: mood.nickname ?? "",
                        peopleCount: mood.numberOfMembers.toString(),
                        postCount: mood.numberofPosts.toString(),
                        imageURL: mood.profileImage!.url ?? "",
                        onTap: () {
                          Get.find<CommunityController>()
                              .goToCommunityPostsPage(mood);
                        },
                      ),
                    );
                  }).toList(),
                ],
              ),
    );
  }
}
