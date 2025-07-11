import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kamelion/app/components/common_image_view.dart';
import 'package:kamelion/app/components/mentalGyms/mood_selection_slider.dart';
import 'package:kamelion/app/constants/image_constant.dart';
import 'package:kamelion/app/routes/app_pages.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/custom_button.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';
import 'package:kamelion/generated/locales.g.dart';

import '../controllers/course_complete_controller.dart';

class CourseCompleteView extends GetView<CourseCompleteController> {
  const CourseCompleteView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil(context).completionScreenBg,
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Get.back(); // example action
              Get.back(); // Navigate back
            },
          ),
          backgroundColor: ColorUtil(context).completionScreenBg),
      body: Column(
        children: [
          50.kheightBox,
          Center(
            child: CommonImageView(svgPath: ImageConstant.kamelionEducated),
          ),
          30.kheightBox,
          Text(
            "Mental Gym Done!",
            style: TextStyleUtil.genSans500(
              fontSize: 24.ksp,
              color: context.black,
            ),
          ),
          10.kheightBox,
          Text(
            LocaleKeys.how_do_you_feel.tr,
            style: TextStyleUtil.genSans400(
              fontSize: 14.ksp,
              color: context.black,
            ),
            textAlign: TextAlign.center,
          ),
          30.kheightBox,
          CommonImageView(svgPath: ImageConstant.greenPonter),
          15.kheightBox,
          ImageSliderSelector(
            onPageChanged: (index) {
              controller.selectedRating = index;
            },
          ),
          15.kheightBox,
          Padding(
            padding: EdgeInsets.all(12.0.ksp),
            child: CustomButton.outline(
              onTap: () {
                controller.submitRating();
              },
              title: LocaleKeys.submit_rating.tr,
            ),
          ),
        ],
      ),
    );
  }
}
