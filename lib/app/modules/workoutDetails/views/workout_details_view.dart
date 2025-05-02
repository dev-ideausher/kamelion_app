import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/components/workoutDetails/workout_details_appbar.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';
import '../controllers/workout_details_controller.dart';

class WorkoutDetailsView extends GetView<WorkoutDetailsController> {
  const WorkoutDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          WorkoutDetailsAppBar(),
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
              "Building friendships is an essential part of the human experience. It involves creating bonds with others that can enrich our lives, provide support, and foster a sense of belonging. Whether through shared interests, experiences, or simply spending time together, the journey of forming friendships can lead to lasting connections that bring joy and fulfillment.",
            ),
          ),
        ],
      ),
    );
  }
}
