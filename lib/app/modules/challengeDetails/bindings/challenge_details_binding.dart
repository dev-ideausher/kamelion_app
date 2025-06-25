import 'package:get/get.dart';

import '../controllers/challenge_details_controller.dart';

class ChallengeDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChallengeDetailsController>(
      () => ChallengeDetailsController(),
    );
  }
}
