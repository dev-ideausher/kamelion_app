import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kamelion/app/components/common_image_view.dart';
import 'package:kamelion/app/constants/image_constant.dart';
import 'package:kamelion/app/constants/link_constants.dart';
import 'package:kamelion/app/modules/challenges/controllers/challenges_controller.dart';
import 'package:kamelion/app/routes/app_pages.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';
import 'package:kamelion/generated/locales.g.dart';
import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SettingAppBar(
              title: LocaleKeys.settings.tr,
            ),
            20.kheightBox,
            SettingTab(
              title: LocaleKeys.profile.tr,
              subTitle1: LocaleKeys.edit_profile.tr,
              subTitle2: "License Details",
              ontap1: () {
                Get.toNamed(Routes.EDIT_PROFILE);
              },
              onTap2: () {},
            ),
            // 15.kheightBox,
            // SettingTab1(
            //   title: LocaleKeys.notifications.tr,
            //   subTitle1: "Push Notification",
            //   // subTitle2: LocaleKeys.reset_password.tr,
            //   ontap1: () {},
            //   // onTap2: () {},
            // ),
            15.kheightBox,
            SettingTab(
              title: "Rewards & Badges",
              subTitle1: "My Badges",
              subTitle2: "Redeemed Savings ",
              ontap1: () async {
                Get.toNamed(Routes.CHALLENGES);
                final challengeController =
                    Get.isRegistered<ChallengesController>()
                        ? Get.find<ChallengesController>()
                        : Get.put(ChallengesController());
                await Get.find<ChallengesController>().getBagdes();
                Get.find<ChallengesController>()
                    .challengePageTabController
                    .animateTo(1);
              },
              onTap2: () {},
            ),
            15.kheightBox,
            SettingTab4(
              title: "Help & Support",
              subTitle1: "FAQs",
              subTitle2: "Contact Us",
              subTitle3: "Terms of Service",
              subTitle4: "Privacy Policy",
              ontap1: () {
                Get.toNamed(Routes.FAQS);
              },
              onTap2: () {
                Get.toNamed(Routes.CONTACT_US);
              },
              ontap3: () {
                controller.openWebLink(
                  LinkConstants().termsAndConditionsKamelion,
                );
              },
              onTap4: () {
                controller.openWebLink(
                  LinkConstants().privacyPolicyKamelion,
                );
              },
            ),
            15.kheightBox,
            SettingTab(
              title: LocaleKeys.account.tr,
              subTitle1: "Delete Account",
              subTitle2: "Reset Password",
              ontap1: () {
                controller.showDeleteDialog(context);
              },
              onTap2: () {
                // controller.showLogoutDialog(context);
                Get.toNamed(Routes.RESET_PASSWORD);
              },
            ),
            15.kheightBox,
            InkWell(
              onTap: () {
                controller.showLogoutDialog(context);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0.ksp),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.0.ksp,
                    vertical: 8.ksp,
                  ),
                  decoration: BoxDecoration(
                    color: ColorUtil(context).white,
                    border: Border.all(color: ColorUtil(context).grey),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(6.ksp),
                      bottom: Radius.circular(6.ksp),
                    ), // Rounded corners
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Logout",
                        style: TextStyleUtil.genSans500(
                          fontSize: 11.ksp,
                          color: ColorUtil(context).black,
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios, size: 12.ksp),
                    ],
                  ),
                ),
              ),
            ),
            40.kheightBox,
          ],
        ),
      ),
    );
  }
}

