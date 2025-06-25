import 'package:flutter/material.dart';
import 'package:fluttermoji/fluttermojiCircleAvatar.dart';
import 'package:get/utils.dart';
import 'package:intl/intl.dart';
import 'package:kamelion/app/components/common_image_view.dart';
import 'package:kamelion/app/constants/image_constant.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/custom_textfield.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';
import 'package:kamelion/generated/locales.g.dart';

class ActivitiesAppBar extends StatelessWidget {
  const ActivitiesAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.ksp, vertical: 6.ksp),
      decoration: BoxDecoration(
        color: ColorUtil(context).brandColor1,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            15.kheightBox,
            Row(
              children: [
                SizedBox(width: 6.ksp),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Activities",
                      style: TextStyleUtil.genSans500(
                        color: ColorUtil(context).white,
                        fontSize: 21.ksp,
                      ),
                    ),
                    8.kheightBox,
                    Row(
                      children: [
                        CommonImageView(svgPath: ImageConstant.yogaIconWhite),
                        4.kwidthBox,
                        Text(
                          "4" + " " + "Mental Activities",
                          style: TextStyleUtil.genSans400(
                            color: ColorUtil(context).white,
                            fontSize: 12.ksp,
                          ),
                        ),
                        20.kwidthBox,
                      ],
                    ),
                  ],
                ),
              ],
            ),
            12.kheightBox,
          ],
        ),
      ),
    );
  }
}
