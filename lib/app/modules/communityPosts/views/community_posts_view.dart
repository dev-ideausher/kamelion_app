import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kamelion/app/components/avatar.dart';
import 'package:kamelion/app/components/center_float_button.dart';
import 'package:kamelion/app/components/community/community_posts_appbar.dart';
import 'package:kamelion/app/components/community/post_card.dart';
import 'package:kamelion/app/modules/home/controllers/home_controller.dart';
import 'package:kamelion/app/modules/navigationBar/controllers/navigation_bar_controller.dart';
import 'package:kamelion/app/routes/app_pages.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';
import '../controllers/community_posts_controller.dart';

class CommunityPostsView extends GetView<CommunityPostsController> {
  const CommunityPostsView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CommunityPostsController>(
      builder: (controller) {
        return controller.isLoading.value
            ? Container(
                color: context.white,
                child: Center(
                  child: CircularProgressIndicator(color: context.brandColor1),
                ),
              )
            : Scaffold(
                floatingActionButton: (controller
                            .communityDetails?.value.community?.isMember ??
                        false)
                    ? FloatingActionButton(
                        onPressed: () {
                          Get.toNamed(
                            Routes.CREATE_POST,
                            arguments: {
                              "isEdit": false,
                              "communitySelected": controller.communitySelected,
                            },
                          );
                        },
                        backgroundColor: context.brandColor1,
                        shape: const CircleBorder(),
                        child: Icon(
                          Icons.add,
                          size: 20.ksp,
                          color: context.white,
                        ),
                      )
                    : CenterFloatButton(
                        onTap: () {
                          controller.joinCommunity();
                        },
                        text: "Join Community",
                      ),
                floatingActionButtonLocation:
                    (controller.communityDetails?.value.community?.isMember ??
                            false)
                        ? FloatingActionButtonLocation.endFloat
                        : FloatingActionButtonLocation.centerFloat,
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      CommunityPostsAppBar(
                        isMember: (controller
                                .communityDetails?.value.community?.isMember ??
                            false),
                        userAvatarDetails: controller
                                .communitySelected?.userId!.avatardetails ??
                            "",
                        // isSaved:    controller.communitySelected?,
                        communityImage:
                            controller.communitySelected?.profileImage?.url ??
                                "",
                        title: controller.communitySelected?.name ?? "",
                        ownweName:
                            controller.communitySelected?.userId?.nickname ??
                                "",
                        memberCount: controller
                                .communitySelected?.numberOfMembers
                                .toString() ??
                            "",
                        postCount: controller.communitySelected?.numberofPosts
                                .toString() ??
                            "",
                        category: controller.communitySelected?.category?.title
                                .toString() ??
                            "",
                        categoryImage: controller
                                .communitySelected?.category?.image
                                .toString() ??
                            "",
                      ),
                      controller.showMembers.value
                          ? Padding(
                              padding: EdgeInsets.only(
                                  right: 20.ksp, left: 20.ksp, bottom: 12.ksp),
                              child: Row(
                                children: [
                                  Text(
                                    "Members",
                                    style: TextStyleUtil.genNunitoSans600(
                                        fontSize: 16.ksp, color: context.black),
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      controller.showMembers.value
                          ? MemberList(controller: controller)
                          : Container(),
                      controller.communityDetails!.value.community!.isMember!
                          ? Container()
                          : Padding(
                              padding: EdgeInsets.all(18.0.ksp),
                              child: Text(
                                "Please join the community to view the posts",
                                style: TextStyleUtil.genSans400(
                                  fontSize: 14.ksp,
                                  color: context.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                      controller.communityDetails!.value.community!.isMember! &&
                              controller
                                  .communityDetails!.value.posts!.isEmpty &&
                              controller.showMembers.value == false
                          ? Padding(
                              padding: EdgeInsets.all(18.0.ksp),
                              child: Text(
                                "No Post yet",
                                style: TextStyleUtil.genSans400(
                                  fontSize: 14.ksp,
                                  color: context.black,
                                ),
                              ),
                            )
                          : Container(),
                      if (controller.showMembers.value == false)
                        ...controller.communityDetails!.value.posts!
                            .map(
                              (post) => SavedPostCard(
                                isFromSaved: false,
                                userAvatarDetails:
                                    post.userId?.avatardetails ?? "",
                                communityId: controller.communityDetails?.value
                                        .community?.sId ??
                                    "",
                                isMine: post.userId?.sId ==
                                    Get.find<HomeController>()
                                        .currentUser
                                        .value
                                        .sId,
                                isLiked: post.isLiked ?? false,
                                date: DateFormat(
                                  ' MMM d yyyy',
                                ).format(DateTime.parse(post.createdAt ?? "")),
                                name: post.userId?.nickname ?? "",
                                text: post.description ?? "",
                                postId: post.sId ?? "",
                                commentCount: post.commentCount.toString(),
                                likecount: post.likeCount.toString(),

                                // "Everyday I thank god that I’m alive. Super Duper grateful for Doc F. #gratefulness #freudrocks",
                              ),
                            )
                            .toList(),
                      20.kheightBox,
                    ],
                  ),
                ),
              );
      },
    );
  }
}
