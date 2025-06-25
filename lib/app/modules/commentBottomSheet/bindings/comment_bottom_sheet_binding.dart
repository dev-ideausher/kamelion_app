import 'package:get/get.dart';

import '../controllers/comment_bottom_sheet_controller.dart';

class CommentBottomSheetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommentBottomSheetController>(
      () => CommentBottomSheetController(),
    );
  }
}
