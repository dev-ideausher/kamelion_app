import 'package:get/get.dart';

import '../controllers/search_community_controller.dart';

class SearchCommunityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchCommunityController>(
      () => SearchCommunityController(),
    );
  }
}
