import 'package:get/get.dart';

import '../controllers/create_avatar_controller.dart';

class CreateAvatarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateAvatarController>(
      () => CreateAvatarController(),
    );
  }
}
