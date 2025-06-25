import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kamelion/app/components/common_image_view.dart';
import 'package:kamelion/app/constants/image_constant.dart';
import 'package:kamelion/app/modules/activities/views/activities_view.dart';
import 'package:kamelion/app/modules/community/views/community_view.dart';
import 'package:kamelion/app/modules/home/views/home_view.dart';
import 'package:kamelion/app/modules/mentalGym/views/mental_gym_view.dart';
// import 'package:kamelion/app/modules/mentalGyms/views/mental_gyms_view.dart';
import 'package:kamelion/app/modules/profile/views/profile_view.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';
import 'package:kamelion/generated/locales.g.dart';
import '../controllers/navigation_bar_controller.dart';

class NavigationBarView extends GetView<NavigationBarController> {
  const NavigationBarView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: IndexedStack(
          index: controller.selectedIndex.value,
          children: [
            HomeView(),
            MentalGymView(),
            ActivitiesView(),
            CommunityView(),
            ProfileView(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.selectedIndex.value,
          onTap: controller.changePage,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: TextStyleUtil.genSans400(
            fontSize: 8.ksp,
            color: ColorUtil(context).brandColor1,
          ),
          unselectedLabelStyle: TextStyleUtil.genSans400(
            fontSize: 8.ksp,
            color: ColorUtil(context).grey,
          ),
          selectedItemColor: ColorUtil(context).brandColor1,
          backgroundColor: ColorUtil(context).white,
          items: [
            BottomNavigationBarItem(
              icon: CommonImageView(
                svgPath:
                    controller.selectedIndex.value == 0
                        ? ImageConstant.homeSelected
                        : ImageConstant.homeUnselected,
              ),
              label: LocaleKeys.home.tr,
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 2.0.ksp),
                child: CommonImageView(
                  svgPath:
                      controller.selectedIndex.value == 1
                          ? ImageConstant.mentalGymSelected
                          : ImageConstant.mentalGymUnselected,
                ),
              ),
              label: LocaleKeys.mentalGyms.tr,
            ),
            BottomNavigationBarItem(
              icon: CommonImageView(
                svgPath:
                    controller.selectedIndex.value == 2
                        ? ImageConstant.activitySelected
                        : ImageConstant.activityUnselected,
              ),
              label: LocaleKeys.activities.tr,
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 3.ksp),
                child: CommonImageView(
                  svgPath:
                      controller.selectedIndex.value == 3
                          ? ImageConstant.communitySelected
                          : ImageConstant.communityUnselected,
                ),
              ),
              label: LocaleKeys.community.tr,
            ),
            BottomNavigationBarItem(
              icon: CommonImageView(
                svgPath:
                    controller.selectedIndex.value == 4
                        ? ImageConstant.profielSelected
                        : ImageConstant.profielUnselected,
              ),
              label: LocaleKeys.profile.tr,
            ),
          ],
        ),
      ),
    );
  }
}
