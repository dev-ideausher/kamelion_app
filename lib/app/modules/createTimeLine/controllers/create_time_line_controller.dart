import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kamelion/app/constants/enums.dart';
import 'package:kamelion/app/modules/journaling/controllers/journaling_controller.dart';
import 'package:kamelion/app/services/storage.dart';

import '../../../constants/image_constant.dart';
import '../../../routes/app_pages.dart';
import '../../../services/dio/api_service.dart';

class CreateTimeLineController extends GetxController {
  //TODO: Implement CreateTimeLineController

  final count = 0.obs;
  RxDouble moodSliderLeval = 50.0.obs;
  TextEditingController feelingsController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController entryController = TextEditingController();
  TextEditingController activitiesController = TextEditingController();
  RxString currentMoodSelected = Mood.normal.name.obs;
  RxString currentMoodImage = ImageConstant.normalMood.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RxBool isLoading = false.obs;
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
    titleController.dispose();
    entryController.dispose();
    feelingsController.dispose();
    activitiesController.dispose();
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

  Future<void> postJournalSave() async {
    try {
      isLoading.value = true;

      final response = await APIManager.postJournalSave(body: {
        "title": titleController.text.trim(),
        "description": entryController.text.trim(),
        "emotion": currentMoodSelected.value,
        "feelings": feelingsController.text.trim(),
        "activities": activitiesController.text.trim(),
      });

      if (response.data['status'] == true) {
        Get.snackbar(
          'Success',
          'Journal entry saved successfully!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Refresh the journal list with today's date
        String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
        Get.until((route) => Get.currentRoute == Routes.JOURNALING);

        // Refresh the journal list
        if (Get.isRegistered<JournalingController>()) {
          Get.find<JournalingController>().getSavedJournals(date: today);
        }
      } else {
        Get.snackbar(
          'Error',
          response.data['message'] ?? 'Failed to save journal entry',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print('Error saving journal: $e');
      Get.snackbar(
        'Error',
        'Something went wrong. Please try again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Clear form data
  void clearForm() {
    titleController.clear();
    entryController.clear();
    feelingsController.clear();
    activitiesController.clear();
    currentMoodSelected.value = 'happy';
    currentMoodImage.value = ImageConstant.happyMood;
    moodSliderLeval.value = 50.0;
  }
}
