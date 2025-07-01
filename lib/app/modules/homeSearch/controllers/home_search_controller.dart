import 'package:get/get.dart';

import 'package:kamelion/app/models/home_search_model.dart';


import '../../../services/dio/api_service.dart';

class HomeSearchController extends GetxController {
  final isLoading = false.obs;
  final keyword    = ''.obs;

  // RxLists for each category
  final communities = <CommunityModel>[].obs;
  final challenges  = <ChallengeModel>[].obs;
  final mentalGyms  = <MentalGymModel>[].obs;
  final workouts    = <WorkoutModel>[].obs;
  Future<void> getHomeSearch({required String searchQuery }) async {
    try {
      isLoading.value = true;
      keyword.value   = searchQuery ?? '';
      final response = await APIManager.getHomeSearch(query: searchQuery);
      final data     = response.data['data'];

      // parse and assign each list (you'll need fromJson factories)
      communities.assignAll(
        (data['communities'] as List)
            .map((e) => CommunityModel.fromJson(e))
            .toList(),
      );
      challenges.assignAll(
        (data['challenges'] as List)
            .map((e) => ChallengeModel.fromJson(e))
            .toList(),
      );
      mentalGyms.assignAll(
        (data['mentalGyms'] as List)
            .map((e) => MentalGymModel.fromJson(e))
            .toList(),
      );
      workouts.assignAll(
        (data['workouts'] as List)
            .map((e) => WorkoutModel.fromJson(e))
            .toList(),
      );
    } catch (e) {
      print(e.toString());
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}