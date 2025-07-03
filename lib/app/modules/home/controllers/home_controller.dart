import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kamelion/app/components/feelings_selection_widget.dart';
import 'package:kamelion/app/constants/image_constant.dart';
import 'package:kamelion/app/models/mental_gym_model.dart';
import 'package:kamelion/app/models/mood_model.dart';
import 'package:kamelion/app/models/user_model.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/dio/api_service.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/snackbar.dart';
import 'package:kamelion/generated/locales.g.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final count = 0.obs;
  RxBool isLoading = false.obs;
  // Use this

  Map timezoneNames = {
    0: 'UTC',
    10800000: 'Indian/Mayotte',
    3600000: 'Europe/London',
    7200000: 'Europe/Zurich',
    -32400000: 'Pacific/Gambier',
    -28800000: 'US/Alaska',
    -14400000: 'US/Eastern',
    -10800000: 'Canada/Atlantic',
    -18000000: 'US/Central',
    -21600000: 'US/Mountain',
    -25200000: 'US/Pacific',
    -7200000: 'Atlantic/South_Georgia',
    -9000000: 'Canada/Newfoundland',
    39600000: 'Pacific/Pohnpei',
    25200000: 'Indian/Christmas',
    36000000: 'Pacific/Saipan',
    18000000: 'Indian/Maldives',
    46800000: 'Pacific/Tongatapu',
    21600000: 'Indian/Chagos',
    43200000: 'Pacific/Wallis',
    14400000: 'Indian/Reunion',
    28800000: 'Australia/Perth',
    32400000: 'Pacific/Palau',
    19800000: 'Asia/Kolkata',
    16200000: 'Asia/Kabul',
    20700000: 'Asia/Kathmandu',
    23400000: 'Indian/Cocos',
    12600000: 'Asia/Tehran',
    -3600000: 'Atlantic/Cape_Verde',
    37800000: 'Australia/Broken_Hill',
    34200000: 'Australia/Darwin',
    31500000: 'Australia/Eucla',
    49500000: 'Pacific/Chatham',
    -36000000: 'US/Hawaii',
    50400000: 'Pacific/Kiritimati',
    -34200000: 'Pacific/Marquesas',
    -39600000: 'Pacific/Pago_Pago',
  };
  String userTimezone = "";
  // timezoneNames[DateTime.now().timeZoneOffset.inMilliseconds];
  Rx<UserModel> currentUser = UserModel().obs;
  RxList<MoodModel> currentMoodsList = <MoodModel>[].obs;
  final List<Map<String, dynamic>> moodsToShow = [
    {"image": ImageConstant.unHappyMood, "label": LocaleKeys.unhappy.tr},
    {"image": ImageConstant.sadMood, "label": LocaleKeys.sad.tr},
    {"image": ImageConstant.normalMood, "label": LocaleKeys.normal.tr},
    {"image": ImageConstant.goodMood, "label": LocaleKeys.good.tr},
    {"image": ImageConstant.happyMood, "label": LocaleKeys.happy.tr},
  ];
  final List<Map<String, dynamic>> mentalGymList = [
    {
      "image": ImageConstant.myCharacterLogo,
      "label": LocaleKeys.my_character.tr,
    },
    {"image": ImageConstant.socialLifeIcon, "label": LocaleKeys.social_life.tr},
    {"image": ImageConstant.healthIcon, "label": LocaleKeys.health_fitness.tr},
    {"image": ImageConstant.healthIcon, "label": LocaleKeys.my_mind.tr},
  ];
  RxList<MentalGymModel> popularMentalGyms = <MentalGymModel>[].obs;

  @override
  void onInit() async {
    isLoading.value = true;
    await getUser();
    await getTodaysMood();
    await getPopularMentalGym();
    userTimezone = timezoneNames[DateTime.now().timeZoneOffset.inMilliseconds];
    isLoading.value = false;
    super.onInit();
  }

  @override
  void onReady() {
    // getTodaysMood();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  Future<void> getUser() async {
    try {
      var response;

      response = await APIManager.getUser();

      if (response.data['data'] != null && response.data['status']) {
        currentUser = UserModel.fromJson(response.data['data']).obs;
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

  Future<void> getTodaysMood() async {
    try {
      currentMoodsList = <MoodModel>[].obs;
      var response;
      response = await APIManager.getTodaysMood(timezone: userTimezone);

      if (response.data['data'] != null && response.data['status']) {
        for (Map<String, dynamic> data in response.data['data']) {
          currentMoodsList.add(MoodModel.fromJson(data));
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

  String getMoodImage({required String mood}) {
    mood = mood.toLowerCase();
    if (mood == LocaleKeys.unhappy) {
      return ImageConstant.unHappyMood;
    } else if (mood == LocaleKeys.sad) {
      return ImageConstant.sadMood;
    } else if (mood == LocaleKeys.normal) {
      return ImageConstant.normalMood;
    } else if (mood == LocaleKeys.good) {
      return ImageConstant.goodMood;
    } else if (mood == LocaleKeys.happy) {
      return ImageConstant.happyMood;
    } else {
      return ImageConstant.happyMood;
    }
  }

  Future<void> getPopularMentalGym() async {
    try {
      var response;

      response = await APIManager.getPopularMentalGyms(limit: "100", page: "1");
      if (response.data['data'] != null && response.data['status']) {
        for (Map<String, dynamic> data in response.data['data']) {
          popularMentalGyms.add(MentalGymModel.fromJson(data));
        }
        log(popularMentalGyms.value.length.toString());
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

  void showMoodPopup(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 8.ksp),
        backgroundColor: Colors.transparent,
        child: Container(
          color: context.white,
          child: FeelingSelectionWidget(moodsToShow: moodsToShow),
        ), // your custom widget here
      ),
    );
  }
}
