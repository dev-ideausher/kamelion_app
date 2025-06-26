import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/components/common_image_view.dart';
import 'package:kamelion/app/constants/image_constant.dart';
import 'package:kamelion/app/modules/navigationBar/controllers/navigation_bar_controller.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/custom_button.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';
import 'package:kamelion/generated/locales.g.dart';

class ExporleCommuntiesBox extends StatelessWidget {
  const ExporleCommuntiesBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.ksp),
      child: Container(
        width: context.width,
        padding: EdgeInsets.symmetric(horizontal: 12.ksp, vertical: 2.ksp),
        decoration: BoxDecoration(
          border: Border.all(
            color: ColorUtil(context).lightYellowBorder,
            width: 1.ksp,
          ),
          color: ColorUtil(context).lightYellowBg,
          borderRadius: BorderRadius.circular(10.ksp),
        ),
        child: Stack(
          children: [
            SizedBox(
              width: context.width * 0.67,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  20.kheightBox,
                  Text(
                    LocaleKeys.explore_communities.tr,
                    style: TextStyleUtil.genSans500(
                      fontSize: 18.ksp,
                      color: ColorUtil(context).black,
                      height: 1.2,
                    ),
                  ),
                  8.kheightBox,
                  Text(
                    LocaleKeys.explore_communities_desc.tr,
                    style: TextStyleUtil.genSans300(
                      fontSize: 12.ksp,
                      color: ColorUtil(context).black,
                      // height: 1.2,
                    ),
                  ),
                  30.kheightBox,
                  InkWell(
                    onTap: () {
                      Get.find<NavigationBarController>().selectedIndex.value =
                          3;
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 60.ksp),
                      child: CustomButton.outline(
                        height: 30.ksp,
                        title: "Explore Communities",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: context.width,
              height: 145.ksp,
              child: Align(
                alignment: Alignment.bottomRight,
                child: CommonImageView(
                  height: 85.ksp,
                  svgPath: ImageConstant.circleBg,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
