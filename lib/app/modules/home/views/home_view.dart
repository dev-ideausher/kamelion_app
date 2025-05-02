import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/components/common_image_view.dart';
import 'package:kamelion/app/components/explore_communities_box.dart';
import 'package:kamelion/app/components/feelings_selection_widget.dart';
import 'package:kamelion/app/components/home_app_bar.dart';
import 'package:kamelion/app/components/mental_gym_selector.dart';
import 'package:kamelion/app/components/personal_insight_box.dart';
import 'package:kamelion/app/components/todays_mood.dart';
import 'package:kamelion/app/components/workout_selector.dart';
import 'package:kamelion/app/constants/image_constant.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/custom_button.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});
  final HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: ColorUtil(context).scaffoldBg, // Notification bar color
        // statusBarIconBrightness: Brightness.light, // Icons: light or dark
      ),
    );
    return Scaffold(
      backgroundColor: ColorUtil(context).scaffoldBg,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              HomeAppBar(userName: "Vivian"),
              20.kheightBox,
              FeelingSelectionWidget(moodsToShow: controller.moodsToShow),
              20.kheightBox,
              TodaysMood(),
              MentalGymSelector(mentalGymList: controller.mentalGymList),
              20.kheightBox,
              WorkoutSelector(workoutList: controller.mentalGymList),
              10.kheightBox,
              PersonalInsightBox(),
              10.kheightBox,
              ExporleCommuntiesBox(),
            ],
          ),
        ),
      ),
    );
  }
}
