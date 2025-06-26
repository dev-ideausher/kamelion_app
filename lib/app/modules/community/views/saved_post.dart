import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';
import 'package:kamelion/app/components/community/post_card.dart';
import 'package:kamelion/app/modules/community/controllers/community_controller.dart';
import 'package:kamelion/app/modules/home/controllers/home_controller.dart';

class SavedPost extends StatelessWidget {
  SavedPost({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(
        () => Column(
          children: [
            ...Get.find<CommunityController>().savedPost
                .map(
                  (post) => SavedPostCard(
                    isFromSaved: true,
                    userAvatarDetails: post.userId!.avatardetails ?? "",
                    communityId: "",
                    isMine:
                        post.userId?.sId ==
                        Get.find<HomeController>().currentUser.value.sId,
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
          ],
        ),
      ),
    );
  }
}
