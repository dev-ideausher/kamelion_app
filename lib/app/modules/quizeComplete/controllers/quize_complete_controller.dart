import 'package:get/get.dart';

class QuizeCompleteController extends GetxController {
  //TODO: Implement QuizeCompleteController

  final count = 0.obs;
  RxBool? isQuizeComplete;
  RxInt coinsEarned = 0.obs;
  @override
  void onInit() {
    bool arg = Get.arguments[0];
    isQuizeComplete = arg.obs;
    coinsEarned.value = Get.arguments[1];
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
