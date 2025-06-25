import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/models/mental_gym_model.dart';
import 'package:kamelion/app/services/dio/api_service.dart';
import 'package:kamelion/app/services/snackbar.dart';

class SearchMentalGymController extends GetxController {
  //TODO: Implement SearchMentalGymController

  final count = 0.obs;
  String word = "";
  RxList<MentalGymModel> searchedMentalGymList = <MentalGymModel>[].obs;
  RxBool isLoading = false.obs;
  @override
  void onInit() async {
    isLoading.value = true;
    word = Get.arguments;
    await searchMentalGym();
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

  Future<void> searchMentalGym() async {
    try {
      var response;

      response = await APIManager.searchMentalGym(
        limit: "10",
        page: "1",
        word: word,
      );
      if (response.data['data'] != null && response.data['status']) {
        for (Map<String, dynamic> data in response.data['data']) {
          searchedMentalGymList.add(MentalGymModel.fromJson(data));
        }
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
