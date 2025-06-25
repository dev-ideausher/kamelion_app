import 'package:get/get.dart';

import '../controllers/get_school_controller.dart';

class GetSchoolBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GetSchoolController>(
      () => GetSchoolController(),
    );
  }
}