class SettingAppBar extends StatelessWidget {
  SettingAppBar({super.key, required this.title});
  String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: context.height * 0.23, // 30% of screen height
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
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: CircleAvatar(
                        backgroundColor: ColorUtil(context).brandColor4,
                        child: Padding(
                          padding: EdgeInsets.only(left: 6.0.ksp),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: ColorUtil(context).white,
                            size: 15.ksp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                10.kheightBox,
                Text(
                  title,
                  style: TextStyleUtil.genSans500(fontSize: 20.ksp),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class SettingTab extends StatelessWidget {
  SettingTab({
    super.key,
    required this.title,
    required this.subTitle1,
    required this.subTitle2,
    required this.onTap2,
    required this.ontap1,
  });

  String title, subTitle1, subTitle2;
  Function ontap1, onTap2;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            20.kwidthBox,
            Text(
              title,
              style: TextStyleUtil.genSans500(
                fontSize: 12.9.ksp,
                color: ColorUtil(context).black,
              ),
            ),
            10.kheightBox,
          ],
        ),
        10.kheightBox,
        InkWell(
          onTap: () => ontap1(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.ksp),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 12.0.ksp,
                vertical: 8.ksp,
              ),
              decoration: BoxDecoration(
                color: ColorUtil(context).white,
                border: Border.all(color: ColorUtil(context).grey),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(6.ksp),
                ), // Rounded corners
              ),
              child: Row(
                children: [
                  Text(
                    subTitle1,
                    style: TextStyleUtil.genSans500(
                      fontSize: 11.ksp,
                      color: ColorUtil(context).black,
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios, size: 12.ksp),
                ],
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () => onTap2(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.ksp),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 12.0.ksp,
                vertical: 8.ksp,
              ),
              decoration: BoxDecoration(
                color: ColorUtil(context).white,
                border: Border.all(color: ColorUtil(context).grey),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(6.ksp),
                ), // Rounded corners
              ),
              child: Row(
                children: [
                  Text(
                    subTitle2,
                    style: TextStyleUtil.genSans500(
                      fontSize: 11.ksp,
                      color: ColorUtil(context).black,
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios, size: 12.ksp),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SettingTab1 extends StatelessWidget {
  SettingTab1({
    super.key,
    required this.title,
    required this.subTitle1,
    required this.ontap1,
  });

  String title, subTitle1;
  Function ontap1;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            20.kwidthBox,
            Text(
              title,
              style: TextStyleUtil.genSans500(
                fontSize: 12.9.ksp,
                color: ColorUtil(context).black,
              ),
            ),
            10.kheightBox,
          ],
        ),
        10.kheightBox,
        InkWell(
          onTap: () => ontap1(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.ksp),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 12.0.ksp,
                vertical: 8.ksp,
              ),
              decoration: BoxDecoration(
                color: ColorUtil(context).white,
                border: Border.all(color: ColorUtil(context).grey),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(6.ksp),
                  bottom: Radius.circular(6.ksp),
                ), // Rounded corners
              ),
              child: Row(
                children: [
                  Text(
                    subTitle1,
                    style: TextStyleUtil.genSans500(
                      fontSize: 11.ksp,
                      color: ColorUtil(context).black,
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios, size: 12.ksp),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SettingTab4 extends StatelessWidget {
  SettingTab4({
    super.key,
    required this.title,
    required this.subTitle1,
    required this.subTitle2,
    required this.subTitle3,
    required this.subTitle4,
    required this.onTap2,
    required this.ontap1,
    required this.ontap3,
    required this.onTap4,
  });

  String title, subTitle1, subTitle2, subTitle3, subTitle4;
  Function ontap1, onTap2, ontap3, onTap4;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            20.kwidthBox,
            Text(
              title,
              style: TextStyleUtil.genSans500(
                fontSize: 12.9.ksp,
                color: ColorUtil(context).black,
              ),
            ),
            10.kheightBox,
          ],
        ),
        10.kheightBox,
        InkWell(
          onTap: () => ontap1(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.ksp),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 12.0.ksp,
                vertical: 8.ksp,
              ),
              decoration: BoxDecoration(
                color: ColorUtil(context).white,
                border: Border.all(color: ColorUtil(context).grey),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(6.ksp),
                ), // Rounded corners
              ),
              child: Row(
                children: [
                  Text(
                    subTitle1,
                    style: TextStyleUtil.genSans500(
                      fontSize: 11.ksp,
                      color: ColorUtil(context).black,
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios, size: 12.ksp),
                ],
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () => onTap2(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.ksp),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 12.0.ksp,
                vertical: 8.ksp,
              ),
              decoration: BoxDecoration(
                color: ColorUtil(context).white,
                border: Border.all(color: ColorUtil(context).grey),
                borderRadius: BorderRadius.vertical(
                    // top: Radius.circular(6.ksp),
                    ), // Rounded corners
              ),
              child: Row(
                children: [
                  Text(
                    subTitle2,
                    style: TextStyleUtil.genSans500(
                      fontSize: 11.ksp,
                      color: ColorUtil(context).black,
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios, size: 12.ksp),
                ],
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () => ontap3(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.ksp),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 12.0.ksp,
                vertical: 8.ksp,
              ),
              decoration: BoxDecoration(
                color: ColorUtil(context).white,
                border: Border.all(color: ColorUtil(context).grey),
                borderRadius: BorderRadius.vertical(
                    // bottom: Radius.circular(6.ksp),
                    ), // Rounded corners
              ),
              child: Row(
                children: [
                  Text(
                    subTitle3,
                    style: TextStyleUtil.genSans500(
                      fontSize: 11.ksp,
                      color: ColorUtil(context).black,
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios, size: 12.ksp),
                ],
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () => onTap4(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.ksp),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 12.0.ksp,
                vertical: 8.ksp,
              ),
              decoration: BoxDecoration(
                color: ColorUtil(context).white,
                border: Border.all(color: ColorUtil(context).grey),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(6.ksp),
                ), // Rounded corners
              ),
              child: Row(
                children: [
                  Text(
                    subTitle4,
                    style: TextStyleUtil.genSans500(
                      fontSize: 11.ksp,
                      color: ColorUtil(context).black,
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios, size: 12.ksp),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
