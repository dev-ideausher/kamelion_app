import 'package:get/get.dart';

import '../controllers/start_quize_controller.dart';

class StartQuizeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StartQuizeController>(
      () => StartQuizeController(),
    );
  }
}
