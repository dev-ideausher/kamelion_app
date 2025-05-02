import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/modules/mentalGym/views/active_workout.dart';
import 'package:kamelion/app/modules/mentalGym/views/all_workouts.dart';
import 'package:kamelion/app/modules/mentalGym/views/saved_workouts.dart';
import 'package:kamelion/app/routes/app_pages.dart';

class MentalGymController extends GetxController {
  //TODO: Implement MentalGymController

  final count = 0.obs;
  RxInt selectedScreenIndex = 0.obs;
  List<Widget> screensList =
      [AllWorkouts(), ActiveWorkouts(), SavedWorkouts()].obs;
  RxList activeWorkouts = ["", "", "", "", "", "", ""].obs;
  RxList savedWorkouts = ["", "", "", "", "", "", ""].obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  getWorkoutDetails() {
    Get.toNamed(Routes.WORKOUT_DETAILS);
  }
}
