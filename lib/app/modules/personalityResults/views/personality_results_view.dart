import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kamelion/app/components/activities/personality_test_appbar.dart';
import 'package:kamelion/app/components/common_image_view.dart';
import 'package:kamelion/app/constants/image_constant.dart';
import 'package:kamelion/app/modules/navigationBar/controllers/navigation_bar_controller.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/custom_button.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';

import '../controllers/personality_results_controller.dart';

class PersonalityResultsView extends GetView<PersonalityResultsController> {
  const PersonalityResultsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.0.ksp, vertical: 4.ksp),
        child: CustomButton.outline(
            onTap: () {
              Get.back();
              Get.back();
              Get.find<NavigationBarController>().selectedIndex.value = 0;
            },
            title: 'Go Home'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Column(
        children: [
          PersonalityTestAppBar(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0.ksp),
            child: Column(
              children: [
                70.kheightBox,
                CommonImageView(
                  svgPath: ImageConstant.kamelionGifting,
                ),
                50.kheightBox,
                Text(
                  "Test Complete",
                  style: TextStyleUtil.genNunitoSans600(
                      fontSize: 18.ksp, color: context.black),
                ),
                10.kheightBox,
                Text(
                  "Your personality is ${controller.personalityType.value}",
                  textAlign: TextAlign.center,
                  style: TextStyleUtil.genNunitoSans500(
                      fontSize: 12.5.ksp, color: context.black),
                ),
                10.kheightBox,
                Text(
                  "${controller.personalityDesc.value}",
                  textAlign: TextAlign.center,
                  style: TextStyleUtil.genNunitoSans500(
                      fontSize: 12.5.ksp, color: context.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
