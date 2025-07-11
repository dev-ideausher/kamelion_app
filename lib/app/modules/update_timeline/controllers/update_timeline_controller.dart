import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../constants/enums.dart';
import '../../../constants/image_constant.dart';
import '../../../models/journal_details_model.dart';
import '../../../routes/app_pages.dart';
import '../../../services/dio/api_service.dart';
import '../../journaling/controllers/journaling_controller.dart';

class UpdateTimelineController extends GetxController {
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
  var journalId = ''.obs;
  var viewOnly = false.obs;
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
    super.onInit();
    journalId.value = Get.arguments['id'] as String;
    viewOnly.value = Get.arguments['viewOnly'] ?? false;
    _loadJournalDetails();
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

  Future<void> _loadJournalDetails() async {
    isLoading.value = true;
    try {
      final response = await APIManager.getJournalById(id: journalId.value);
      final body = response.data;

      if (body['status'] == true && body['data'] != null) {
        final details = JournalDetailsData.fromJson(body['data']);

        // populate controllers
        titleController.text = details.title ?? "";
        entryController.text = details.description ?? "";
        feelingsController.text = details.feelings ?? "";
        activitiesController.text = details.activities ?? "";

        // populate mood (map your emotion string back to slider + image)
        final emotion = details.emotion ?? "";
        _setMoodFromString(emotion);
      }
    } catch (e) {
      print("Error loading journal details: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// helper that sets slider, image, and selected text from an emotion string
  void _setMoodFromString(String mood) {
    switch (mood.toLowerCase()) {
      case 'sad':
        moodSliderLeval.value = 0;
        currentMoodImage.value = ImageConstant.sadMood;
        currentMoodSelected.value = 'sad';
        break;
      case 'unhappy':
        moodSliderLeval.value = 25;
        currentMoodImage.value = ImageConstant.unHappyMood;
        currentMoodSelected.value = 'unHappy';
        break;
      case 'normal':
        moodSliderLeval.value = 50;
        currentMoodImage.value = ImageConstant.normalMood;
        currentMoodSelected.value = 'Normal';
        break;
      case 'good':
        moodSliderLeval.value = 75;
        currentMoodImage.value = ImageConstant.goodMood;
        currentMoodSelected.value = 'Good';
        break;
      case 'happy':
        moodSliderLeval.value = 100;
        currentMoodImage.value = ImageConstant.happyMood;
        currentMoodSelected.value = 'Happy';
        break;
      default:
        // fallback
        moodSliderLeval.value = 50;
        currentMoodImage.value = ImageConstant.normalMood;
        currentMoodSelected.value = mood.capitalize ?? "Normal";
    }
  }

  Future<void> updateJournal() async {
    try {
      isLoading.value = true;

      final response =
          await APIManager.updateJournal(id: journalId.value, body: {
        "title": titleController.text.trim(),
        "description": entryController.text.trim(),
        "emotion": currentMoodSelected.value,
        "feelings": feelingsController.text.trim(),
        "activities": activitiesController.text.trim(),
      });

      if (response.data['status'] == true) {
        Get.snackbar(
          'Success',
          'Journal entry updated successfully!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Refresh the journal list with today's date
        String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
        Get.until((route) => Get.currentRoute == Routes.JOURNALING);

        // Refresh the journal list
        if (Get.isRegistered<JournalingController>()) {
          Get.find<JournalingController>().getSavedJournals(
              date: Get.find<JournalingController>().selectedDate.value);
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
}
