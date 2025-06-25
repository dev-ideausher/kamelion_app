import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/components/common_image_view.dart';
import 'package:kamelion/app/constants/image_constant.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';
import 'package:kamelion/generated/locales.g.dart';

class SupportAppBar extends StatelessWidget {
  const SupportAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.ksp, vertical: 5.ksp),
      decoration: BoxDecoration(
        color: ColorUtil(context).brandColor1,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.ksp),
          bottomRight: Radius.circular(20.ksp),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    height: 25.ksp,
                    width: 25.ksp,
                    decoration: BoxDecoration(
                      color: context.lightBrandColor,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 4.0.ksp),
                      child: Center(
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 11.ksp,
                          color: context.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            10.kheightBox,
            Text(
              "Support",
              style: TextStyleUtil.genSans500(
                color: ColorUtil(context).white,
                fontSize: 19.5.ksp,
              ),
            ),
            12.kheightBox,
          ],
        ),
      ),
    );
  }
}
