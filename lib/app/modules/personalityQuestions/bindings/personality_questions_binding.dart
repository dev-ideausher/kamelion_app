import 'package:get/get.dart';

import '../controllers/personality_questions_controller.dart';

class PersonalityQuestionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PersonalityQuestionsController>(
      () => PersonalityQuestionsController(),
    );
  }
}
