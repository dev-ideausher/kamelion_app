import 'package:get/get.dart';

import '../controllers/update_timeline_controller.dart';

class UpdateTimelineBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateTimelineController>(
      () => UpdateTimelineController(),
    );
  }
}
