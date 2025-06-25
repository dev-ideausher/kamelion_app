import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/models/time_line_post.dart';
import 'package:kamelion/app/services/responsive_size.dart';

class JournalingController extends GetxController
    with GetTickerProviderStateMixin {
  //TODO: Implement JournalingController

  final count = 0.obs;
  late TabController calanderTabController;
  RxInt currentCatenderIndex = 0.obs;
  final List<TimelineEntry> entries = [
    TimelineEntry(
      time: '10:00',
      title: 'Feeling Positive Today! 😄',
      description:
          'I’m grateful for the supportive phone call I had with my best friend.',
      mood: 'Happy',
      image: 'assets/happy.png',
    ),
    TimelineEntry(
      time: '09:00',
      title: 'Got A Gift from my BF, OMG!',
      description:
          'I experienced pure joy today while playing with my dog in the park.',
      mood: 'Good',
      image: 'assets/gift.png',
    ),
    TimelineEntry(
      time: '08:00',
      title: 'Felt Sad & Grief. IDK what 😞',
      description:
          'Feeling sad today after hearing a touching but heartbreaking news...',
      mood: 'Sad',
      image: 'assets/sad.png',
    ),
  ];
  @override
  void onInit() {
    super.onInit();
    calanderTabController = TabController(length: 2, vsync: this);
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
}
