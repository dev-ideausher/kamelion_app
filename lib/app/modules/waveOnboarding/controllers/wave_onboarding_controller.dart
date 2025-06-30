import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class WaveOnboardingController extends GetxController {
  //TODO: Implement WaveOnboardingController

  final count = 0.obs;

  @override
  onInit() async {
    await Future.delayed(Duration(seconds: 4)).then((v)=>Get.offAllNamed(Routes.NAVIGATION_BAR, arguments: true));

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
