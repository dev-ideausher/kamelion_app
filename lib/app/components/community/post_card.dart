import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:kamelion/app/components/avatar.dart';
import 'package:kamelion/app/components/common_image_view.dart';
import 'package:kamelion/app/constants/image_constant.dart';
import 'package:kamelion/app/modules/commentBottomSheet/controllers/comment_bottom_sheet_controller.dart';
import 'package:kamelion/app/modules/commentBottomSheet/views/comment_bottom_sheet_view.dart';
import 'package:kamelion/app/modules/community/controllers/community_controller.dart';
import 'package:kamelion/app/modules/communityPosts/controllers/community_posts_controller.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';

class SavedPostCard extends StatelessWidget {
  SavedPostCard({
    super.key,
    required this.date,
    required this.name,
    required this.text,
    required this.likecount,
    required this.commentCount,
    required this.postId,
    required this.isLiked,
    required this.isMine,
    required this.communityId,
    required this.userAvatarDetails,
    required this.isFromSaved,
  });
  String userAvatarDetails,
      postId,
      text,
      name,
      date,
      likecount,
      commentCount,
      communityId;
  bool isLiked, isMine, isFromSaved;

  @override
  Widget build(BuildContext context) {
    final spans = <TextSpan>[];
    final regex = RegExp(r"(#[\w\d_]+)");
    final matches = regex.allMatches(text);
    int currentIndex = 0;
    for (final match in matches) {
      // Add normal text before hashtag
      if (match.start > currentIndex) {
        spans.add(
          TextSpan(
            text: text.substring(currentIndex, match.start),
            style: TextStyle(color: context.black),
          ),
        );
      }

      final hashtag = match.group(0)!;

      // Add hashtag with recognizer
      spans.add(
        TextSpan(
          text: hashtag,
          style: TextStyle(color: context.brandColor1),
          recognizer:
              TapGestureRecognizer()
                ..onTap = () {
                  // if (onTapHashtag != null) {
                  //   onTapHashtag!(hashtag);
                  // }
                },
        ),
      );

      currentIndex = match.end;
    }

    // Add any remaining text
    if (currentIndex < text.length) {
      spans.add(
        TextSpan(
          text: text.substring(currentIndex),
          style: TextStyle(color: context.black),
        ),
      );
    }
    return Card(
      color: ColorUtil(context).white,
      margin: EdgeInsets.symmetric(horizontal: 14.ksp, vertical: 8.ksp),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.ksp),
      ),
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(12.ksp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row: avatar, name, date, more icon
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Avatar().showAvatar(
                  avatarDetails: userAvatarDetails,
                  bgColor: context.blueBg,
                  context: context,
                  radius: 20.ksp,
                ),
                10.kwidthBox,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyleUtil.genSans500(
                          fontSize: 14.ksp,
                          color: context.black,
                        ),
                      ),
                      2.kheightBox,
                      Text(
                        date,
                        style: TextStyleUtil.genSans400(
                          fontSize: 10.ksp,
                          color: context.greyDark,
                        ),
                      ),
                    ],
                  ),
                ),
                PopupMenuButton<String>(
                  color: context.white,
                  icon: Icon(Icons.more_vert), // The 3-dot icon
                  onSelected: (value) {
                    if (value == 'Report') {
                      Get.put(CommunityPostsController());
                      Get.find<CommunityPostsController>().reportPostDialog(
                        context: context,
                        postId: postId,
                      );
                    } else if (value == 'delete') {
                      Get.find<CommunityPostsController>().deletePostDialog(
                        context: context,
                        postId: postId,
                      );
                    } else if (value == 'Save') {
                      Get.find<CommunityPostsController>().savePost(
                        postId: postId,
                      );
                    } else if (value == 'edit') {
                      Get.find<CommunityPostsController>().goEditPost(
                        postId: postId,
                        postContent: text,
                      );
                    }
                  },
                  itemBuilder:
                      (BuildContext context) =>
                          isMine
                              ? [
                                PopupMenuItem(
                                  value: 'edit',
                                  child: Row(
                                    children: [
                                      Icon(Icons.edit_outlined),
                                      10.kwidthBox,
                                      Text('Edit Post'),
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                  value: 'delete',
                                  child: Row(
                                    children: [
                                      Icon(Icons.delete_outline),
                                      10.kwidthBox,
                                      Text('Delete Post'),
                                    ],
                                  ),
                                ),
                              ]
                              : [
                                PopupMenuItem(
                                  value: 'Save',
                                  child: Row(
                                    children: [
                                      Icon(Icons.download_outlined),
                                      10.kwidthBox,
                                      Text('Save Post'),
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                  value: 'Report',
                                  child: Row(
                                    children: [
                                      Icon(Icons.flag_outlined),
                                      10.kwidthBox,
                                      Text('Report Post'),
                                    ],
                                  ),
                                ),
                              ],
                ),
              ],
            ),
            10.kheightBox,

            // Post content
            RichText(text: TextSpan(children: spans)),

            14.kheightBox,
            // Like and Comment Row
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    isFromSaved
                        ? Get.find<CommunityController>().addLikeonSaved(
                          id: postId,
                        )
                        : Get.find<CommunityPostsController>().addLike(
                          id: postId,
                        );
                  },
                  child: Icon(
                    isLiked ? Icons.favorite : Icons.favorite_border,
                    color: context.redBg,
                  ),
                ),
                4.kwidthBox,
                Text(likecount),
                14.kwidthBox,
                GestureDetector(
                  onTap: () async {
                    // Get.find<CommentBottomSheetController>().postId = postId;
                    final commentController =
                        Get.isRegistered<CommentBottomSheetController>()
                            ? Get.find<CommentBottomSheetController>()
                            : Get.put(CommentBottomSheetController());
                    // commentController.postId = postId;
                    await commentController.getComments(id: postId);
                    // Get.find<CommentBottomSheetController>().postId = postId;
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16.ksp),
                        ),
                      ),
                      builder: (_) => CommentBottomSheetView(),
                    ).then((s) {
                      if (communityId != "")
                        Get.find<CommunityPostsController>()
                            .getCommunityDetails(communityId);
                    });
                  },
                  child: CommonImageView(svgPath: ImageConstant.commentIcon),
                ),
                4.kwidthBox,
                Text(commentCount),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
