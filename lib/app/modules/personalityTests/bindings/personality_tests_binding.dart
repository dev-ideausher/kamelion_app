import 'package:get/get.dart';

import '../controllers/personality_tests_controller.dart';

class PersonalityTestsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PersonalityTestsController>(
      () => PersonalityTestsController(),
    );
  }
}
