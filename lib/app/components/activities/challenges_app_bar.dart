import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/components/common_image_view.dart';
import 'package:kamelion/app/constants/image_constant.dart';
import 'package:kamelion/app/modules/challenges/controllers/challenges_controller.dart';
import 'package:kamelion/app/modules/profile/views/profile_view.dart';
import 'package:kamelion/app/routes/app_pages.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart' show TextStyleUtil;

class ChallengesAppBar extends StatelessWidget {
  ChallengesAppBar({
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
      // height: context.height * 0.275, // 30% of screen height
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorUtil(context).brandColor1, // Change to your brand color
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    if (Get.find<ChallengesController>()
                            .selectedScreenIndex
                            .value !=
                        0) {
                      Get.find<ChallengesController>()
                          .selectedScreenIndex
                          .value = 0;
                    } else {
                      Get.back();
                    }
                  },
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
                ),
              ],
            ),
            10.kheightBox,
            Text(
              "Challenges",
              style: TextStyleUtil.genSans500(fontSize: 18.ksp),
            ),
            10.kheightBox,
            CustomTabBar(
              backgroundColor: backgroundColor,
              selectedTabColor: selectedTabColor,
              tabController: tabController,
              title1: title1,
              title2: title2,
              labelColor: ColorUtil(context).lightBrand3Color,
              unselectedLabelColor: ColorUtil(context).white,
              height: MediaQuery.of(context).size.height * 0.055,
              width: MediaQuery.of(context).size.width * 0.9,
            ),
            20.kheightBox
          ],
        ),
      ),
    );
  }
}
