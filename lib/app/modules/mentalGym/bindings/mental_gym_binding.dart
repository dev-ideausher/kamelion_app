import 'package:get/get.dart';

import '../controllers/mental_gym_controller.dart';

class MentalGymBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MentalGymController>(
      () => MentalGymController(),
    );
  }
}
