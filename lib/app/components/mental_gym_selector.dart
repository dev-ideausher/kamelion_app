import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/components/common_image_view.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';
import 'package:kamelion/generated/locales.g.dart';

class MentalGymSelector extends StatelessWidget {
  MentalGymSelector({
    super.key,
    required this.mentalGymList,
    this.title,
    this.showViewAll,
  });
  List mentalGymList;
  String? title;
  bool? showViewAll = true;
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
                title ?? LocaleKeys.mental_gyms.tr,
                style: TextStyleUtil.genSans400(
                  fontSize: 16.ksp,
                  color: ColorUtil(context).black,
                  height: 1.2,
                ),
              ),
            ),
            (showViewAll ?? true)
                ? Row(
                  children: [
                    Text(
                      LocaleKeys.view_all.tr,
                      style: TextStyleUtil.genSans500(
                        fontSize: 11.ksp,
                        color: ColorUtil(context).brandColor1,
                        height: 1.2,
                      ),
                    ),
                    20.kwidthBox,
                  ],
                )
                : Container(),
          ],
        ),
        20.kheightBox,
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children:
                mentalGymList.map((item) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0.ksp),
                    child: Column(
                      children: [
                        ClipRRect(
                          child: CommonImageView(
                            svgPath: item["image"]!,
                            width: 80.ksp,
                            height: 80.ksp,
                            fit: BoxFit.cover,
                          ),
                        ),
                        // 8.kheightBox,
                        Container(
                          width: 80.ksp,
                          child: Center(
                            child: Text(
                              item["label"]!,
                              style: TextStyleUtil.genSans400(
                                fontSize: 10.ksp,
                                color: ColorUtil(context).black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
          ),
        ),
      ],
    );
  }
}
