import 'package:get/get.dart';

import '../controllers/search_mental_gym_controller.dart';

class SearchMentalGymBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchMentalGymController>(
      () => SearchMentalGymController(),
    );
  }
}
