import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/modules/challenges/views/active_challenges.dart';
import 'package:kamelion/app/modules/challenges/views/all_challenges.dart';
import 'package:kamelion/app/modules/challenges/views/completed_challenges.dart';
import 'package:kamelion/app/modules/mentalGym/views/active_workout.dart';
import 'package:kamelion/app/modules/mentalGym/views/all_workouts.dart';

class ChallengesController extends GetxController
    with GetTickerProviderStateMixin {
  //TODO: Implement ChallengesController

  final count = 0.obs;
  late TabController challengePageTabController;
  RxInt selectedScreenIndex = 0.obs;
  List<Widget> screensList =
      [AllChallenges(), ActiveChallenges(), CompletedChallenges()].obs;
  @override
  void onInit() {
    super.onInit();
    challengePageTabController = TabController(length: 2, vsync: this);
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
}
