import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:kamelion/app/modules/home/controllers/home_controller.dart';
import 'package:kamelion/app/modules/navigationBar/controllers/navigation_bar_controller.dart';
import 'client.dart';
import 'endpoints.dart';

class APIManager {
  ///Post API
  static Future<Response> postApiExample({required dynamic body}) async =>
      await DioClient(
        Dio(),
        showSnakbar: true,
        isOverlayLoader: true,
      ).post(Endpoints.baseUrl, data: jsonEncode(body));

  static Future<Response> verifyLisenceKey({required dynamic body}) async =>
      await DioClient(
        Dio(),
        showSnakbar: false,
        isOverlayLoader: false,
        isAuthNeeded: false,
      ).post(Endpoints.verifyLisenceKey, data: jsonEncode(body));

  static Future<Response> signUp({required dynamic body}) async =>
      await DioClient(
        Dio(),
        showSnakbar: false,
        isOverlayLoader: false,
      ).post(Endpoints.signUp, data: jsonEncode(body));

  static Future<Response> login() async => await DioClient(
        Dio(),
        showSnakbar: false,
        isOverlayLoader: false,
      ).post(Endpoints.login);

  static Future<Response> getOnboardingQuestion() async => await DioClient(
        Dio(),
        showSnakbar: false,
        isOverlayLoader: false,
      ).get(Endpoints.getOnboardingQuestions);

  static Future<Response> getMentalGymQuestions(String id) async =>
      await DioClient(
        Dio(),
        showSnakbar: false,
        isOverlayLoader: false,
      ).get(Endpoints.getMentalGymQuestions(id));

  static Future<Response> getUser() async => await DioClient(
        Dio(),
        showSnakbar: false,
        isOverlayLoader: false,
      ).get(Endpoints.getUser);

  static Future<Response> getMyStats() async => await DioClient(
        Dio(),
        showSnakbar: false,
        isOverlayLoader: false,
      ).get(Endpoints.getMyStats);

  static Future<Response> getMentalGymCounts() async => await DioClient(
        Dio(),
        showSnakbar: false,
        isOverlayLoader: false,
      ).get(Endpoints.getMentalGymCounts);

  static Future<Response> getTodaysMood({required String timezone}) async =>
      await DioClient(Dio(), showSnakbar: false, isOverlayLoader: false).get(
        Endpoints.getMood(
          Get.find<HomeController>().currentUser.value.sId ?? "",
          timezone,
        ),
      );

  static Future<Response> getMentalGymCategiries() async => await DioClient(
        Dio(),
        showSnakbar: false,
        isOverlayLoader: false,
      ).get(Endpoints.getMentalGymCategiries);

  static Future<Response> getMentalGymsDetails({required String id}) async =>
      await DioClient(
        Dio(),
        showSnakbar: false,
        isOverlayLoader: false,
      ).get(Endpoints.getMentalGymsDetails(id));

  static Future<Response> getChallengesDetails({required String id}) async =>
      await DioClient(
        Dio(),
        showSnakbar: false,
        isOverlayLoader: false,
      ).get(Endpoints.getChallengeDetails(id));

  static Future<Response> getCommunityDetails({
    required String id,
    bool isOverlayLoader = true,
  }) async =>
      await DioClient(
        Dio(),
        showSnakbar: false,
        isOverlayLoader: isOverlayLoader,
      ).get(Endpoints.getCommunityDetails(id));

  static Future<Response> getChallengeByCategory({
    required String id,
    bool isOverlayLoader = true,
  }) async =>
      await DioClient(
        Dio(),
        showSnakbar: false,
        isOverlayLoader: isOverlayLoader,
      ).get(Endpoints.getChallengesByCategory(id));

  static Future<Response> addLikeToPost({required String id}) async =>
      await DioClient(Dio(), showSnakbar: false, isOverlayLoader: false).post(
        Endpoints.addLikePost(id),
        data: {"userId": Get.find<HomeController>().currentUser.value.sId},
      );

  static Future<Response> addComment({
    required String id,
    required String comment,
    String parentCommentId = "",
  }) async =>
      await DioClient(Dio(), showSnakbar: false, isOverlayLoader: false).post(
        Endpoints.addComment(id),
        data: {
          "userId": Get.find<HomeController>().currentUser.value.sId,
          "text": comment,
          "parentCommentId": parentCommentId
        },
      );

