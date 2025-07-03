import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/components/common_image_view.dart';
import 'package:kamelion/app/constants/image_constant.dart';
import 'package:kamelion/app/modules/mentalGym/controllers/mental_gym_controller.dart';
import 'package:kamelion/app/modules/workoutDetails/controllers/workout_details_controller.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';

class WorkoutDetailsAppBar extends StatelessWidget {
  WorkoutDetailsAppBar({
    super.key,
    required this.title,
    required this.workouts,
    required this.totalTime,
    required this.isSaved,
    required this.id,
  });
  String title, workouts, totalTime, id;
  RxBool isSaved;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        padding: EdgeInsets.symmetric(horizontal: 15.ksp, vertical: 5.ksp),
        decoration: BoxDecoration(
          color: ColorUtil(context).redBg,
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
                        color: context.lightRedBg,
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

                  // Save Button
                  IconButton(
                    icon: Icon(
                      isSaved.value
                          ? Icons.bookmark_outlined
                          : Icons.bookmark_border,
                      color: context.white,
                      size: 18.ksp,
                    ),
                    onPressed: () async {
                      bool res = await Get.find<MentalGymController>()
                          .saveMentalGym(mentalGymId: id ?? "");
                      if (res) {
                        isSaved.value = !(isSaved.value);
                        // controller.viewAllMentalGymList.refresh();
                      }
                    },
                  ),
                ],
              ),
              Text(
                title,
                style: TextStyleUtil.genSans500(
                  color: ColorUtil(context).white,
                  fontSize: 19.5.ksp,
                ),
              ),
              12.kheightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ...Get.find<WorkoutDetailsController>()
                      .mentalGymDetails!
                      .value
                      .mentalGym!
                      .category!
                      .map(
                        (calegory) => Padding(
                          padding: EdgeInsets.only(right: 8.ksp),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.ksp,
                              vertical: 2.ksp,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: context.white),
                              borderRadius: BorderRadius.all(
                                Radius.circular(12.ksp),
                              ),
                            ),
                            child: Row(
                              children: [
                                CommonImageView(
                                  url: calegory.image,
                                  // imagePath: ImageConstant.mentalGymsWhileIcon,
                                  height: 11.ksp,
                                ),
                                8.kwidthBox,
                                Text(
                                  calegory.title ?? "",
                                  style: TextStyleUtil.genSans500(
                                    fontSize: 10.ksp,
                                    color: context.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ],
              ),
              12.kheightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  8.kwidthBox,
                  Row(
                    children: [
                      CommonImageView(
                        svgPath: ImageConstant.dumbelIconColored,
                        height: 11.ksp,
                      ),
                      8.kwidthBox,
                      Text(
                        "$workouts Workouts",
                        style: TextStyleUtil.genSans500(
                          fontSize: 10.ksp,
                          color: context.white,
                        ),
                      ),
                    ],
                  ),
                  20.kwidthBox,
                  Row(
                    children: [
                      CommonImageView(
                        svgPath: ImageConstant.clockIconColored,
                        height: 11.ksp,
                      ),
                      8.kwidthBox,
                      Text(
                        "${formatDuration(int.parse(totalTime))} ",
                        style: TextStyleUtil.genSans500(
                          fontSize: 10.ksp,
                          color: context.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              12.kheightBox,
            ],
          ),
        ),
      ),
    );
  }
}

String formatDuration(int totalSeconds) {
  final hours = totalSeconds ~/ 3600;
  final minutes = (totalSeconds % 3600) ~/ 60;
  final seconds = totalSeconds % 60;

  String hrPart = hours > 0 ? '${hours}Hr ' : '';
  String minPart = minutes > 0 ? '${minutes}Min ' : '';
  String secPart = '${seconds}Sec';

  return '$hrPart$minPart$secPart'.trim();
}
