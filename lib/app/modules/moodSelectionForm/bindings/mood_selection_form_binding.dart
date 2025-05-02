import 'package:get/get.dart';

import '../controllers/mood_selection_form_controller.dart';

class MoodSelectionFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MoodSelectionFormController>(
      () => MoodSelectionFormController(),
    );
  }
}
