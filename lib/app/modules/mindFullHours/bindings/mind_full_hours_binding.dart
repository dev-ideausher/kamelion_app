import 'package:get/get.dart';

import '../controllers/mind_full_hours_controller.dart';

class MindFullHoursBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MindFullHoursController>(
      () => MindFullHoursController(),
    );
  }
}
