import 'package:get/get.dart';

class SupportController extends GetxController {
  //TODO: Implement SupportController

  final count = 0.obs;
  List feelingsList = [
    "Feeling Sad, Low or Numb",
    "Anxious, Overthinking or Panicky",
    "Lonely or Isolated",
    "Struggling to Sleep or Switch Off",
    "Worried About School or Exams",
    "Stressed About the Future",
    "Friendship or Relationship Issues",
    "Not feeling good or comparing to others.",
    "Family Stress or Tension at Home",
    "Other",
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
