import 'package:flutter/services.dart' show DeviceOrientation, SystemChrome;
import 'package:get/get.dart';
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
      Get.back();
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
