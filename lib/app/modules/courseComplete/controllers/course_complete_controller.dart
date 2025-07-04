import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/modules/workoutDetails/controllers/workout_details_controller.dart';
import 'package:kamelion/app/services/dio/api_service.dart';
import 'package:kamelion/app/services/snackbar.dart';

class CourseCompleteController extends GetxController {
  //TODO: Implement CourseCompleteController

  final count = 0.obs;
  int selectedRating = 2;
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

  Future<void> submitRating() async {
    try {
      var response;
      String mood = selectedRating == 0
          ? "unhappy"
          : selectedRating == 1
              ? "sad"
              : selectedRating == 2
                  ? "normal"
                  : selectedRating == 3
                      ? "good"
                      : "happy";

      response = await APIManager.submitMgRating(
        body: {
          "mentalGymIdId": Get.find<WorkoutDetailsController>()
              .mentalGymDetails!
              .value
              .mentalGym!
              .sId,
          "rating": mood
        },
      );
      if (response.data['status']) {
      } else {
        debugPrint(
          "An error occurred while getting vendor profile: ${response.data['message']}",
        );
        showMySnackbar(msg: response.data['message'] ?? "");
      }
      update();
      // return;
    } on DioException catch (dioError) {
      showMySnackbar(msg: dioError.message ?? "");
    } catch (e, s) {
      showMySnackbar(
        // title: LocaleKeys.somethingWentWrong.tr,
        msg: e.toString(),
      );
    }
  }
}
