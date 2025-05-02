import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/constants/image_constant.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/generated/locales.g.dart';

class ProfileController extends GetxController
    with GetTickerProviderStateMixin {
  //TODO: Implement ProfileController

  final count = 0.obs;
  late TabController profilePageTabController;
  late TabController leaderboardTabController;
  RxList leaderboardList =
      [
        "Name",
        "Name",
        "Name",
        "Name",
        "Name",
        "Name",
        "Name",
        "Name",
        "Name",
      ].obs;
  List statesIcon = [
    ImageConstant.calenderIcon,
    ImageConstant.pencilIcon,
    ImageConstant.smileIcon,
    ImageConstant.notebookIcon,
  ];
  RxList statesCounts = ["9", "1,871", "48", "22"].obs;
  List statesValue = [
    LocaleKeys.total_days.tr,
    LocaleKeys.words_written.tr,
    LocaleKeys.mood_tracked.tr,
    LocaleKeys.journal_entries.tr,
  ];
  List stateCardsColors = [];

  @override
  void onInit() {
    super.onInit();
    profilePageTabController = TabController(length: 2, vsync: this);
    leaderboardTabController = TabController(length: 2, vsync: this);
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

  void getColorsForStats(BuildContext context) {
    stateCardsColors = [
      ColorUtil(context).greenCardBg,
      ColorUtil(context).brandColor3,
      ColorUtil(context).redBg,
      ColorUtil(context).pitcgBg,
    ];
  }
}
