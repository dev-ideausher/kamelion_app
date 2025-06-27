import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../constants/image_constant.dart';
import '../../../models/journal_list_item.dart';
import '../../../models/journals_model.dart';
import '../../../routes/app_pages.dart';
import '../../../services/dio/api_service.dart';

class MoodTrackerController extends GetxController    with GetTickerProviderStateMixin {
  //TODO: Implement JournalingController

  final count = 0.obs;
  late TabController calanderTabController;
  RxInt currentCatenderIndex = 0.obs;
  RxString selectedDate = "".obs;

  final RxBool isLoading = false.obs;
  late TabController tabController;
  TextEditingController searchController=TextEditingController();
  RxInt totalJournal=0.obs;

  @override
  void onInit() {
    super.onInit();
    calanderTabController = TabController(length: 2, vsync: this);
    tabController=TabController(length: 2, vsync: this);
    // String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    // getSavedJournals(today);
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

  changeCurrentCalenderIndex(int val) {
    currentCatenderIndex.value = val;
    update();
  }



  void onDateSelected(DateTime date) {

    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    selectedDate.value=formattedDate;

  }

  // Helper method for mood colors (keep your existing implementation)
  Color getMoodColor(String mood) {
    switch (mood.toLowerCase()) {
      case 'peaceful':
        return Colors.blue;
      case 'happy':
        return Colors.orange;
      case 'sad':
        return Colors.grey;
      case 'anxious':
        return Colors.red;
      case 'excited':
        return Colors.purple;
      default:
        return Colors.green;
    }
  }
  String getMoodImagePath(String mood) {
    switch (mood.toLowerCase()) {
      case 'happy':
        return ImageConstant.happyMood;
      case 'sad':
        return ImageConstant.sadMood;
      case 'good':
        return ImageConstant.goodMood; // or use happyMood if you don't have goodMood
      case 'normal':
        return ImageConstant.normalMood; // or use a neutral mood image
      case 'unhappy':
        return ImageConstant.unHappyMood;

      default:
        return ImageConstant.happyMood; // Default fallback
    }
  }
  void onEdit(JournalEntry  entry) {
    Get.toNamed(Routes.UPDATE_TIMELINE,arguments: {'id':entry.id,'viewOnly':false});
  }



  final entries = <MoodEntry>[
    MoodEntry(
      time: '08:00 AM',
      mood: 'happy',
      title: 'Morning Joy',
      description: 'Started the day with a smile.',
      imagePath: ImageConstant.happyMood,
    ),
    MoodEntry(
      time: '12:30 PM',
      mood: 'normal',
      title: 'Afternoon Neutral',
      description: 'Just another midday.',
      imagePath: ImageConstant.normalMood,
    ),
    MoodEntry(
      time: '06:45 PM',
      mood: 'sad',
      title: 'Evening Blues',
      description: 'Felt a bit down after work.',
      imagePath: ImageConstant.sadMood,
    ),
    MoodEntry(
      time: '10:15 PM',
      mood: 'good',
      title: 'Night Reflection',
      description: 'Ended the day on a positive note.',
      imagePath: ImageConstant.goodMood,
    ),
  ];

}
class MoodEntry {
  final String time;
  final String mood;
  final String title;
  final String description;
  final String imagePath;

  MoodEntry({
    required this.time,
    required this.mood,
    required this.title,
    required this.description,
    required this.imagePath,
  });
}