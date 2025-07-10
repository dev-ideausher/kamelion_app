import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/models/personality_test_model.dart';
import 'package:kamelion/app/services/dio/api_service.dart';
import 'package:kamelion/app/services/snackbar.dart';

class PersonalityTestsController extends GetxController {
  //TODO: Implement PersonalityTestsController

  final count = 0.obs;
  RxList<PersonalityTetModel> personalityQestionsType =
      <PersonalityTetModel>[].obs;
  RxBool isLoading = false.obs;
  @override
  void onInit() async {
    isLoading.value = true;
    await getPersonalityQuestionsTypes();
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

  getPersonalityQuestionsTypes() async {
    try {
      var response = await APIManager.personalityQuestionsType();

      if (response.data['data'] != null && response.data['status']) {
        for (Map<String, dynamic> data in response.data['data']) {
          personalityQestionsType.add(PersonalityTetModel.fromJson(data));
        }
      } else {
        debugPrint(
          "An error occurred while getting vendor profile: ${response.data['message']}",
        );
      }
      update();
      return;
    } catch (e) {
      debugPrint("An exception occurred while getting vendor details! $e");
      showMySnackbar(title: "Error", msg: e.toString());
      return;
    }
  }
}
