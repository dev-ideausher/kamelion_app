import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/models/personality_questions_model.dart';
import 'package:kamelion/app/routes/app_pages.dart';
import 'package:kamelion/app/services/dio/api_service.dart';
import 'package:kamelion/app/services/snackbar.dart';

class PersonalityQuestionsController extends GetxController {
  //TODO: Implement PersonalityQuestionsController

  final count = 0.obs;
  RxBool isLoading = false.obs;
  String quizeId = "";
  Rx<PersonalityQuestionModel> personalityQestionsType =
      PersonalityQuestionModel().obs;
  @override
  void onInit() async {
    isLoading.value = true;
    quizeId = Get.arguments ?? "";
    await getPersonalityQuestionsTypes(quizeId);
    isLoading.value = false;
    super.onInit();
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

  getPersonalityQuestionsTypes(String id) async {
    try {
      var response = await APIManager.getPersonalityQuestions(id);

      if (response.data['data'] != null && response.data['status']) {
        personalityQestionsType =
            PersonalityQuestionModel.fromJson(response.data['data']).obs;

        // personalityQestionsType = (PersonalityQuestionModel.fromJson(data));
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

  bool hasAnySelectedScale(PersonalityQuestionModel model) {
    return model.questions?.every((question) =>
            question.scales?.any((scale) => scale.isSelected.value) ?? false) ??
        false;
  }

  markQuestion({required int qIndex, required int aIndex}) {
    final question = personalityQestionsType.value.questions![qIndex];

    // Unselect all scales for the question
    for (var scale in question.scales!) {
      scale.isSelected.value = false;
    }

    personalityQestionsType
            .value.questions![qIndex].scales![aIndex].isSelected.value =
        !personalityQestionsType
            .value.questions![qIndex].scales![aIndex].isSelected.value;
    update();
  }

  submitAnswers() {
    if (!hasAnySelectedScale(personalityQestionsType.value)) {
      showMySnackbar(msg: "Select options for all questions");
    } else {
      submitAnswersApi();
    }
  }

  void submitAnswersApi() async {
    List answers = personalityQestionsType.value.questions?.map((question) {
          int selectedIndex =
              question.scales?.indexWhere((scale) => scale.isSelected.value) ??
                  -1;

          return {
            "questionId": question.sId,
            "selectedScale": selectedIndex + 1,
          };
        }).toList() ??
        [];
    try {
      var response = await APIManager.submitPersonalityAnswers(
        body: {
          "personalityTestId": personalityQestionsType.value.sId ?? "",
          "answers": answers,
        },
        // id: user.data["data"]["_id"],
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.offNamed(Routes.PERSONALITY_RESULTS, arguments: [
          response.data['data']['personalityType'],
          response.data['data']['description']
        ]);
      } else {
        debugPrint(
          "An error occurred while getting vendor profile: ${response.data['message']}",
        );
      }
      update();
      return;
    } on DioException catch (dioError) {
      showMySnackbar(msg: dioError.response?.data['message'] ?? "");
    } catch (e, s) {
      showMySnackbar(
        // title: LocaleKeys.somethingWentWrong.tr,
        msg: e.toString(),
      );
    }
  }
}
