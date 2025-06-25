import 'package:get/get.dart';

import '../controllers/community_posts_controller.dart';

class CommunityPostsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommunityPostsController>(
      () => CommunityPostsController(),
    );
  }
}
