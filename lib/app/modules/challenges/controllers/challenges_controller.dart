import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/models/badges_model.dart';
import 'package:kamelion/app/models/challenge_model.dart';
import 'package:kamelion/app/modules/challenges/views/active_challenges.dart';
import 'package:kamelion/app/modules/challenges/views/all_challenges.dart';
import 'package:kamelion/app/modules/challenges/views/completed_challenges.dart';
import 'package:kamelion/app/modules/home/controllers/home_controller.dart';
import 'package:kamelion/app/modules/mentalGym/controllers/mental_gym_controller.dart';
import 'package:kamelion/app/modules/mentalGym/views/active_workout.dart';
import 'package:kamelion/app/modules/mentalGym/views/all_workouts.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/dio/api_service.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/snackbar.dart';
import 'package:kamelion/app/services/text_style_util.dart';

class ChallengesController extends GetxController
    with GetTickerProviderStateMixin {
  //TODO: Implement ChallengesController

  final count = 0.obs;
  late TabController challengePageTabController;
  RxInt selectedScreenIndex = 0.obs;
  RxBool isLoading = false.obs;
  RxList<BadgeModel> badgesList = <BadgeModel>[].obs;
  RxList<ChallengeModel> activeChallenges = <ChallengeModel>[].obs;
  RxList<ChallengeModel> completedChallenges = <ChallengeModel>[].obs;
  RxList<ChallengeModel> savedChallenges = <ChallengeModel>[].obs;
  RxList<ChallengeModel> suggestedChallenges = <ChallengeModel>[].obs;
  RxList<ChallengeModel> viewAllList = <ChallengeModel>[].obs;
  RxList<ChallengeModel> categoryChallenges = <ChallengeModel>[].obs;
  RxString viewAllTitle = "".obs;
  List<Widget> screensList = [
    AllChallenges(),
    ActiveChallenges(),
    CompletedChallenges(),
    CompletedChallenges(),
    CompletedChallenges()
  ].obs;
  @override
  void onInit() async {
    super.onInit();
    isLoading.value = true;
    challengePageTabController = TabController(length: 2, vsync: this);
    await getActiveChallenges();
    await getSuggestedChallenges();
    await getCompletedChallenges();
    await getSavedChallenges();
    await getBagdes();
    for (int i = 0;
        i < Get.find<MentalGymController>().mentalGymCategoryList.length;
        i++) {
      screensList.add(CompletedChallenges());
    }

    // Get.find<MentalGymController>().mentalGymCategoryList.map(f)
    isLoading.value = false;
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

  Future<void> getActiveChallenges() async {
    try {
      var response;

      isLoading.value = true;
      response = await APIManager.getActiveChallenges();

      if (response.data['data'] != null && response.data['status']) {
        activeChallenges.value = [];
        for (Map<String, dynamic> data in response.data['data']) {
          activeChallenges.add(ChallengeModel.fromJson(data));
        }
        isLoading.value = false;
      } else {
        debugPrint(
          "An error occurred while getting vendor profile: ${response.data['message']}",
        );
        showMySnackbar(msg: response.data['message'] ?? "");
        isLoading.value = false;
      }
      activeChallenges.refresh();
      update();
      // return;
    } on DioException catch (dioError) {
      isLoading.value = false;
      showMySnackbar(msg: dioError.message ?? "");
    } catch (e, s) {
      isLoading.value = false;
      showMySnackbar(
        // title: LocaleKeys.somethingWentWrong.tr,
        msg: e.toString(),
      );
    }
  }

  Future<void> getBagdes() async {
    try {
      var response;

      response = await APIManager.getBadges();

      if (response.data['data'] != null && response.data['status']) {
        for (Map<String, dynamic> data in response.data['data']) {
          badgesList.add(BadgeModel.fromJson(data));
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

  saveChallenge({required String challangeId}) async {
    try {
      var res = await APIManager.saveChallenge(
        body: {
          "challengeId": challangeId,
          // "userId": Get.find<HomeController>().currentUser.value.sId,
        },
      );
      if (res.statusCode == 200 || res.statusCode == 201) {
        // Get.back();

        showMySnackbar(msg: res.data['message']);
        getActiveChallenges();
        getSuggestedChallenges();
        getCompletedChallenges();
        getSavedChallenges();
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

  Future<void> getChallengesByCategory({
    required String id,
    required String categoryName,
    required int index,
  }) async {
    try {
      var response;
      categoryChallenges.value = [];
      isLoading.value = true;
      selectedScreenIndex.value = index;
      response = await APIManager.getChallengeByCategory(
        id: id,
        // limit: "10",
        // page: "1",
      );
      if (response.data['data'] != null && response.data['status']) {
        for (Map<String, dynamic> data in response.data['data']) {
          categoryChallenges.value.add(ChallengeModel.fromJson(data));
        }
        viewAllList = categoryChallenges;
        viewAllTitle.value = categoryName;
      } else {
        debugPrint(
          "An error occurred while getting vendor profile: ${response.data['message']}",
        );
        showMySnackbar(msg: response.data['message'] ?? "");
      }
      isLoading.value = false;
      update();
      // return;
    } on DioException catch (dioError) {
      showMySnackbar(msg: dioError.message ?? "");
      isLoading.value = false;
    } catch (e, s) {
      isLoading.value = false;
      showMySnackbar(
        // title: LocaleKeys.somethingWentWrong.tr,
        msg: e.toString(),
      );
    }
  }

  Future<void> getSavedChallenges() async {
    try {
      var response;

      response = await APIManager.getSavedChallenges();

      if (response.data['data'] != null && response.data['status']) {
        savedChallenges.value = [];
        for (Map<String, dynamic> data in response.data['data']) {
          savedChallenges.add(ChallengeModel.fromJson(data));
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

  Future<void> getCompletedChallenges() async {
    try {
      var response;

      response = await APIManager.getCompletedChallenges();

      if (response.data['data'] != null && response.data['status']) {
        completedChallenges.value = [];
        for (Map<String, dynamic> data in response.data['data']) {
          completedChallenges.add(ChallengeModel.fromJson(data));
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

  Future<void> getSuggestedChallenges() async {
    try {
      var response;

      response = await APIManager.getSuggestedChallenges();

      if (response.data['data'] != null && response.data['status']) {
        suggestedChallenges.value = [];
        for (Map<String, dynamic> data in response.data['data']) {
          suggestedChallenges.add(ChallengeModel.fromJson(data));
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

  showBadgeDetails({
    required var context,
    required String title,
    required String badgeImage,
    required String subTitle,
    required num progress,
    required num totalValue,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // 👈 Rounded corners
          ),
          child: Container(
            decoration: BoxDecoration(
              color: true ? context.greyLightBg : context.brandColor1Light,
              border: Border.all(
                  color: true ? context.greyBorder : context.brandBorderColor),
              borderRadius: BorderRadius.circular(14.ksp), // Rounded corners
            ),
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 12.0.ksp, vertical: 8.ksp),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  20.kheightBox,
                  ClipOval(
                    child: Image.network(
                      badgeImage,
                      // 'https://plus.unsplash.com/premium_photo-1714138490043-40cbd9d982dc?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8YmFkZ2V8ZW58MHx8MHx8fDA%3D',
                      width: 170.ksp,
                      height: 170.ksp,
                      fit: BoxFit.cover,
                    ),
                  ),
                  20.kheightBox,
                  Text(
                    title,
                    style: TextStyleUtil.genSans600(
                      fontSize: 13.ksp,
                      color: context.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  6.kheightBox,
                  Flexible(
                    child: Text(
                      subTitle,
                      style: TextStyleUtil.genSans400(
                          fontSize: 10.ksp, color: context.black),
                    ),
                  ),
                  20.kheightBox,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0.ksp),
                    child: Row(
                      children: [
                        Expanded(
                          child: LinearProgressIndicator(
                            minHeight: 5,
                            backgroundColor: Colors.grey[300],
                            value: (progress / totalValue),
                            color: context.brandColor1,
                          ),
                        ),
                        10.kwidthBox,
                        Text(
                          "$progress/$totalValue",
                          style: TextStyleUtil.genSans400(
                            fontSize: 10.ksp,
                            color: context.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  20.kheightBox,
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
