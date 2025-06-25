import 'package:get/get.dart';

import '../controllers/quize_collect_coin_controller.dart';

class QuizeCollectCoinBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuizeCollectCoinController>(
      () => QuizeCollectCoinController(),
    );
  }
}
