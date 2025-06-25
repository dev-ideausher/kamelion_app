import 'package:get/get.dart';

import '../controllers/create_time_line_controller.dart';

class CreateTimeLineBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateTimeLineController>(
      () => CreateTimeLineController(),
    );
  }
}
