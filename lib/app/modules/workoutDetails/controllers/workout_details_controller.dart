import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/models/mental_gym_category_model.dart';
import 'package:kamelion/app/models/mental_gyms_details_model.dart';
import 'package:kamelion/app/modules/mentalGym/controllers/mental_gym_controller.dart';
import 'package:kamelion/app/modules/workoutDetails/views/video_player.dart';
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

  Future<void> postWorkoutProg(
      {required String workoutID, required currentDuration}) async {
    var response = await APIManager.postWorkoutProgressDuration(
      body: {
        "workoutId": "${workoutID}",
        "currentDuration": "$currentDuration"
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      getMentalGymDetails(mentalGymDetails!.value.mentalGym!.sId ?? "");
      await Get.find<MentalGymController>().getActiveMentalGym();
      await Get.find<MentalGymController>().getCompletedMentalGym();
      Get.find<MentalGymController>().activeMentalGymList.refresh();
      Get.find<MentalGymController>().completedMentalGym.refresh();
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
      mentalGymDetails?.refresh();
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

  // Future<void> startMentalGym({required String id}) async {
  //   try {
  //     var response;

  //     response = await APIManager.getMentalGymsDetails(id: id);

  //     if (response.data['data'] != null && response.data['status']) {
  //       // mentalGymDetails =
  //       //     MentalGymDetailsModel.fromJson(response.data['data']).obs;
  //     } else {
  //       debugPrint(
  //         "An error occurred while getting vendor profile: ${response.data['message']}",
  //       );
  //       showMySnackbar(msg: response.data['message'] ?? "");
  //     }
  //     update();
  //     // return;
  //   } on DioException catch (dioError) {
  //     showMySnackbar(msg: dioError.message ?? "");
  //   } catch (e, s) {
  //     showMySnackbar(
  //       // title: LocaleKeys.somethingWentWrong.tr,
  //       msg: e.toString(),
  //     );
  //   }
  // }

  Future<void> joinMentalGym(String id) async {
    try {
      var response;

      response = await APIManager.joinMentalGym(
        body: {"mentalGymId": id},
      );
      if (response.data['status']) {
        if (mentalGymDetails!.value.workouts != null &&
            mentalGymDetails!.value.workouts!.isNotEmpty) {
          Get.to(VideoPlayerScreen(), arguments: {
            // "https://kamelion.s3.eu-north-1.amazonaws.com/public/profilePics/27889d38-928d-4ebe-805f-b93023e50bd4-Mental%20Health%20in%20Schools_%20We%E2%80%99re%20Doing%20it%20Wrong%20_%20Maya%20Dawson%20_%20TEDxYouth_CherryCreek.mp4",
            'videoUrl': mentalGymDetails!.value.workouts![0].video!.url ?? "",
            'workoutId': mentalGymDetails!.value.workouts![0].sId,
          });
        }
        await getMentalGymDetails(id);
        mentalGymDetails!.refresh();
        await Get.find<MentalGymController>().getActiveMentalGym();
        Get.find<MentalGymController>().activeMentalGymList.refresh();
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
