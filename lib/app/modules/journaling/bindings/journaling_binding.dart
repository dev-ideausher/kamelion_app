import 'package:get/get.dart';

import '../controllers/journaling_controller.dart';

class JournalingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JournalingController>(
      () => JournalingController(),
    );
  }
}
