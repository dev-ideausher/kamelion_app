import 'package:get/get.dart';

import '../controllers/course_complete_controller.dart';

class CourseCompleteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CourseCompleteController>(
      () => CourseCompleteController(),
    );
  }
}
