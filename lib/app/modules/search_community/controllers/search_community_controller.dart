import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/models/community_model.dart';

import '../../../services/dio/api_service.dart';
import '../../../services/snackbar.dart';

class SearchCommunityController extends GetxController {

  final count = 0.obs;
  String word = "guided";
  RxList<CommunityModel> searchedCommunityList = <CommunityModel>[].obs;
  RxBool isLoading = false.obs;
  @override
  void onInit() async {
    isLoading.value = true;
    word = Get.arguments;
    await searchComunity();
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

  Future<void> searchComunity() async {
    try {
      var response;

      response = await APIManager.searchCommunities(
        limit: "10",
        page: "1",
        word: word,
      );
      if (response.data['data'] != null && response.data['status']) {
        for (Map<String, dynamic> data in response.data['data']) {
          searchedCommunityList.add(CommunityModel.fromJson(data));
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
