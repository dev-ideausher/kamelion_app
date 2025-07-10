import 'package:get/get.dart';

class PersonalityResultsController extends GetxController {
  //TODO: Implement PersonalityResultsController

  final count = 0.obs;
  RxString personalityType = "".obs;
  RxString personalityDesc = "".obs;
  @override
  void onInit() {
    personalityType.value = Get.arguments[0];
    personalityDesc.value = Get.arguments[1];
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
}
