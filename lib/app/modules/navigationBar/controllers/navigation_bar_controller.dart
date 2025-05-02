import 'package:get/get.dart';

class NavigationBarController extends GetxController {
  //TODO: Implement NavigationBarController

  final count = 0.obs;
  var selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  void changePage(int index) {
    selectedIndex.value = index;
  }
}
