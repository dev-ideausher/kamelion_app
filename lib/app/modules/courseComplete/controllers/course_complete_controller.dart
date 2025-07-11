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
  bool doesNotHaveQuize = false;
  @override
  void onInit() {
    doesNotHaveQuize = Get.arguments ?? false;
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
          ? "Unhappy"
          : selectedRating == 1
              ? "Sad"
              : selectedRating == 2
                  ? "Normal"
                  : selectedRating == 3
                      ? "Good"
                      : "Happy";
      response = await APIManager.submitMgRating(
        body: {
          "mentalGymId": Get.find<WorkoutDetailsController>()
              .mentalGymDetails!
              .value
              .mentalGym!
              .sId,
          "rating": "Sad"
        },
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        Get.back();
        // Get.back();
        if (!doesNotHaveQuize) {
          Get.back();
        }
        showMySnackbar(msg: "Thanks for submiting the rating");
      } else {
        debugPrint(
          "An error occurred while getting vendor profile: ${response.data['message']}",
        );
        showMySnackbar(msg: response.data['message'] ?? "");
      }
      update();
      // return;
    } on DioException catch (dioError) {
      Get.back();
      // Get.back();
      if (!doesNotHaveQuize) {
        Get.back();
      }
      showMySnackbar(msg: dioError.response?.data['message'] ?? "");
    } catch (e, s) {
      showMySnackbar(
        // title: LocaleKeys.somethingWentWrong.tr,
        msg: e.toString(),
      );
    }
  }
}