  static Future<Response> startMentalGym({required String id}) async =>
      await DioClient(
        Dio(),
        showSnakbar: false,
        isOverlayLoader: false,
      ).get(Endpoints.getMentalGymsDetails(id));

  static Future<Response> deleteAccount() async =>
      await DioClient(Dio(), showSnakbar: false, isOverlayLoader: false).delete(
        Endpoints.deleteAccount(
          Get.find<HomeController>().currentUser.value.sId ?? "",
        ),
      );

  static Future<Response> updateCommunity({
    required String id,
    required var body,
  }) async =>
      await DioClient(
        Dio(),
        showSnakbar: false,
        isOverlayLoader: false,
      ).patch(Endpoints.updateCommunity(id), data: body);

  static Future<Response> updatePost({
    required String id,
    required var body,
    bool isOverlayLoader = false,
  }) async =>
      await DioClient(
        Dio(),
        showSnakbar: false,
        isOverlayLoader: isOverlayLoader,
      ).patch(Endpoints.updatePost(id), data: body);

  static Future<Response> deletePost({required String id}) async =>
      await DioClient(
        Dio(),
        showSnakbar: false,
        isOverlayLoader: true,
      ).delete(Endpoints.deletePost(id));

  static Future<Response> savePost({required String postId}) async =>
      await DioClient(
        Dio(),
        showSnakbar: false,
        isOverlayLoader: true,
      ).post(Endpoints.savePost, data: {"postId": postId});

  static Future<Response> joinCommunity({required String communityId}) async =>
      await DioClient(
        Dio(),
        showSnakbar: false,
        isOverlayLoader: false,
      ).post(Endpoints.joinCommunity, data: {"communityId": communityId});

  static Future<Response> getSuggestedMentalGyms() async =>
      await DioClient(Dio(), showSnakbar: false, isOverlayLoader: false).get(
        Endpoints.getSuggestedMentalGyms(
          Get.find<HomeController>().currentUser.value.sId ?? "",
        ),
      );

  static Future<Response> getSavedMentalGyms() async =>
      await DioClient(Dio(), showSnakbar: false, isOverlayLoader: true).get(
        Endpoints.getSavedMentalGyms(
          Get.find<HomeController>().currentUser.value.sId ?? "",
        ),
      );

  static Future<Response> getMentalGymsByCategory({
    required String categoryId,
  }) async =>
      await DioClient(
        Dio(),
        showSnakbar: false,
        isOverlayLoader: true,
      ).get(Endpoints.getMentalGymsByCategory(categoryId));

  static Future<Response> updateMentalGym({
    required String id,
    required Map body,
  }) async =>
      await DioClient(
        Dio(),
        showSnakbar: false,
        isOverlayLoader: true,
      ).patch(Endpoints.updateMentalGym(id), data: body);

  static Future<Response> joinMentalGym({
    required Map body,
  }) async =>
      await DioClient(
        Dio(),
        showSnakbar: false,
        isOverlayLoader: true,
      ).post(Endpoints.joinMentalGym, data: body);

  static Future<Response> startChallenge({
    required Map body,
  }) async =>
      await DioClient(
        Dio(),
        showSnakbar: false,
        isOverlayLoader: true,
      ).post(Endpoints.startChallenge, data: body);

  static Future<Response> completeChallenge({
    required Map body,
  }) async =>
      await DioClient(
        Dio(),
        showSnakbar: false,
        isOverlayLoader: true,
      ).post(Endpoints.startChallenge, data: body);

  static Future<Response> getPopularMentalGyms({
    required String limit,
    required String page,
  }) async =>
      await DioClient(
        Dio(),
        showSnakbar: false,
        isOverlayLoader: false,
      ).get(Endpoints.getTrendingMentalGyms(limit: limit, page: page));

  static Future<Response> getActiveMentalGym({
    required String page,
    required String limit,
  }) async =>
      await DioClient(
        Dio(),
        showSnakbar: false,
        isOverlayLoader: false,
      ).get(Endpoints.getActiveMentalGym(page: page, limit: limit));

  static Future<Response> getActiveChallenges() async => await DioClient(
        Dio(),
        showSnakbar: false,
        isOverlayLoader: false,
      ).get(Endpoints.getActiveChallenges);

  static Future<Response> getBadges() async => await DioClient(
        Dio(),
        showSnakbar: false,
        isOverlayLoader: false,
      ).get(Endpoints.getBadges);

