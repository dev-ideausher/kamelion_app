import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/models/challenge_details_model.dart';
import 'package:kamelion/app/modules/challenges/controllers/challenges_controller.dart';
import 'package:kamelion/app/services/dio/api_service.dart';
import 'package:kamelion/app/services/snackbar.dart';

class ChallengeDetailsController extends GetxController {
  //TODO: Implement ChallengeDetailsController

  final count = 0.obs;
  Rx<ChallengeDetailsModel>? challengeDetails;
  RxBool isLoading = false.obs;
  String? challengeId;
  @override
  void onInit() async {
    isLoading.value = true;
    challengeId = Get.arguments;
    await getChallengesDetails(challengeId ?? "");
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

  Future<void> getChallengesDetails(String id) async {
    try {
      var response;

      response = await APIManager.getChallengesDetails(id: id);

      if (response.data['data'] != null && response.data['status']) {
        challengeDetails =
            ChallengeDetailsModel.fromJson(response.data['data']).obs;
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

  Future<void> startChallenge() async {
    try {
      var response;

      response = await APIManager.startChallenge(
        body: {
          "challengeId": challengeDetails?.value.sId,
          "status": "inProgress",
          "durationSpent": 0
        },
      );
      if (response.data['data'] != null && response.data['status']) {
        await getChallengesDetails(challengeDetails?.value.sId ?? "");
        Get.find<ChallengesController>().getActiveChallenges();
        update();
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

  Future<void> completeChallenge() async {
    try {
      var response;

      response = await APIManager.startChallenge(
        body: {
          "challengeId": challengeDetails?.value.sId,
          "status": "completed",
          "durationSpent": challengeDetails?.value.totalDuration
        },
      );
      if (response.data['data'] != null && response.data['status']) {
        Get.back();
        await getChallengesDetails(challengeDetails?.value.sId ?? "");
        Get.find<ChallengesController>().getActiveChallenges();
        update();
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

  Future<void> quiteChallenge() async {
    try {
      var response;

      response = await APIManager.startChallenge(
        body: {
          "challengeId": challengeDetails?.value.sId,
          "status": "quit",
          // "durationSpent": challengeDetails?.value.totalDuration
        },
      );
      if (response.data['data'] != null && response.data['status']) {
        Get.back();
        await getChallengesDetails(challengeDetails?.value.sId ?? "");

        Get.find<ChallengesController>().getActiveChallenges();
        update();
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

  // Future<void> completeChallenge() async {
  //   try {
  //     var response;

  //     response = await APIManager.startChallenge(
  //       body: {
  //         "challengeId": challengeDetails?.value.sId,
  //         "status": "completed",
  //         "progressPercent": 100
  //       },
  //     );
  //     if (response.data['data'] != null && response.data['status']) {
  //       await getChallengesDetails(challengeDetails?.value.sId ?? "");
  //       update();
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
}
