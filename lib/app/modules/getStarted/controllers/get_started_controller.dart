import 'package:get/get.dart';
import 'package:kamelion/app/routes/app_pages.dart';

class GetStartedController extends GetxController {
  //TODO: Implement GetStartedController

  final count = 0.obs;
  bool isOnboardingFormSubmited = false;
  @override
  void onInit() {
    super.onInit();
    isOnboardingFormSubmited = Get.arguments ?? false;
  }

  @override
  void onReady() {
    super.onReady();
    isOnboardingFormSubmited = Get.arguments ?? false;
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  void onButtonClick() {
    if (isOnboardingFormSubmited)
      Get.toNamed(Routes.CREATE_AVATAR);
    else
      Get.toNamed(Routes.ONBOARDING_QUESTIONS);
  }
}
