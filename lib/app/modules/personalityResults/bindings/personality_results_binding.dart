import 'package:get/get.dart';

import '../controllers/personality_results_controller.dart';

class PersonalityResultsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PersonalityResultsController>(
      () => PersonalityResultsController(),
    );
  }
}
