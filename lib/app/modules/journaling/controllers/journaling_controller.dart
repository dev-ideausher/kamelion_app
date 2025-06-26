import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kamelion/app/models/time_line_post.dart';
import 'package:kamelion/app/services/responsive_size.dart';

import '../../../constants/image_constant.dart';
import '../../../models/journal_list_item.dart';
import '../../../models/journals_model.dart';
import '../../../routes/app_pages.dart';
import '../../../services/dio/api_service.dart';

class JournalingController extends GetxController
    with GetTickerProviderStateMixin {
  //TODO: Implement JournalingController

  final count = 0.obs;
  late TabController calanderTabController;
  RxInt currentCatenderIndex = 0.obs;
  RxString selectedDate = "".obs;
  final RxList<JournalEntry> entries = <JournalEntry>[].obs;
  final RxBool isLoading = false.obs;
  late TabController tabController;
  TextEditingController searchController=TextEditingController();
  RxInt totalJournal=0.obs;
  List<JournalListItem> get groupedList {
    if (entries.isEmpty) return [];

    final sorted = entries.toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    final items = <JournalListItem>[];
    DateTime? lastDate;

    for (var e in sorted) {
      final day = DateTime(e.createdAt.year, e.createdAt.month, e.createdAt.day);
      if (lastDate == null || day != lastDate) {
        items.add(DateHeader(day));
        lastDate = day;
      }
      items.add(EntryItem(e));
    }
    return items;
  }
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


  Future<void> getSavedJournals({
    String? date,
    String? searchQuery,
}) async {
    try {
      isLoading.value = true;

      String params;
      if (searchQuery != null && searchQuery.trim().isNotEmpty) {
        params = 'search=${Uri.encodeComponent(searchQuery.trim())}';
        // Clear date filter so FAB disappears?
        // selectedDate.value = '';
      } else if (date != null) {
        params = 'date=${Uri.encodeComponent(date)}';
        selectedDate.value = date;
      } else {
        // no filters → fetch all
        params = '';
        // selectedDate.value = '';
      }
      entries.clear();
      var response = await APIManager.getAllJournals(params: params);

      if (response.data['status'] == true && response.data['data'] != null) {
        List<dynamic> journalData = response.data['data'];
        totalJournal.value=response.data['totalJournalCountThisYear']??0;
        entries.value = journalData
            .map((json) => JournalEntry.fromJson(json))
            .toList();
      } else {
        entries.clear();
      }
    } catch (e) {
      print('Error fetching journals: $e');
      entries.clear();
    } finally {
      isLoading.value = false;
    }
  }
  void onDateSelected(DateTime date) {

    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    selectedDate.value=formattedDate;
    getSavedJournals(date: formattedDate);
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


  void onJournalDelete(JournalEntry entry) async {
    try {
      final res = await APIManager.deleteJournal(id: entry.id);

      if (res.data['status'] == true) {
        // Optional: Show success snackbar/toast
        Get.snackbar("Success", "Journal entry deleted");

        // 1. Remove from current list
       entries.removeWhere((e) => e.id == entry.id);

        // 2. Optional: re-filter based on selected date


        // 3. Force UI update (if not using .obs on entries)
        update();
      } else {
        Get.snackbar("Error", res.data['message'] ?? "Failed to delete entry");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    }
  }

}
