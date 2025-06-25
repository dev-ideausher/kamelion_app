import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kamelion/app/components/common_image_view.dart';
import 'package:kamelion/app/constants/image_constant.dart';
import 'package:kamelion/app/routes/app_pages.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/custom_button.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';
import 'package:kamelion/generated/locales.g.dart';

import '../controllers/quize_complete_controller.dart';

class QuizeCompleteView extends GetView<QuizeCompleteController> {
  const QuizeCompleteView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil(context).completionScreenBg,
      appBar: AppBar(backgroundColor: ColorUtil(context).completionScreenBg),
      body: Column(
        children: [
          50.kheightBox,
          Center(
            child: CommonImageView(svgPath: ImageConstant.kamelionGifting),
          ),
          30.kheightBox,
          Text(
            LocaleKeys.quiz_complete.tr,
            style: TextStyleUtil.genSans500(
              fontSize: 24.ksp,
              color: context.black,
            ),
          ),
          0.kheightBox,
          Text(
            LocaleKeys.total_kalicoins.tr,
            style: TextStyleUtil.genSans400(
              fontSize: 12.ksp,
              color: context.black,
            ),
            textAlign: TextAlign.center,
          ),
          12.kheightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "1275",
                style: TextStyleUtil.genSans500(
                  fontSize: 20.ksp,
                  color: context.black,
                ),
              ),
              4.kwidthBox,
              CommonImageView(svgPath: ImageConstant.coinStack),
            ],
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.all(12.0.ksp),
            child: CustomButton.outline(
              onTap: () {
                Get.back();
              },
              title: LocaleKeys.collect_kalicoins.tr,
            ),
          ),
          30.kheightBox,
        ],
      ),
    );
  }
}
