import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/models/mental_gym_category_model.dart';
import 'package:kamelion/app/models/mental_gyms_details_model.dart';
import 'package:kamelion/app/services/dio/api_service.dart';
import 'package:kamelion/app/services/snackbar.dart';

class WorkoutDetailsController extends GetxController {
  //TODO: Implement WorkoutDetailsController

  final count = 0.obs;
  String mentalGymId = "";
  Rx<MentalGymDetailsModel>? mentalGymDetails;

  RxBool isLoading = false.obs;

  @override
  void onInit() async {
    isLoading.value = true;
    mentalGymId = Get.arguments;
    await getMentalGymDetails(mentalGymId);
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

  void postWorkoutProg(
      {required String workoutID, required currentDuration}) async {
    var response = await APIManager.postWorkoutProgressDuration(
      body: {"workoutId": "${workoutID}", "currentDuration": "${currentDuration}"},
    );

    if (response.statusCode == 200) {
      print(response.data);
    } else {
      debugPrint(
        "An error occurred while getting vendor profile: ${response.data['message']}",
      );
    }
  }

  void increment() => count.value++;

  Future<void> getMentalGymDetails(String id) async {
    try {
      var response;

      response = await APIManager.getMentalGymsDetails(id: id);

      if (response.data['data'] != null && response.data['status']) {
        mentalGymDetails =
            MentalGymDetailsModel.fromJson(response.data['data']).obs;
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

  Future<void> startMentalGym({required String id}) async {
    try {
      var response;

      response = await APIManager.getMentalGymsDetails(id: id);

      if (response.data['data'] != null && response.data['status']) {
        // mentalGymDetails =
        //     MentalGymDetailsModel.fromJson(response.data['data']).obs;
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

  Future<void> joinMentalGym(String id) async {
    try {
      var response;

      response = await APIManager.updateMentalGym(
        id: id,
        body: {"isActive": true},
      );
      if (response.data['data'] != null && response.data['status']) {
        await getMentalGymDetails(id);
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
