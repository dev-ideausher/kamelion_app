import 'package:flutter/services.dart' show DeviceOrientation, SystemChrome;
import 'package:get/get.dart';
import 'package:kamelion/app/modules/workoutDetails/controllers/workout_details_controller.dart';
import 'package:kamelion/app/routes/app_pages.dart';
import 'package:kamelion/app/services/dio/api_service.dart';
import 'package:kamelion/app/services/snackbar.dart';

class StartQuizeController extends GetxController {
  //TODO: Implement StartQuizeController

  final count = 0.obs;
  String workoutId = "";
  RxBool isLoading = false.obs;
  @override
  void onInit() async {
    isLoading.value = true;
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    workoutId = Get.arguments ?? "";
    var response = await APIManager.getMentalGymQuestions(workoutId);

    if (response.data['data'] == null ||
        (response.data['data'] is List && response.data['data'].isEmpty)) {
      await Get.find<WorkoutDetailsController>().getMentalGymDetails(
          Get.find<WorkoutDetailsController>()
                  .mentalGymDetails!
                  .value
                  .mentalGym!
                  .sId ??
              "",
          isOverlayLoader: false);
      if ((Get.find<WorkoutDetailsController>()
                  .mentalGymDetails!
                  .value
                  .mentalGym!
                  .userProgress ??
              0) ==
          100) {
        Get.offNamed(Routes.COURSE_COMPLETE, arguments: true);
      } else {
        Get.back();
      }
    }
    await Future.delayed(Duration(seconds: 1));
    update();
    isLoading.value = false;

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
}
