import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/models/community_details_model.dart';
import 'package:kamelion/app/models/community_model.dart';
import 'package:kamelion/app/modules/community/controllers/community_controller.dart';
import 'package:kamelion/app/modules/home/controllers/home_controller.dart';
import 'package:kamelion/app/routes/app_pages.dart';
import 'package:kamelion/app/services/auth.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/dialog_helper.dart';
import 'package:kamelion/app/services/dio/api_service.dart';
import 'package:kamelion/app/services/snackbar.dart';

class CommunityPostsController extends GetxController {
  //TODO: Implement CommunityPostsController

  final count = 0.obs;
  CommunityModel? communitySelected;
  Rx<CommunityDetailsModel>? communityDetails;
  RxBool isLoading = false.obs;
  @override
  void onInit() async {
    isLoading.value = true;
    communitySelected = Get.arguments;
    await getCommunityDetails(
      communitySelected?.sId ?? "",
      isOverlayLoader: false,
    );
    isLoading.value = false;
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

  Future<void> getCommunityDetails(
    String id, {
    bool isOverlayLoader = true,
  }) async {
    try {
      var response;

      response = await APIManager.getCommunityDetails(
        id: id,
        isOverlayLoader: isOverlayLoader,
      );

      if (response.data['data'] != null && response.data['status']) {
        communityDetails =
            CommunityDetailsModel.fromJson(response.data['data']).obs;
      } else {
        debugPrint(
          "An error occurred while getting vendor profile: ${response.data['message']}",
        );
        showMySnackbar(msg: response.data['message'] ?? "");
      }
      update();
      // return;
    } on DioException catch (dioError) {
      showMySnackbar(msg: dioError.message ?? "");
    } catch (e, s) {
      showMySnackbar(
        // title: LocaleKeys.somethingWentWrong.tr,
        msg: e.toString(),
      );
    }
  }

  Future<void> addLike({required String id}) async {
    try {
      var response;

      final index = communityDetails?.value.posts!.indexWhere(
        (post) => post.sId == id,
      );
      communityDetails?.value.posts![index!].isLiked =
          !(communityDetails?.value.posts![index].isLiked!)!;
      if (communityDetails!.value.posts![index!]!.isLiked!) {
        communityDetails!.value.posts![index!].likeCount =
            communityDetails!.value.posts![index!].likeCount! + 1;
      } else {
        communityDetails!.value.posts![index!].likeCount =
            communityDetails!.value.posts![index!].likeCount! - 1;
      }
      update();

      response = await APIManager.addLikeToPost(id: id);

      if (response.data['data'] != null && response.data['status']) {
        // await getCommunityDetails(
        //   communitySelected?.sId ?? "",
        //   isOverlayLoader: false,
        // );
        update();
      } else {
        debugPrint(
          "An error occurred while getting vendor profile: ${response.data['message']}",
        );
        showMySnackbar(msg: response.data['message'] ?? "");
      }
      update();
      // return;
    } on DioException catch (dioError) {
      showMySnackbar(msg: dioError.message ?? "");
    } catch (e, s) {
      showMySnackbar(
        // title: LocaleKeys.somethingWentWrong.tr,
        msg: e.toString(),
      );
    }
  }

  void leaveCommunityDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text('Leave Community'),
            content: Text('Are you sure you want to leave community?'),
            actions: [
              TextButton(
                onPressed: () async {
                  try {
                    var res = await APIManager.leaveCommunity(
                      id: communitySelected?.sId ?? "",
                      body: {
                        "userId":
                        Get.find<HomeController>()
                            .currentUser
                            .value
                            .sId,
                      },
                    );
                    if (res.statusCode == 200) {
                      await Get.find<CommunityController>()
                          .getYourCommunities();
                      Get.back();
                      Get.back();
                      showMySnackbar(msg: 'Community left');
                    }
                  } on DioException catch (dioError) {
                    showMySnackbar(msg: dioError.message ?? "");
                  } catch (e, s) {
                    showMySnackbar(
                      // title: LocaleKeys.somethingWentWrong.tr,
                      msg: e.toString(),
                    );
                  }
                },
                child: Text('Leave', style: TextStyle(color: context.redBg)),
              ),
            ],
          ),
    );
  }

  void reportPostDialog({
    required BuildContext context,
    required String postId,
  }) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text('Report Post'),
            content: Text('Are you sure you want to report post?'),
            actions: [
              TextButton(
                onPressed: () async {
                  try {
                    var res = await APIManager.updatePost(
                      id: postId,
                      body: {"isReport": true},
                      isOverlayLoader: true,
                    );
                    if (res.statusCode == 200) {
                      Get.back();
                      showMySnackbar(msg: 'Post Reported');
                    }
                  } on DioException catch (dioError) {
                    showMySnackbar(msg: dioError.message ?? "");
                  } catch (e, s) {
                    showMySnackbar(
                      // title: LocaleKeys.somethingWentWrong.tr,
                      msg: e.toString(),
                    );
                  }
                },
                child: Text('Report', style: TextStyle(color: context.redBg)),
              ),
            ],
          ),
    );
  }

  void deletePostDialog({
    required BuildContext context,
    required String postId,
  }) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text('Delete Post'),
            content: Text('Are you sure you want to delete post?'),
            actions: [
              TextButton(
                onPressed: () async {
                  try {
                    var res = await APIManager.deletePost(id: postId);
                    if (res.statusCode == 200) {
                      Get.back();
                      showMySnackbar(msg: res.data['message']);
                      getCommunityDetails(communitySelected?.sId ?? "");
                    }
                  } on DioException catch (dioError) {
                    showMySnackbar(msg: dioError.message ?? "");
                  } catch (e, s) {
                    showMySnackbar(
                      // title: LocaleKeys.somethingWentWrong.tr,
                      msg: e.toString(),
                    );
                  }
                },
                child: Text('Delete', style: TextStyle(color: context.redBg)),
              ),
            ],
          ),
    );
  }

  void goEditPost({required String postId, required String postContent}) {
    Get.toNamed(
      Routes.CREATE_POST,
      arguments: {
        "isEdit": true,
        "postId": postId,
        "postContent": postContent,
        "communitySelected": communitySelected,
      },
    );
  }

  void savePost({required String postId}) async {
    try {
      var res = await APIManager.savePost(postId: postId);
      if (res.statusCode == 200) {
        // Get.back();
        showMySnackbar(msg: res.data['message']);
        getCommunityDetails(communitySelected?.sId ?? "");
        Get.find<CommunityController>().getSavedCommunities();
      }
    } on DioException catch (dioError) {
      showMySnackbar(msg: dioError.message ?? "");
    } catch (e, s) {
      showMySnackbar(
        // title: LocaleKeys.somethingWentWrong.tr,
        msg: e.toString(),
      );
    }
  }

  joinCommunity() async {
    try {
      var res = await APIManager.joinCommunity(
        communityId: communitySelected?.sId ?? "",
      );
      if (res.statusCode == 200) {
        Get.back();
        Get.find<CommunityController>().getYourCommunities();
        showMySnackbar(msg: 'Community joined');
      }
    } on DioException catch (dioError) {
      showMySnackbar(msg: dioError.message ?? "");
    } catch (e, s) {
      showMySnackbar(
        // title: LocaleKeys.somethingWentWrong.tr,
        msg: e.toString(),
      );
    }
  }
}
