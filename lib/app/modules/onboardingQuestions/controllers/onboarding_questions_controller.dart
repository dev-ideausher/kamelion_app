import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/models/mental_gyms_details_model.dart';
import 'package:kamelion/app/models/onBoardingQuestionsModel.dart';
import 'package:kamelion/app/modules/home/controllers/home_controller.dart';
import 'package:kamelion/app/modules/workoutDetails/controllers/workout_details_controller.dart';
import 'package:kamelion/app/routes/app_pages.dart';
import 'package:kamelion/app/services/dio/api_service.dart';
import 'package:kamelion/app/services/snackbar.dart';
import 'package:kamelion/app/services/storage.dart';
import 'package:kamelion/generated/locales.g.dart';

class OnboardingQuestionsController extends GetxController {
  //TODO: Implement OnboardingQuestionsController

  final count = 0.obs;
  ScrollController scrollController = ScrollController();
  // RxList<RxList<String>> onboardingAnswerList = <RxList<String>>[].obs;
  RxList<OnBoardingQuestionsModel> onboardingQuestionsList =
      <OnBoardingQuestionsModel>[].obs;
  // RxList<List<int?>> selectedQuestionsIndexes = <List<int?>>[].obs;
  RxInt currentQuetionIndex = 0.obs;

  @override
  void onInit() async {
    super.onInit();
    String fromPage = Get.arguments ?? "";
    if (fromPage == Routes.GET_STARTED) {
      await getOnboardingQuestions();
    } else {
      getMentalGymQuestions(
        fromPage,
      );
    }

    // print(onboardingQuestionsList[currentQuetionIndex.value].options![0]);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getOnboardingQuestions() async {
    try {
      var response = await APIManager.getOnboardingQuestion();

      if (response.data['data'] != null && response.data['status']) {
        for (Map<String, dynamic> data in response.data['data']) {
          onboardingQuestionsList.add(OnBoardingQuestionsModel.fromJson(data));
        }
      } else {
        debugPrint(
          "An error occurred while getting vendor profile: ${response.data['message']}",
        );
      }
      update();
      return;
    } catch (e) {
      debugPrint("An exception occurred while getting vendor details! $e");
      showMySnackbar(title: "Error", msg: e.toString());
      return;
    }
  }

  getMentalGymQuestions(String id) async {
    try {
      var response = await APIManager.getMentalGymQuestions(id);

      if (response.data['data'] != null && response.data['status']) {
        for (Map<String, dynamic> data in response.data['data']) {
          onboardingQuestionsList.add(OnBoardingQuestionsModel.fromJson(data));
        }
      } else {
        debugPrint(
          "An error occurred while getting vendor profile: ${response.data['message']}",
        );
      }
      update();
      return;
    } catch (e) {
      debugPrint("An exception occurred while getting vendor details! $e");
      showMySnackbar(title: "Error", msg: e.toString());
      return;
    }
  }

  void increment() => count.value++;

  void selectAnswer({
    required int questionIndex,
    required int answerIndex,
  }) async {
    if (onboardingQuestionsList[questionIndex].isOptionSelected[answerIndex] ==
        0) {
      onboardingQuestionsList[questionIndex].isOptionSelected[answerIndex] = 1;
    } else {
      onboardingQuestionsList[questionIndex].isOptionSelected[answerIndex] = 0;
    }
    update();
  }

  void goToNextQuestion() {
    if (onboardingQuestionsList.length > (currentQuetionIndex.value + 1)) {
      scrollController.animateTo(
        0.0,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      currentQuetionIndex++;
    }
  }

  void goToPreviousQuestion() {
    if (currentQuetionIndex != 0) {
      scrollController.animateTo(
        0.0,
        duration: Duration(milliseconds: 100),
        curve: Curves.easeInOut,
      );
      currentQuetionIndex--;
    } else {
      Get.back();
    }
    update();
  }

  void submitAnswers() async {
    // if (Get.previousRoute == Routes.WORKOUT_DETAILS) {
    //   // Get.back();
    //   // Get.back();
    //   // Get.back();
    //   Get.offNamed(Routes.QUIZE_COMPLETE);
    //   Get.find<HomeController>().getUser();
    // } else
    if (Get.previousRoute == Routes.GET_STARTED) {
      try {
        var user = await APIManager.getUser();
        List answers = onboardingQuestionsList.map((question) {
          if (question.questionType == "MCQ") {
            return {
              'questionId': question.sId,
              'selectedOptions': question.options!
                  .asMap()
                  .entries
                  .where(
                    (entry) => (question.questionType == "MCQ" &&
                        question.isOptionSelected[entry.key] == 1),
                  )
                  .map((entry) => entry.value)
                  .toList(),
            };
          } else if (question.questionType == "SLIDER") {
            return {
              'questionId': question.sId,
              'selectedOptions': ["${question.isOptionSelected[0]}"],
            };
          }
        }).toList();
        print(answers);

        var response = await APIManager.submitOnboardingAnswer(
          body: {"answers": answers, "userType": "User"},
          id: user.data["data"]["_id"],
        );

        if (response.statusCode == 200) {
          Get.offAllNamed(Routes.GET_STARTED, arguments: true);
        } else {
          debugPrint(
            "An error occurred while getting vendor profile: ${response.data['message']}",
          );
        }
        update();
        return;
      } catch (e) {
        debugPrint("An exception occurred while getting vendor details! $e");
        showMySnackbar(title: "Error", msg: e.toString());
        return;
      }
    } else {
      submitWorkoutQuize();
      // Get.offNamed(Routes.QUIZE_COMPLETE);
    }
  }

  void submitWorkoutQuize() async {
    List answers = onboardingQuestionsList.map((question) {
      if (question.questionType == "MCQ" ||
          question.questionType == "MCQ Based") {
        return {
          "question": question.sId,
          "selectedOptionIndex": question.isOptionSelected!.indexOf(1)
        };
      } else if (question.questionType == "SLIDER") {
        return {
          {
            "question": question.sId,
            "selectedOptionIndex": "${question.isOptionSelected[0]}"
          }
        };
      }
    }).toList();

    bool hasUnselected = answers.any((q) => q['selectedOptionIndex'] == -1);

    if (hasUnselected) {
      showMySnackbar(msg: "Select answers to all questions");
      return;
    }

    var response = await APIManager.submitMentalGymAnswer(
      body: {
        "answers": answers,
        "quizId": onboardingQuestionsList[0].quizListId,
      },
      // id: user.data["data"]["_id"],
    );

    if (response.statusCode == 200) {
      Get.offNamed(Routes.QUIZE_COMPLETE, arguments: [
        response.data['data']['isCompleted'],
        response.data['data']['earnedKalikoins']
      ]);
      Get.find<HomeController>().getUser();
    } else {
      debugPrint(
        "An error occurred while getting vendor profile: ${response.data['message']}",
      );
    }
    update();
    return;
  }
}
