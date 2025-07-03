import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kamelion/app/constants/enums.dart';
import 'package:kamelion/app/modules/home/controllers/home_controller.dart';
import 'package:kamelion/app/modules/mood_tracker/controllers/mood_tracker_controller.dart';
import 'package:kamelion/app/services/dialog_helper.dart';
import 'package:kamelion/app/services/dio/api_service.dart';
import 'package:kamelion/app/services/snackbar.dart';

import '../../../constants/image_constant.dart';

class MoodSelectionFormController extends GetxController {
  //TODO: Implement MoodSelectionFormController

  final count = 0.obs;
  RxDouble moodSliderLeval = 50.0.obs;
  String? time;
  TextEditingController feelingsController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController activitiesController = TextEditingController();
  RxString currentMoodSelected = Mood.normal.name.obs;
  RxString currentMoodImage = ImageConstant.normalMood.obs;
  String timezone = "IST";
  List<String> feelingsKeywords = [
    "Happy",
    "Sad",
    "Angry",
    "Excited",
    "Anxious",
    "Tired",
    "Relaxed",
    "Lonely",
    "Grateful",
    "Confused",
    "Motivated",
    "Bored",
    "Overwhelmed",
    "Hopeful",
    "Stressed",
  ];

  @override
  void onInit() {
    if (Get.arguments != null && Get.arguments['mood'] != null) {
      currentMoodSelected.value =
          Get.arguments['mood'].toString().split('.').last;
      if (currentMoodSelected.value == "sad") {
        currentMoodImage.value = ImageConstant.sadMood;
        changeSliderValue(val: 25);
      } else if (currentMoodSelected.value == "unhappy") {
        currentMoodImage.value = ImageConstant.unHappyMood;
        changeSliderValue(val: 0);
      } else if (currentMoodSelected.value == "happy") {
        currentMoodImage.value = ImageConstant.happyMood;
        changeSliderValue(val: 100);
      } else if (currentMoodSelected.value == "normal") {
        currentMoodImage.value = ImageConstant.normalMood;
        changeSliderValue(val: 50);
      } else if (currentMoodSelected.value == "good") {
        currentMoodImage.value = ImageConstant.goodMood;
        changeSliderValue(val: 75);
      }
    }

    if (Get.arguments != null && Get.arguments['note'] != null) {
      currentMoodSelected.value =
          Get.arguments['mood'].toString().split('.').last;
      noteController.text = Get.arguments['note'];
      feelingsController.text = Get.arguments['feeling'];
      activitiesController.text = Get.arguments['activities'];
      time = Get.arguments['time'];
    }
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

  // changeSliderValue({required double val}) {
  //   moodSliderLeval.value = val;
  //   update();
  // }
  void changeSliderValue({required double val}) {
    moodSliderLeval.value = val;
    // Set mood based on value range
    if (val <= 20) {
      currentMoodImage.value = ImageConstant.unHappyMood;
      currentMoodSelected.value = Mood.unhappy.name;
    } else if (val <= 40) {
      currentMoodImage.value = ImageConstant.sadMood;
      currentMoodSelected.value = Mood.sad.name;
    } else if (val <= 60) {
      currentMoodImage.value = ImageConstant.normalMood;
      currentMoodSelected.value = Mood.normal.name;
    } else if (val <= 80) {
      currentMoodImage.value = ImageConstant.goodMood;
      currentMoodSelected.value = Mood.good.name;
    } else {
      currentMoodImage.value = ImageConstant.happyMood;
      currentMoodSelected.value = Mood.happy.name;
    }
  }

  onFeelingSelected({required String keyword}) {
    if (feelingsController.text.toString().length >= 2 &&
        (feelingsController.text
                .toString()[feelingsController.text.toString().length - 2] !=
            ",")) {
      feelingsController.text = feelingsController.text + ", ";
    }
    feelingsController.text = feelingsController.text + keyword + ", ";
    update();
  }

  Future<void> addMood() async {
    try {
      var response;
      DialogHelper.showLoading();
      response = await APIManager.addMood(
        activities: activitiesController.text,
        feelings: feelingsController.text.split(','),
        mood: currentMoodSelected.value,
        note: noteController.text,
      );

      if (response.data['data'] != null && response.data['status']) {
        Get.back();
        Get.back();
        DialogHelper.hideDialog();
        Get.find<HomeController>().getTodaysMood();
        String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
        final moodController = Get.isRegistered<MoodTrackerController>()
            ? Get.find<MoodTrackerController>()
            : Get.put(MoodTrackerController());
        moodController.getMoods(date: today);
        showMySnackbar(msg: "Mood added");
      } else {
        debugPrint(
          "An error occurred while getting vendor profile: ${response.data['message']}",
        );
        showMySnackbar(msg: response.data['message'] ?? "");
        DialogHelper.hideDialog();
      }
      update();
      // return;
    } on DioException catch (dioError) {
      showMySnackbar(msg: dioError.message ?? "");
      DialogHelper.hideDialog();
    } catch (e) {
      showMySnackbar(msg: e.toString());
      DialogHelper.hideDialog();
    }
  }
}
