import 'package:get/get.dart';
import 'package:kamelion/app/constants/image_constant.dart';
import 'package:kamelion/generated/locales.g.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final count = 0.obs;
  final List<Map<String, dynamic>> moodsToShow = [
    {"image": ImageConstant.unHappyMood, "label": LocaleKeys.unhappy.tr},
    {"image": ImageConstant.sadMood, "label": LocaleKeys.sad.tr},
    {"image": ImageConstant.normalMood, "label": LocaleKeys.normal.tr},
    {"image": ImageConstant.goodMood, "label": LocaleKeys.good.tr},
    {"image": ImageConstant.happyMood, "label": LocaleKeys.happy.tr},
  ];
  final List<Map<String, dynamic>> mentalGymList = [
    {
      "image": ImageConstant.myCharacterLogo,
      "label": LocaleKeys.my_character.tr,
    },
    {"image": ImageConstant.socialLifeIcon, "label": LocaleKeys.social_life.tr},
    {"image": ImageConstant.healthIcon, "label": LocaleKeys.health_fitness.tr},
    {"image": ImageConstant.healthIcon, "label": LocaleKeys.my_mind.tr},
  ];
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
}
