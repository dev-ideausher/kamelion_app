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
  TodaysMood({
    super.key,
    required this.desc,
    required this.mood,
    required this.moodImage,
    required this.time,
    required this.feelings,
    required this.activities,
  });
  String moodImage, mood, desc, time, feelings, activities;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(
          Routes.MOOD_SELECTION_FORM,
          arguments: {
            "mood": mood,
            "note": desc,
            "feeling": feelings,
            "activities": activities,
            "time": time,
          },
        );
      },
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.ksp, horizontal: 8.ksp),
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: ColorUtil(context).goodMoodBg,
                borderRadius: BorderRadius.circular(10.ksp),
                border: Border.all(color: context.darkPitch),
              ),
              child: Row(
                children: [
                  CommonImageView(svgPath: moodImage),
                  20.kwidthBox,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: context.width * 0.69,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              mood,
                              style: TextStyleUtil.genSans400(
                                fontSize: 14.ksp,
                                color: ColorUtil(context).black,
                              ),
                            ),
                            Text(
                              time,
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
                          desc,
                          // "I woke up smiling, grateful for life’s little joys.",
                          style: TextStyleUtil.genSans300(
                            fontSize: 11.ksp,
                            color: ColorUtil(context).greyDark,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
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
      ),
    );
  }
}
