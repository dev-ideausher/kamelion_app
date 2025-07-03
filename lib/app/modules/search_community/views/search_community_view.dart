import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kamelion/app/components/community/community_card.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/responsive_size.dart';

import '../../../../generated/locales.g.dart';
import '../../../services/text_style_util.dart';
import '../../community/controllers/community_controller.dart';
import '../controllers/search_community_controller.dart';

class SearchCommunityView extends GetView<SearchCommunityController> {
  const SearchCommunityView({super.key});
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
                                  LocaleKeys.community.tr,
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
                    controller.searchedCommunityList.isEmpty
                        ? Text(
                            "No Community Found",
                            style: TextStyleUtil.genSans400(
                              fontSize: 14.ksp,
                              color: context.black,
                            ),
                          )
                        : Container(),
                    ...controller.searchedCommunityList.map((community) {
                      return CommmunityCard(
                          ownerName: community.nickname??'',
                          peopleCount: community.numberOfMembers.toString(),
                          title: community.name??'',
                          postCount: community.numberofPosts.toString(),
                          imageURL: community.profileImage?.url??'',
                          userAvatarDetails: community.userId?.avatardetails??'',
                          onTap: () {
                        Get.find<CommunityController>()
                            .goToCommunityPostsPage(community);
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
