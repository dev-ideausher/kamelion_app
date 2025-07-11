import 'package:flutter/material.dart';
import 'package:fluttermoji/fluttermojiCircleAvatar.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:intl/intl.dart';
import 'package:kamelion/app/components/avatar.dart';
import 'package:kamelion/app/components/common_image_view.dart';
import 'package:kamelion/app/constants/image_constant.dart';
import 'package:kamelion/app/modules/community/controllers/community_controller.dart';
import 'package:kamelion/app/modules/home/controllers/home_controller.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/custom_textfield.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';
import 'package:kamelion/generated/locales.g.dart';

import '../../routes/app_pages.dart';

class CommunityAppBar extends StatelessWidget {
  final String userName;

  const CommunityAppBar({Key? key, required this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final date = DateFormat('EEE, MMM d yyyy').format(DateTime.now());
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
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
            /// First row: Date and Notification Icon
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  color: ColorUtil(context).white,
                  size: 15.ksp,
                ),
                4.kwidthBox,
                Text(
                  date,
                  style: TextStyleUtil.genSans500(
                    color: ColorUtil(context).white,
                    fontSize: 10.ksp,
                  ),
                ),
                Spacer(),
                Container(
                  // width: 25.ksp,
                  // height: 25.ksp,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent, // background color
                    border: Border.all(
                      color: ColorUtil(context).white, // border color
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(6.ksp),
                      child: Stack(
                        children: [
                          Icon(
                            Icons.notifications_none_outlined,
                            color: ColorUtil(context).white,
                            size: 22.ksp,
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 6.ksp),
                              child: Container(
                                padding: EdgeInsets.all(3.ksp),
                                decoration: BoxDecoration(
                                  color: ColorUtil(context).brandColor3,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  '3',
                                  style: TextStyle(
                                    color: ColorUtil(context).white,
                                    fontSize: 12,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            15.kheightBox,

            /// Second row: Profile + Hi + Name
            Row(
              children: [
                Avatar().showAvatar(
                  avatarDetails: Get.find<HomeController>()
                          .currentUser
                          .value
                          .avatardetails ??
                      '',
                  bgColor: context.blueBg,
                  context: context,
                  radius: 28.ksp,
                ),
                SizedBox(width: 12.ksp),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.hi.tr +
                          " " +
                          userName +
                          LocaleKeys.exclamation.tr,
                      style: TextStyleUtil.genSans500(
                        color: ColorUtil(context).white,
                        fontSize: 22.ksp,
                      ),
                    ),
                    Row(
                      children: [
                        CommonImageView(svgPath: ImageConstant.postIcon),
                        4.kwidthBox,
                        Text(
                          "${Get.find<HomeController>().currentUser.value.numberofPosts ?? 0} Total Posts",
                          style: TextStyleUtil.genSans400(
                            color: ColorUtil(context).white,
                            fontSize: 12.ksp,
                          ),
                        ),
                        20.kwidthBox,
                      ],
                    ),
                  ],
                ),
              ],
            ),

            16.kheightBox,

            TextFormField(
              // hintText: "Search for anything",
              // fillColor: ColorUtil(context).white,
              // filled: true,
              // prefixIcon: Icon(Icons.search, color: ColorUtil(context).black),
              controller: Get.find<CommunityController>().searchController,
              onFieldSubmitted: (search) {
                Get.toNamed(
                  Routes.SEARCH_COMMUNITY,
                  arguments:
                      Get.find<CommunityController>().searchController.text,
                );
                Get.find<CommunityController>().searchController.text = "";
              },
              decoration: InputDecoration(
                hintText: LocaleKeys.search_for_anything.tr,
                filled: true,
                fillColor: ColorUtil(context).white,
                prefixIcon: const Icon(Icons.search),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
