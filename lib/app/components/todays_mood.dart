import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/components/common_image_view.dart';
import 'package:kamelion/app/constants/image_constant.dart' show ImageConstant;
import 'package:kamelion/app/routes/app_pages.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';
import 'package:kamelion/generated/locales.g.dart';

class TodaysMood extends StatelessWidget {
  const TodaysMood({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 8.0.ksp),
              child: Text(
                LocaleKeys.todays_mood.tr,
                style: TextStyleUtil.genSans400(
                  fontSize: 16.ksp,
                  color: ColorUtil(context).black,
                  height: 1.2,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Get.toNamed(Routes.MOOD_SELECTION_FORM);
              },
              child: Row(
                children: [
                  Text(
                    LocaleKeys.add.tr,
                    style: TextStyleUtil.genSans500(
                      fontSize: 11.ksp,
                      color: ColorUtil(context).brandColor1,
                      height: 1.2,
                    ),
                  ),
                  4.kwidthBox,
                  CommonImageView(svgPath: ImageConstant.addIcon),
                  20.kwidthBox,
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.all(8.0.ksp),
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: ColorUtil(context).goodMoodBg,
              borderRadius: BorderRadius.circular(10.ksp),
            ),
            child: Row(
              children: [
                CommonImageView(svgPath: ImageConstant.goodMood),
                20.kwidthBox,
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: context.width * 0.7,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "Happy",
                            style: TextStyleUtil.genSans400(
                              fontSize: 14.ksp,
                              color: ColorUtil(context).black,
                            ),
                          ),
                          Text(
                            "15:34",
                            style: TextStyleUtil.genSans500(
                              fontSize: 11.ksp,
                              color: ColorUtil(context).black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: context.width * 0.69,
                      child: Text(
                        "I woke up smiling, grateful for life’s little joys.",
                        style: TextStyleUtil.genSans300(
                          fontSize: 11.ksp,
                          color: ColorUtil(context).greyDark,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
