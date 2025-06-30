import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttermoji/fluttermojiCircleAvatar.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/components/avatar.dart';
import 'package:kamelion/app/components/common_image_view.dart';
import 'package:kamelion/app/constants/image_constant.dart';
import 'package:kamelion/app/models/community_details_model.dart';
import 'package:kamelion/app/models/community_model.dart';
import 'package:kamelion/app/models/members_list_model.dart';
import 'package:kamelion/app/modules/community/controllers/community_controller.dart';
import 'package:kamelion/app/modules/home/controllers/home_controller.dart';
import 'package:kamelion/app/routes/app_pages.dart';
import 'package:kamelion/app/services/auth.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/dialog_helper.dart';
import 'package:kamelion/app/services/dio/api_service.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/snackbar.dart';
import 'package:kamelion/app/services/text_style_util.dart';

class CommunityPostsController extends GetxController {
  //TODO: Implement CommunityPostsController

  final count = 0.obs;
  CommunityModel? communitySelected;
  Rx<CommunityDetailsModel>? communityDetails;
  RxList<CommuntyMembersModel> membersList = <CommuntyMembersModel>[].obs;
  RxBool isLoading = false.obs;
  RxBool showMembers = false.obs;
  @override
  void onInit() async {
    isLoading.value = true;
    communitySelected = Get.arguments;
    await getCommunityDetails(
      communitySelected?.sId ?? "",
      isOverlayLoader: false,
    );
    await getMembersOfList(communitySelected?.sId ?? "");
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

  Future<void> getMembersOfList(String id) async {
    try {
      var response;
      membersList.value = [];
      response = await APIManager.getMembersOfList(id);
      if (response.data['data'] != null && response.data['status']) {
        for (Map<String, dynamic> data in response.data['data']) {
          membersList.add(CommuntyMembersModel.fromJson(data));
        }
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

  showOrHideMenbers({required bool val}) {
    showMembers.value = val;
    update();
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
      builder: (_) => AlertDialog(
        title: Text('Leave Community'),
        content: Text('Are you sure you want to leave community?'),
        actions: [
          TextButton(
            onPressed: () async {
              try {
                var res = await APIManager.leaveCommunity(
                  id: communitySelected?.sId ?? "",
                  body: {
                    "userId": Get.find<HomeController>().currentUser.value.sId,
                  },
                );
                if (res.statusCode == 200) {
                  await Get.find<CommunityController>().getYourCommunities();
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
      builder: (_) => AlertDialog(
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
      builder: (_) => AlertDialog(
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

class MemberList extends StatelessWidget {
  MemberList({super.key, required this.controller});
  CommunityPostsController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.ksp),
      padding: EdgeInsets.all(6.ksp),
      decoration: BoxDecoration(
        color: ColorUtil(context).brandColor5,
        borderRadius: BorderRadius.circular(8.ksp),
        border: Border.all(color: ColorUtil(context).brandBorderColor),
      ),
      child: Column(
        children: [
          ...controller.membersList.asMap().entries.map((entry) {
            int index = entry.key;
            CommuntyMembersModel value = entry.value;
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        index == 0
                            ? CommonImageView(
                                svgPath: ImageConstant.goldMedal,
                                height: 15.ksp,
                              )
                            : index == 1
                                ? CommonImageView(
                                    svgPath: ImageConstant.silverMedal,
                                    height: 15.ksp,
                                  )
                                : index == 2
                                    ? CommonImageView(
                                        svgPath: ImageConstant.bronzeModel,
                                        height: 15.ksp,
                                      )
                                    : Text(index.toString()),
                        16.kwidthBox,
                        Avatar().showAvatar(
                          avatarDetails: value.avatardetails ?? "",
                          bgColor: ColorUtil(context).blueBg,
                          radius: 14.ksp,
                        ),
                        16.kwidthBox,
                        Text(
                          value.nickname ?? "",
                          style: TextStyleUtil.genSans400(
                            fontSize: 12.ksp,
                            color: ColorUtil(context).black,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      value.totalXp!.toString() + " xp",
                      style: TextStyleUtil.genSans500(
                        fontSize: 10.ksp,
                        color: ColorUtil(context).black,
                      ),
                    ),
                  ],
                ),
                ((controller.communityDetails!.value.community!.members!
                                .length -
                            1) !=
                        index)
                    ? Divider(color: ColorUtil(context).brandBorderColor)
                    : Container(),
              ],
            );
          }),
        ],
      ),
    );
  }
}
