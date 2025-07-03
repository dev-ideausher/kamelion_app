import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/models/mental_gym_category_model.dart';
import 'package:kamelion/app/models/mental_gym_model.dart';
import 'package:kamelion/app/modules/home/controllers/home_controller.dart';
import 'package:kamelion/app/modules/mentalGym/views/active_workout.dart';
import 'package:kamelion/app/modules/mentalGym/views/all_workouts.dart';
import 'package:kamelion/app/modules/mentalGym/views/saved_workouts.dart';
import 'package:kamelion/app/routes/app_pages.dart';
import 'package:kamelion/app/services/dio/api_service.dart';
import 'package:kamelion/app/services/snackbar.dart';

class MentalGymController extends GetxController {
  //TODO: Implement MentalGymController

  final count = 0.obs;
  RxInt selectedScreenIndex = 0.obs;
  TextEditingController searchController = TextEditingController();
  RxBool isLoading = false.obs;
  final ScrollController scrollController = ScrollController();
  List<Widget> screensList = [
    AllWorkouts(),
    ActiveWorkouts(),
    ActiveWorkouts(),
    ActiveWorkouts(),
    SavedWorkouts(),
  ].obs;
  RxList activeWorkouts = ["", "", "", "", "", "", ""].obs;
  RxList savedWorkouts = ["", "", "", "", "", "", ""].obs;
  RxList<MentalGymCategoryModel> mentalGymCategoryList =
      <MentalGymCategoryModel>[].obs;
  RxList<MentalGymModel> activeMentalGymList = <MentalGymModel>[].obs;
  RxList<MentalGymModel> suggestedMentalGym = <MentalGymModel>[].obs;
  RxList<MentalGymModel> savedMentalGym = <MentalGymModel>[].obs;
  RxList<MentalGymModel> viewAllMentalGymList = <MentalGymModel>[].obs;
  RxString viewAllTitle = "".obs;
  RxInt activeMentalGymsCounts = 0.obs;
  RxInt activeWorkoutsCount = 0.obs;
  @override
  void onInit() async {
    isLoading.value = true;
    await getMentalGymCategiries();
    await getActiveMentalGym();
    await getSuggestedMentalGym();
    await getMentalGymCounts();
    isLoading.value = false;
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  getWorkoutDetails(String id) {
    Get.toNamed(Routes.WORKOUT_DETAILS, arguments: id);
  }

  changeTab(int index) async {
    selectedScreenIndex.value = index;
    if (index == 1) {
      viewAllMentalGymList = RxList<MentalGymModel>.from(activeMentalGymList);
      viewAllTitle.value = "Active Mental Gym";
    } else if (index == 2) {
      viewAllMentalGymList.value = suggestedMentalGym;
      viewAllTitle.value = "Suggested Mental Gym";
    } else if (index == 3) {

      viewAllMentalGymList.value =
          Get.find<HomeController>().popularMentalGyms.value;

      viewAllTitle.value = "Popular Mental Gym";
    } else if (index == 4) {
      await getSavedMentalGym();
      // viewAllMentalGymList == Get.find<HomeController>().popularMentalGyms;
      // viewAllTitle.value = "Popular Mental Gym";
    }
    scrollController.animateTo(
      0.0,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    update();
  }

  Future<void> getMentalGymCategiries() async {
    try {
      var response;

      response = await APIManager.getMentalGymCategiries();

      if (response.data['data'] != null && response.data['status']) {
        for (Map<String, dynamic> data in response.data['data']) {
          mentalGymCategoryList.add(MentalGymCategoryModel.fromJson(data));
          screensList.add(ActiveWorkouts());
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

  Future<void> getActiveMentalGym() async {
    try {
      var response;
      activeMentalGymList.value = <MentalGymModel>[];
      response = await APIManager.getActiveMentalGym(limit: "10", page: "1");

      if (response.data['data'] != null && response.data['status']) {
        for (Map<String, dynamic> data in response.data['data']) {
          activeMentalGymList.add(MentalGymModel.fromJson(data));
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

  Future<void> searchMentalGym() async {
    try {
      var response;

      response = await APIManager.searchMentalGym(
        limit: "10",
        page: "1",
        word: searchController.text,
      );
      print(response.data['data']);
      if (response.data['data'] != null && response.data['status']) {
        for (Map<String, dynamic> data in response.data['data']) {
          // activeMentalGymList.add(MentalGymModel.fromJson(data));
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

  Future<void> getSuggestedMentalGym() async {
    try {
      var response;

      response = await APIManager.getSuggestedMentalGyms();
      if (response.data['data'] != null && response.data['status']) {
        for (Map<String, dynamic> data in response.data['data']) {
          suggestedMentalGym.add(MentalGymModel.fromJson(data));
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

  Future<void> getMentalGymByCategory({required String categoryId}) async {
    try {
      var response;

      response = await APIManager.getMentalGymsByCategory(
        categoryId: categoryId,
      );
      if (response.data['data'] != null && response.data['status']) {
        for (Map<String, dynamic> data in response.data['data']) {
          viewAllMentalGymList.add(MentalGymModel.fromJson(data));
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

  Future<void> getMentalGymCounts() async {
    try {
      var response;

      response = await APIManager.getMentalGymCounts();
      if (response.data['data'] != null && response.data['status']) {
        activeMentalGymsCounts.value =
            response.data['data']['activeMentalGyms'];
        activeWorkoutsCount.value = response.data['data']['activeWorkouts'];
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

  saveMentalGym({required String mentalGymId}) async {
    try {
      var res = await APIManager.saveMentalGym(
        body: {
          "mentalGymId": mentalGymId,
          "userId": Get.find<HomeController>().currentUser.value.sId,
        },
      );
      if (res.statusCode == 200 || res.statusCode == 201) {
        // Get.back();

        showMySnackbar(msg: res.data['message']);
        return true;
      } else {
        return false;
      }
    } on DioException catch (dioError) {
      showMySnackbar(msg: dioError.message ?? "");
      return false;
    } catch (e, s) {
      showMySnackbar(
        // title: LocaleKeys.somethingWentWrong.tr,
        msg: e.toString(),
      );
      return false;
    }
  }

  updateViewAllMentalGym() {
    // Get.find<MentalGymController>().viewAllMentalGymList.refresh();
    update();
  }

  Future<void> getSavedMentalGym() async {
    try {
      var response;
      savedMentalGym.value = [];
      response = await APIManager.getSavedMentalGyms();
      if (response.data['data'] != null) {
        for (Map<String, dynamic> data in response.data['data']) {
          savedMentalGym.add(MentalGymModel.fromJson(data));
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
