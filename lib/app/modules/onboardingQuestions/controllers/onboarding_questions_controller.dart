import 'package:get/get.dart';
import 'package:kamelion/app/routes/app_pages.dart';
import 'package:kamelion/generated/locales.g.dart';

class OnboardingQuestionsController extends GetxController {
  //TODO: Implement OnboardingQuestionsController

  final count = 0.obs;
  RxList<RxList<String>> onboardingAnswerList = <RxList<String>>[].obs;
  RxList<String> onboardingQuestionsList = <String>[].obs;
  RxList<int?> selectedQuestionsIndexes = <int?>[].obs;
  RxInt currentQuetionIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    onboardingQuestionsList =
        [
          LocaleKeys.onboardingQuestion1.tr,
          LocaleKeys.onboardingQuestion2.tr,
          LocaleKeys.onboardingQuestion3.tr,
          LocaleKeys.onboardingQuestion4.tr,
          LocaleKeys.onboardingQuestion5.tr,
          LocaleKeys.onboardingQuestion6.tr,
        ].obs;
    onboardingAnswerList =
        [
          [
            LocaleKeys.onboardingAnswer1_1.tr,
            LocaleKeys.onboardingAnswer1_2.tr,
            LocaleKeys.onboardingAnswer1_3.tr,
            LocaleKeys.onboardingAnswer1_4.tr,
          ].obs,
          [
            LocaleKeys.onboardingAnswer2_1.tr,
            LocaleKeys.onboardingAnswer2_2.tr,
            LocaleKeys.onboardingAnswer2_3.tr,
            LocaleKeys.onboardingAnswer2_4.tr,
          ].obs,
          [
            LocaleKeys.onboardingAnswer3_1.tr,
            LocaleKeys.onboardingAnswer3_2.tr,
            LocaleKeys.onboardingAnswer3_3.tr,
            LocaleKeys.onboardingAnswer3_4.tr,
          ].obs,
          [
            LocaleKeys.onboardingAnswer4_1.tr,
            LocaleKeys.onboardingAnswer4_2.tr,
            LocaleKeys.onboardingAnswer4_3.tr,
            LocaleKeys.onboardingAnswer4_4.tr,
          ].obs,
          [
            LocaleKeys.onboardingAnswer5_1.tr,
            LocaleKeys.onboardingAnswer5_2.tr,
            LocaleKeys.onboardingAnswer5_3.tr,
            LocaleKeys.onboardingAnswer5_4.tr,
          ].obs,
        ].obs;
    for (int i = 0; i < onboardingQuestionsList.length; i++) {
      if (i == (onboardingQuestionsList.length - 1))
        selectedQuestionsIndexes.add(4);
      else
        selectedQuestionsIndexes.add(null);
    }
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

  void selectAnswer({
    required int questionIndex,
    required int answerIndex,
  }) async {
    selectedQuestionsIndexes[questionIndex] = answerIndex;
    // await Future.delayed(Duration(seconds: 1));
    if (onboardingQuestionsList.length > (currentQuetionIndex.value + 1)) {
      currentQuetionIndex++;
    }
    update();
  }

  void goToPreviousQuestion() {
    if (currentQuetionIndex != 0) {
      currentQuetionIndex--;
    } else {
      Get.back();
    }
    update();
  }

  void submitAnswers() {
    Get.toNamed(Routes.GET_STARTED, arguments: true);
  }
}