  static Future<Response> getLeaderboard() async => await DioClient(
        Dio(),
        showSnakbar: false,
        isOverlayLoader: false,
      ).get(Endpoints.getLeaderboard);

  static Future<Response> getCompletedChallenges() async => await DioClient(
        Dio(),
        showSnakbar: false,
        isOverlayLoader: false,
      ).get(Endpoints.getCompletedChallenges);

  static Future<Response> getSavedChallenges() async => await DioClient(
        Dio(),
        showSnakbar: false,
        isOverlayLoader: false,
      ).get(Endpoints.getSavedChallenges);

  static Future<Response> getSuggestedChallenges() async => await DioClient(
        Dio(),
        showSnakbar: false,
        isOverlayLoader: false,
      ).get(Endpoints.getSuggestedChallenges);

  static Future<Response> searchMentalGym({
    required String page,
    required String limit,
    required String word,
  }) async =>
      await DioClient(
        Dio(),
        showSnakbar: false,
        isOverlayLoader: false,
      ).get(Endpoints.searchMentalGym(word: word, page: page, limit: limit));

  static Future<Response> getYourCommunities({
    required String page,
    required String limit,
    bool loader = false,
  }) async =>
      await DioClient(
        Dio(),
        showSnakbar: false,
        isOverlayLoader: loader,
      ).get(Endpoints.getYourCommunities(page: page, limit: limit));

  static Future<Response> getComments({required String id}) async =>
      await DioClient(
        Dio(),
        showSnakbar: false,
        isOverlayLoader: true,
      ).get(Endpoints.getComments(id));

  static Future<Response> getTreandingCommunities({
    required String page,
    required String limit,
  }) async =>
      await DioClient(
        Dio(),
        showSnakbar: false,
        isOverlayLoader: false,
      ).get(Endpoints.getTrendingCommunities);

  static Future<Response> getfavouriteposts() async => await DioClient(
        Dio(),
        showSnakbar: false,
        isOverlayLoader: false,
      ).get(Endpoints.getfavouriteposts);

  static Future<Response> getMembersOfList(String id) async => await DioClient(
        Dio(),
        showSnakbar: false,
        isOverlayLoader: false,
      ).get(Endpoints.getMembersOfList(id));

  static Future<Response> getCommunitiesByCategory({
    required String page,
    required String limit,
    required String id,
  }) async =>
      await DioClient(
        Dio(),
        showSnakbar: false,
        isOverlayLoader: false,
      ).get(Endpoints.getCommunitiesByCategory(id));

  static Future<Response> submitOnboardingAnswer({
    required var body,
    required String id,
  }) async =>
      await DioClient(
        Dio(),
        showSnakbar: false,
        isOverlayLoader: false,
      ).patch(Endpoints.updateUser(id), data: body);

  static Future<Response> updateUser(
          {required var body,
          required String id,
          bool isOverlayLoader = false}) async =>
      await DioClient(
        Dio(),
        showSnakbar: false,
        isOverlayLoader: isOverlayLoader,
      ).patch(Endpoints.updateUser(id), data: body);

  static Future<Response> submitMentalGymAnswer({
    required var body,
  }) async =>
      await DioClient(
        Dio(),
        showSnakbar: false,
        isOverlayLoader: true,
      ).post(Endpoints.submitQuize, data: body);

  static Future<Response> postWorkoutProgressDuration({
    required var body,
  }) async =>
      await DioClient(
        Dio(),
        showSnakbar: false,
        isOverlayLoader: true,
      ).post(Endpoints.workoutComplete, data: body);

  static Future<Response> saveMentalGym({required var body}) async =>
      await DioClient(
        Dio(),
        showSnakbar: false,
        isOverlayLoader: true,
      ).post(Endpoints.saveMentalGyms, data: body);

  static Future<Response> saveChallenge({required var body}) async =>
      await DioClient(
        Dio(),
        showSnakbar: false,
        isOverlayLoader: true,
      ).post(Endpoints.saveChallenge, data: body);

  static Future<Response> createAvatar({
    required var body,
    required String id,
  }) async =>
      await DioClient(
        Dio(),
        showSnakbar: false,
        isOverlayLoader: false,
      ).post(Endpoints.createAvatar, data: body);

  static Future<Response> saveUser({
    required String school,
    required String name,
    required String email,
  }) async =>
      await DioClient(
        Dio(),
        showSnakbar: false,
        isOverlayLoader: false,
        isAuthNeeded: false,
      ).post(
        Endpoints.saveUser,
        data: {"name": name, "email": email, "school": school},
      );

