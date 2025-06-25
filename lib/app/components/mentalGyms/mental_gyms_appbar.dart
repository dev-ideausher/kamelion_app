import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttermoji/fluttermojiCircleAvatar.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/components/common_image_view.dart';
import 'package:kamelion/app/constants/image_constant.dart';
import 'package:kamelion/app/modules/mentalGym/controllers/mental_gym_controller.dart';
import 'package:kamelion/app/routes/app_pages.dart';
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
              controller: Get.find<MentalGymController>().searchController,
              onFieldSubmitted: (search) {
                Get.toNamed(
                  Routes.SEARCH_MENTAL_GYM,
                  arguments:
                      Get.find<MentalGymController>().searchController.text,
                );
                Get.find<MentalGymController>().searchController.text = "";
              },
              decoration: InputDecoration(
                hintText: LocaleKeys.search_mental_gyms.tr,
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
                      "${Get.find<MentalGymController>().activeMentalGymsCounts.value} ${LocaleKeys.mental_gyms.tr}",
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
                      "${Get.find<MentalGymController>().activeWorkoutsCount.value} ${LocaleKeys.workouts.tr}",
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
