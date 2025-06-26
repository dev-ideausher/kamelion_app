import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/components/workoutDetails/workout_details_appbar.dart';
import 'package:kamelion/app/modules/workoutDetails/views/video_player.dart';
import 'package:kamelion/app/routes/app_pages.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/custom_button.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';
import '../controllers/workout_details_controller.dart';

class WorkoutDetailsView extends GetView<WorkoutDetailsController> {
  const WorkoutDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<WorkoutDetailsController>(
      builder: (controller) {
        return controller.isLoading.value
            ? Container(
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(color: context.brandColor1),
              ),
            )
            : Scaffold(
              backgroundColor: context.scaffoldBg,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    WorkoutDetailsAppBar(
                      id:
                          controller.mentalGymDetails!.value.mentalGym!.sId ??
                          "",
                      isSaved:
                          (controller
                                      .mentalGymDetails!
                                      .value
                                      .mentalGym!
                                      .isSaved ??
                                  false)
                              .obs,
                      title:
                          controller.mentalGymDetails!.value.mentalGym!.title ??
                          "",
                      totalTime:
                          "${controller.mentalGymDetails!.value.mentalGym!.totalDuration ?? ""}",
                      workouts:
                          "${controller.mentalGymDetails!.value.workouts!.length ?? ""}",
                    ),
                    15.kheightBox,
                    Row(
                      children: [
                        18.kwidthBox,
                        Text(
                          "Introduction",
                          style: TextStyleUtil.genSans500(
                            fontSize: 14.ksp,
                            color: context.black,
                          ),
                        ),
                      ],
                    ),
                    12.kheightBox,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14.ksp),
                      child: Text(
                        controller
                                .mentalGymDetails!
                                .value
                                .mentalGym!
                                .description ??
                            "",
                        // "Building friendships is an essential part of the human experience. It involves creating bonds with others that can enrich our lives, provide support, and foster a sense of belonging. Whether through shared interests, experiences, or simply spending time together, the journey of forming friendships can lead to lasting connections that bring joy and fulfillment.",
                        style: TextStyleUtil.genSans400(
                          fontSize: 12.ksp,
                          color: ColorUtil(context).black,
                        ),
                      ),
                    ),
                    16.kheightBox,
                    Row(
                      children: [
                        18.kwidthBox,
                        Text(
                          "Workouts",
                          style: TextStyleUtil.genSans500(
                            fontSize: 14.ksp,
                            color: context.black,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${controller.mentalGymDetails!.value.workouts!.length}"
                          " "
                          "Total",
                          style: TextStyleUtil.genSans500(
                            fontSize: 10.ksp,
                            color: context.black,
                          ),
                        ),
                        18.kwidthBox,
                      ],
                    ),
                    10.kwidthBox,
                    ...controller.mentalGymDetails!.value.workouts!
                        .map(
                          (workout) => VideoCard(
                            duration: workout.totalDuration.toString() ?? "",
                            imageUrl:
                                workout.thumbnail?.url == ""
                                    ? "https://plus.unsplash.com/premium_photo-1689568126014-06fea9d5d341?q=80&w=2340&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
                                    : workout.thumbnail?.url ??
                                        "https://plus.unsplash.com/premium_photo-1689568126014-06fea9d5d341?q=80&w=2340&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                            onPlay: () {
                              Get.to(
                                VideoPlayerScreen(),
                                arguments:
                                    // "https://kamelion.s3.eu-north-1.amazonaws.com/public/profilePics/27889d38-928d-4ebe-805f-b93023e50bd4-Mental%20Health%20in%20Schools_%20We%E2%80%99re%20Doing%20it%20Wrong%20_%20Maya%20Dawson%20_%20TEDxYouth_CherryCreek.mp4",
                                    workout.video!.url ?? "",
                              );
                            },
                            title: workout.workoutTitle ?? "",
                          ),
                        )
                        .toList(),
                    controller.mentalGymDetails!.value.mentalGym!.isActive!
                        ? (controller
                                .mentalGymDetails!
                                .value
                                .mentalGym!
                                .isCompleted!
                            ? Container()
                            : Padding(
                              padding: EdgeInsets.all(16.0.ksp),
                              child: CustomButton.outline(
                                onTap: () {
                                  Get.toNamed(
                                    Routes.ONBOARDING_QUESTIONS,
                                    arguments: Routes.COURSE_COMPLETE,
                                  );
                                  // Get.toNamed(Routes.COURSE_COMPLETE);
                                },
                                title: 'Complete',
                                color: context.redBg,
                                buttonColor: context.redBg,
                              ),
                            ))
                        : Padding(
                          padding: EdgeInsets.all(16.0.ksp),
                          child: CustomButton.outline(
                            onTap: () {
                              controller.joinMentalGym(
                                controller
                                        .mentalGymDetails!
                                        .value
                                        .mentalGym!
                                        .sId ??
                                    "",
                              );
                              // Get.toNamed(Routes.COURSE_COMPLETE);
                            },
                            title: 'Start Mental Gym',
                            color: context.redBg,
                            buttonColor: context.redBg,
                          ),
                        ),
                  ],
                ),
              ),
            );
      },
    );
  }
}

class VideoCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String duration;
  final VoidCallback onPlay;

  const VideoCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.onPlay,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0.ksp, vertical: 5.ksp),
      child: Card(
        elevation: 2,
        color: context.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.ksp),
        ),
        child: Container(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.all(10.ksp),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipOval(
                      child: Image.network(
                        imageUrl,
                        width: 40.ksp,
                        height: 40.ksp,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      width: 40.ksp,
                      height: 40.ksp,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(0.4),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.play_arrow,
                          size: 30.ksp,
                          color: context.white,
                        ),
                        onPressed: onPlay,
                      ),
                    ),
                  ],
                ),
                12.kwidthBox,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyleUtil.genSans500(
                        fontSize: 13.ksp,
                        color: context.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.schedule,
                          color: context.lightRedBg,
                          size: 14.ksp,
                        ),
                        10.kwidthBox,
                        Text(
                          "$duration Mins",
                          style: TextStyleUtil.genSans400(
                            fontSize: 10.ksp,
                            color: context.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
