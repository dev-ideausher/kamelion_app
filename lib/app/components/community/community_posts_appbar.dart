import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/components/avatar.dart';
import 'package:kamelion/app/components/common_image_view.dart';
import 'package:kamelion/app/constants/image_constant.dart';
import 'package:kamelion/app/modules/communityPosts/controllers/community_posts_controller.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';
import 'package:kamelion/generated/locales.g.dart';

class CommunityPostsAppBar extends StatelessWidget {
  CommunityPostsAppBar({
    super.key,
    required this.postCount,
    required this.memberCount,
    required this.ownweName,
    required this.title,
    required this.category,
    required this.categoryImage,
    required this.communityImage,
    required this.userAvatarDetails,
    // required this.isSaved,
  });
  String title,
      ownweName,
      postCount,
      memberCount,
      category,
      categoryImage,
      communityImage,
      userAvatarDetails;
  // bool isSaved;

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 15.ksp, vertical: 5.ksp),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.ksp),
          bottomRight: Radius.circular(20.ksp),
        ),
      ),
      child: Stack(
        children: [
          SafeArea(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.ksp),
                    bottomRight: Radius.circular(20.ksp),
                  ),
                  child: CommonImageView(url: communityImage),
                ),
                Container(
                  width: double.infinity,
                  color: Colors.black.withOpacity(
                    0.4,
                  ), // adjust opacity for light/dark shade
                ),
              ],
            ),
          ),
          SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15.ksp,
                vertical: 5.ksp,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          height: 25.ksp,
                          width: 25.ksp,
                          decoration: BoxDecoration(
                            // color: context.lightRedBg,
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
                      ),

                      // Save Button
                      PopupMenuButton<String>(
                        color: context.white,
                        icon: Icon(
                          Icons.more_vert,
                          color: context.white,
                        ), // The 3-dot icon
                        onSelected: (value) {
                          if (value == 'Mute') {
                            // Handle Edit
                          } else if (value == 'Leave') {
                            Get.find<CommunityPostsController>()
                                .leaveCommunityDialog(context);
                          }
                        },
                        itemBuilder: (BuildContext context) => [
                          PopupMenuItem(
                            value: 'Mute',
                            child: Row(
                              children: [
                                Icon(Icons.notifications_off_outlined),
                                10.kwidthBox,
                                Text('Mute Community'),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: 'Leave',
                            child: Row(
                              children: [
                                Icon(Icons.logout, color: context.redBg),
                                10.kwidthBox,
                                Text(
                                  'Leave Community',
                                  style: TextStyle(color: context.redBg),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    title,
                    style: TextStyleUtil.genSans500(
                      color: ColorUtil(context).white,
                      fontSize: 19.5.ksp,
                    ),
                  ),
                  12.kheightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Avatar().showAvatar(
                              avatarDetails: userAvatarDetails,
                              bgColor: context.blueBg,
                              context: context,
                              radius: 8.ksp,
                            ),
                            // CircleAvatar(
                            //   radius: 8.ksp, // size of the profile picture
                            //   backgroundImage: NetworkImage(
                            //     "https://thumbs.dreamstime.com/b/vector-illustration-avatar-dummy-logo-collection-image-icon-stock-isolated-object-set-symbol-web-137160339.jpg",
                            //     // "https://upload.wikimedia.org/wikipedia/commons/thumb/9/93/Kim_Jong-un_2024.jpg/250px-Kim_Jong-un_2024.jpg",
                            //   ), // or use FileImage/File
                            // ),
                            8.kwidthBox, // spacing between image and name
                            Text(
                              ownweName,
                              style: TextStyleUtil.genSans500(
                                fontSize: 10.ksp,
                                color: context.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      16.kwidthBox,
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.ksp,
                          vertical: 2.ksp,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: context.white),
                          borderRadius: BorderRadius.all(
                            Radius.circular(12.ksp),
                          ),
                        ),
                        child: Row(
                          children: [
                            CommonImageView(
                              url: categoryImage,
                              // svgPath: ImageConstant.dumbelWhiteIcon,
                              height: 11.ksp,
                            ),
                            8.kwidthBox,
                            Text(
                              category,
                              style: TextStyleUtil.genSans500(
                                fontSize: 10.ksp,
                                color: context.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  12.kheightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      8.kwidthBox,
                      InkWell(
                        onTap: () {
                          Get.find<CommunityPostsController>()
                              .showOrHideMenbers(val: false);
                        },
                        child: Row(
                          children: [
                            CommonImageView(
                              svgPath: ImageConstant.postChatIcon,
                              height: 12.ksp,
                            ),
                            8.kwidthBox,
                            Text(
                              "$postCount Posts",
                              style: TextStyleUtil.genSans500(
                                fontSize: 11.ksp,
                                color: context.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      20.kwidthBox,
                      InkWell(
                        onTap: () {
                          Get.find<CommunityPostsController>()
                              .showOrHideMenbers(val: true);
                        },
                        child: Row(
                          children: [
                            CommonImageView(
                              svgPath: ImageConstant.userGroupIcon,
                              height: 12.ksp,
                            ),
                            8.kwidthBox,
                            Text(
                              "$memberCount Members",
                              style: TextStyleUtil.genSans500(
                                fontSize: 11.ksp,
                                color: context.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  12.kheightBox,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
