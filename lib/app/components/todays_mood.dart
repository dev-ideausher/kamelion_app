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
            padding: EdgeInsets.symmetric(vertical: 4.ksp, horizontal: 0.ksp),
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: ColorUtil(context).goodMoodBg,
                borderRadius: BorderRadius.circular(10.ksp),
                border: Border.all(color: context.darkPitch),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonImageView(svgPath: moodImage),
                  20.kwidthBox,
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          // mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              mood,
                              style: TextStyleUtil.genSans600(
                                fontSize: 20.kh,
                                color: ColorUtil(context).black,
                              ),
                            ),
                            Spacer(),
                            Text(
                              time,
                              style: TextStyleUtil.genNunitoSans700(
                                fontSize: 12.kh,
                                color: ColorUtil(context).greyScaleText,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: 200.kw,
                          child: Text(
                            desc,
                            // "I woke up smiling, grateful for life’s little joys.",
                            style: TextStyleUtil.genNunitoSans400(
                              fontSize: 14.kh,
                              color: ColorUtil(context).greyDark,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
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
