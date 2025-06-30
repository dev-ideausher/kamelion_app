import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kamelion/app/models/mood_entry_model.dart';

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
  final entries = <MoodEntry>[].obs;
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



  Future<void> getMoods({ required String date }) async {
    try {
      isLoading.value = true;
      final params = 'date=${Uri.encodeComponent(date)}';
      selectedDate.value = date;
      entries.clear();

      final response = await APIManager.getMoods(params: params);
      if (response.data['status'] == true && response.data['data'] != null) {
        totalJournal.value = response.data['totalCount'] ?? 0;
        final List<dynamic> raw = response.data['data'];
        entries.value = raw.map((j) => MoodEntry.fromJson(j)).toList();
      } else {
        entries.clear();
      }
    } catch (e) {
      debugPrint('Error fetching moods: $e');
      entries.clear();
    } finally {
      isLoading.value = false;
    }
  }

  void onDateSelected(DateTime date) {

    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    selectedDate.value=formattedDate;
    getMoods(date: formattedDate);
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





}
