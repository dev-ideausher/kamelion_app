import 'package:get/get.dart';

import '../controllers/auth_direction_controller.dart';

class AuthDirectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthDirectionController>(
      () => AuthDirectionController(),
    );
  }
}
