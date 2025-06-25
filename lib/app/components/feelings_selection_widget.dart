import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/utils.dart';
import 'package:kamelion/app/components/common_image_view.dart';
import 'package:kamelion/app/constants/enums.dart';
import 'package:kamelion/app/routes/app_pages.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';
import 'package:kamelion/generated/locales.g.dart';

class FeelingSelectionWidget extends StatelessWidget {
  FeelingSelectionWidget({super.key, required this.moodsToShow});
  List moodsToShow;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          LocaleKeys.how_are_you_feeling.tr,
          style: TextStyleUtil.genSans400(
            fontSize: 20.ksp,
            color: ColorUtil(context).black,
            height: 1.2,
          ),
          textAlign: TextAlign.center,
        ),
        20.kheightBox,
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children:
                moodsToShow.map((item) {
                  return GestureDetector(
                    onTap: () {
                      Get.back();
                      Get.toNamed(
                        Routes.MOOD_SELECTION_FORM,
                        arguments: {
                          "mood": Mood.values.byName(
                            item['label'].toString().toLowerCase(),
                          ),
                        },
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7.ksp),
                      child: Column(
                        children: [
                          ClipRRect(
                            child: CommonImageView(
                              svgPath: item["image"]!,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          8.kheightBox,
                          Text(
                            item["label"]!,
                            style: TextStyleUtil.genSans400(
                              fontSize: 10.ksp,
                              color: ColorUtil(context).black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
          ),
        ),
      ],
    );
  }
}
