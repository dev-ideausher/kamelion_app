import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/constants/image_constant.dart';
import 'package:kamelion/app/models/badges_model.dart';
import 'package:kamelion/app/models/leadeboard_user_model.dart';
import 'package:kamelion/app/models/my_stats_model.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/dio/api_service.dart';
import 'package:kamelion/app/services/snackbar.dart';
import 'package:kamelion/generated/locales.g.dart';

class ProfileController extends GetxController
    with GetTickerProviderStateMixin {
  //TODO: Implement ProfileController

  final count = 0.obs;
  late TabController profilePageTabController;
  late TabController leaderboardTabController;
  RxList leaderboardList = [
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
  RxList<LeaderBoardUserModel> leaderBoardList = <LeaderBoardUserModel>[].obs;
  List statesIcon = [
    ImageConstant.dumbelWhiteIcon,
    ImageConstant.pencilIcon,
    ImageConstant.smileIcon,
    ImageConstant.notebookIcon,
  ];
  RxList statesCounts = ["9", "1,871", "48", "22"].obs;
  List statesValue = [
    "Exercises Done",
    LocaleKeys.words_written.tr,
    LocaleKeys.mood_tracked.tr,
    LocaleKeys.journal_entries.tr,
  ];
  List stateCardsColors = [];
  RxBool isLoading = false.obs;
  Rx<MyStatsModel> myStatesData = MyStatsModel().obs;

  @override
  void onInit() async {
    super.onInit();
    isLoading = true.obs;
    profilePageTabController = TabController(length: 2, vsync: this);
    leaderboardTabController = TabController(length: 2, vsync: this);
    await getLeaderBoardStats();
    await getMyStats();
    isLoading = false.obs;
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

  Future<void> getLeaderBoardStats() async {
    try {
      var response;

      response = await APIManager.getLeaderboard();

      if (response.data['data'] != null && response.data['status']) {
        leaderBoardList.value = [];
        for (Map<String, dynamic> data in response.data['data']) {
          leaderBoardList.add(LeaderBoardUserModel.fromJson(data));
        }
      } else {
        debugPrint(
          "An error occurred while gettxing vendor profile: ${response.data['message']}",
        );
        showMySnackbar(msg: response.data['message'] ?? "");
      }
      leaderBoardList.refresh();
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

  Future<void> getMyStats() async {
    try {
      var response;

      response = await APIManager.getMyStats();

      if (response.data['success']) {
        myStatesData = MyStatsModel.fromJson(response.data['data']).obs;
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
}
