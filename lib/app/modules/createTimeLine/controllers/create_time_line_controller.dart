import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/constants/enums.dart';

class CreateTimeLineController extends GetxController {
  //TODO: Implement CreateTimeLineController

  final count = 0.obs;
  RxDouble moodSliderLeval = 50.0.obs;
  TextEditingController feelingsController = TextEditingController();
  RxString currentMoodSelected = Mood.normal.name.obs;
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
  final List<String> selectedFeelings = [
    "Flutter",
    "Dart",
    "Firebase",
    "API",
    "Backend",
    "Frontend",
    "UI",
    "UX",
    "Cloud",
    "Database",
  ];
  @override
  void onInit() {
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
  changeSliderValue({required double val}) {
    moodSliderLeval.value = val;
    update();
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
}