  static Future<Response> uploadFile({
    required String filePath,
    Map<String, dynamic>? additionalData,
  }) async {
    final file = await MultipartFile.fromFile(filePath);
    FormData formData = FormData.fromMap({
      'type': 'kamelion',
      'file': file,
      ...?additionalData, // Add additional form data if any
    });

    return await DioClient(
      Dio(),
      showSnakbar: true,
      isOverlayLoader: true,
    ).post(Endpoints.uploadFile, data: formData);
  }

  static Future<Response> addMood({
    required String mood,
    required String note,
    required String activities,
    required List<String> feelings,
  }) async =>
      await DioClient(Dio(), showSnakbar: false, isOverlayLoader: false).post(
        Endpoints.addMood,
        data: {
          "userId": Get.find<HomeController>().currentUser.value.sId,
          "mood": mood,
          "note": note,
          "feelings": feelings,
          "activities": activities,
        },
      );

  static Future<Response> markedCommunityAsOpen({required String id}) async =>
      await DioClient(
        Dio(),
        showSnakbar: false,
        isOverlayLoader: false,
      ).post(Endpoints.markOpenedCommunity(id));

  static Future<Response> createCommunity({
    required String communityName,
    required String category,
    required String imageUrl,
  }) async =>
      await DioClient(Dio(), showSnakbar: false, isOverlayLoader: false).post(
        Endpoints.createCommunity,
        data: {
          "name": communityName,
          "category": category,
          "profileImage": {"url": imageUrl},
        },
      );

  static Future<Response> createPost({
    required String communityid,
    required String desc,
  }) async =>
      await DioClient(Dio(), showSnakbar: false, isOverlayLoader: false).post(
        Endpoints.createPost,
        data: {
          "description": desc,
          "userId": Get.find<HomeController>().currentUser.value.sId,
          "community": communityid,
        },
      );

  static Future<Response> contactUsSubmit({
    required String desc,
  }) async =>
      await DioClient(Dio(), showSnakbar: false, isOverlayLoader: false).post(
        Endpoints.sendcontactus,
        data: {"text": desc},
      );

  static Future<Response> getAllJournals({
    required String params,
  }) async =>
      await DioClient(
        Dio(),
        showSnakbar: false,
        isOverlayLoader: false,
      ).get('${Endpoints.getAllJournals}?$params');
  static Future<Response> postJournalSave({required dynamic body}) async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
          .post(Endpoints.postJournalSave, data: body);

  static Future<Response> deleteJournal({required String id}) async =>
      await DioClient(
        Dio(),
        showSnakbar: false,
        isOverlayLoader: true,
      ).delete(Endpoints.deleteJournal(id));
  static Future<Response> getJournalById({required String id}) async =>
      await DioClient(
        Dio(),
        showSnakbar: false,
        isOverlayLoader: false,
      ).get(Endpoints.getJournalById(id));
  static Future<Response> updateJournal({
    required var body,
    required String id,
  }) async =>
      await DioClient(
        Dio(),
        showSnakbar: false,
        isOverlayLoader: false,
      ).patch(Endpoints.updateJournal(id), data: body);
  static Future<Response> deleteComment(
          {required String postId, required String commentId}) async =>
      await DioClient(
        Dio(),
        showSnakbar: false,
        isOverlayLoader: true,
      ).delete(Endpoints.deleteComment(postId: postId, commentId: commentId));
  static Future<Response> leaveCommunity(
          {required dynamic body, required String id}) async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
          .post(Endpoints.leaveCommunity(id), data: body);
  static Future<Response> reportComment(
          {required dynamic body, required String id}) async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
          .post(Endpoints.reportComment(id), data: body);
  static Future<Response> getHomeSearch({required String query}) async =>
      await DioClient(
        Dio(),
        showSnakbar: false,
        isOverlayLoader: false,
      ).get(Endpoints.getHomeSearch(query));
  static Future<Response> getMoods({
    required String params,
  }) async =>
      await DioClient(
        Dio(),
        showSnakbar: false,
        isOverlayLoader: false,
      ).get('${Endpoints.getMoods}?$params');
  static Future<Response> searchCommunities({
    required String page,
    required String limit,
    required String word,
  }) async =>
      await DioClient(
        Dio(),
        showSnakbar: false,
        isOverlayLoader: false,
      ).get(Endpoints.searchCommunities(word: word, page: page, limit: limit));

}
