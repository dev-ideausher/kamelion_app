import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/components/common_image_view.dart';
import 'package:kamelion/app/constants/image_constant.dart';
import 'package:kamelion/app/modules/home/controllers/home_controller.dart';
import 'package:kamelion/app/modules/mentalGym/controllers/mental_gym_controller.dart';
import 'package:kamelion/app/modules/navigationBar/controllers/navigation_bar_controller.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';
import 'package:kamelion/generated/locales.g.dart';

class WorkoutSelector extends StatelessWidget {
  WorkoutSelector({super.key, required this.workoutList});

  List workoutList;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Get.find<HomeController>().popularMentalGyms.isEmpty
            ? Container()
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Popular Mental Gyms",
                    style: TextStyleUtil.genSans600(
                      fontSize: 16.ksp,
                      color: ColorUtil(context).black,
                    ),
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.find<MentalGymController>().changeTab(3);
                          Get.find<NavigationBarController>().changePage(1);
                        },
                        child: Text(
                          LocaleKeys.view_all.tr,
                          style: TextStyleUtil.genNunitoSans700(
                            fontSize: 11.ksp,
                            color: ColorUtil(context).brandColor1,
                            height: 1.2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
        16.kheightBox,
        Obx(
          () => SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...Get.find<HomeController>().popularMentalGyms.map((item) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0.0.ksp),
                    child: GestureDetector(
                      onTap: () {
                        Get.find<MentalGymController>().getWorkoutDetails(
                          item.sId ?? "",
                        );
                      },
                      child: Card(
                        elevation: 4,
                        shadowColor: Colors.grey.withOpacity(0.2),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: context.greyBorder),
                          borderRadius: BorderRadius.circular(4.ksp),
                        ),
                        color: ColorUtil(context).white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0.ksp),
                              child: ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(4.ksp),
                                ),
                                child: CommonImageView(
                                  url: item.thumbnail!.url,
                                  // svgPath: ImageConstant.dummyCoverImage,
                                  height: 90.ksp,
                                  width: context.width * 0.65,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: context.width * 0.65,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 8.0.ksp,
                                        ),
                                        child: Container(
                                          width: 160.ksp,
                                          child: Text(
                                            item.title ?? "",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyleUtil.genSans400(
                                              fontSize: 12.ksp,
                                              color: ColorUtil(context).black,
                                              height: 1.2,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 8.0.ksp,
                                          vertical: 2.ksp,
                                        ),
                                        child: Container(
                                          width: 155.ksp,
                                          child: Text(
                                            item.category!
                                                    .map((c) => c.title)
                                                    .join(', ') ??
                                                "",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyleUtil.genSans400(
                                              fontSize: 10.ksp,
                                              color:
                                                  ColorUtil(context).greyDark,
                                              height: 1.2,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      bool res =
                                          await Get.find<MentalGymController>()
                                              .saveMentalGym(
                                        mentalGymId: item.sId ?? "",
                                      );
                                      if (res) {
                                        final controller =
                                            Get.find<HomeController>();
                                        final index = controller
                                            .popularMentalGyms
                                            .indexOf(item);
                                        final updated = item.copyWith(
                                          isSaved: !(item.isSaved ?? false),
                                        );

                                        controller.popularMentalGyms[index] =
                                            updated;
                                        controller.popularMentalGyms.refresh();
                                      }
                                    },
                                    child: Icon(
                                      item.isSaved!
                                          ? Icons.bookmark_outlined
                                          : Icons.bookmark_outline,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            10.kheightBox,
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                10.kwidthBox,
                                Text(
                                  LocaleKeys.earn_kalikoins.tr,
                                  style: TextStyleUtil.genSans500(
                                    fontSize: 10.ksp,
                                    color: ColorUtil(context).brandColor1,
                                    // fontWeight: FontWeight.bold,
                                  ),
                                ),
                                50.kwidthBox,
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.ksp,
                                    vertical: 2.ksp,
                                  ),
                                  decoration: BoxDecoration(
                                    color: ColorUtil(context).lighPitchBg,
                                    borderRadius: BorderRadius.circular(20.ksp),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.trending_up,
                                        size: 12.ksp,
                                        color: ColorUtil(context).darkRedText,
                                      ),
                                      5.kwidthBox,
                                      Text(
                                        LocaleKeys.trending.tr,
                                        style: TextStyleUtil.genSans500(
                                          fontSize: 10.ksp,
                                          color: ColorUtil(context).darkRedText,
                                          // fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            10.kheightBox,
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
