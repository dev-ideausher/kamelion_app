import 'package:get/get.dart';

import '../controllers/quize_complete_controller.dart';

class QuizeCompleteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuizeCompleteController>(
      () => QuizeCompleteController(),
    );
  }
}
