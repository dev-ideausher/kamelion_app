import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttermoji/fluttermojiCircleAvatar.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/components/common_image_view.dart';
import 'package:kamelion/app/constants/image_constant.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';
import 'package:kamelion/generated/locales.g.dart';

class MentalGymsAppBar extends StatelessWidget {
  const MentalGymsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
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
            Text(
              LocaleKeys.mentalGyms.tr,
              style: TextStyleUtil.genSans500(
                color: ColorUtil(context).white,
                fontSize: 19.5.ksp,
              ),
            ),
            15.kheightBox,

            TextFormField(
              decoration: InputDecoration(
                hintText: "Search for mental gyms",
                filled: true,
                fillColor: ColorUtil(context).white,
                prefixIcon: const Icon(Icons.search),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            15.kheightBox,

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    CommonImageView(
                      imagePath: ImageConstant.mentalGymsWhileIcon,
                      height: 14.ksp,
                    ),
                    8.kwidthBox,
                    Text(
                      "7" + " " + "Mental Gyms",
                      style: TextStyleUtil.genSans500(
                        fontSize: 11.ksp,
                        color: context.white,
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    CommonImageView(
                      svgPath: ImageConstant.dumbelWhiteIcon,
                      height: 14.ksp,
                    ),
                    8.kwidthBox,
                    Text(
                      "150" + " " + "Workouts",
                      style: TextStyleUtil.genSans500(
                        fontSize: 11.ksp,
                        color: context.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
