import 'package:get/get.dart';

import '../controllers/suggestion_form_controller.dart';

class SuggestionFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SuggestionFormController>(
      () => SuggestionFormController(),
    );
  }
}
