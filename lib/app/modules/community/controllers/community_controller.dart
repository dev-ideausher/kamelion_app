import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/components/common_image_view.dart';
import 'package:kamelion/app/constants/image_constant.dart';
import 'package:kamelion/app/models/community_details_model.dart';
import 'package:kamelion/app/models/community_model.dart';
import 'package:kamelion/app/modules/community/views/communities_page.dart';
import 'package:kamelion/app/modules/community/views/community_category_page.dart';
import 'package:kamelion/app/modules/community/views/community_view_all.dart';
import 'package:kamelion/app/modules/community/views/saved_post.dart';
import 'package:kamelion/app/routes/app_pages.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/custom_button.dart';
import 'package:kamelion/app/services/dialog_helper.dart';
import 'package:kamelion/app/services/dio/api_service.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/snackbar.dart';
import 'package:kamelion/app/services/text_style_util.dart';
import 'package:kamelion/generated/locales.g.dart';

class CommunityController extends GetxController {
  //TODO: Implement CommunityController

  final count = 0.obs;
  RxInt selectedScreenIndex = 0.obs;
  RxList<CommunityModel> yourCommunityList = <CommunityModel>[].obs;
  RxList<CommunityModel> trendingCommunityList = <CommunityModel>[].obs;
  RxList<Posts> savedPost = <Posts>[].obs;
  RxList<CommunityModel> categoryCommunityList = <CommunityModel>[].obs;
  RxList<CommunityModel> viewAllList = <CommunityModel>[].obs;
  final ScrollController scrollController = ScrollController();
  RxBool isLoading = false.obs;
  RxString categoryTitle = "".obs;
  RxString viewAllTitle = "".obs;
  List<Widget> screensList =
      [
        CommunitiesPage(),
        CommunityViewAll(),
        SavedPost(),
        CommunityCategoriesPage(),
      ].obs;
  // RxList categoryCommunityList = ["", "", "", "", "", "", ""].obs;
  @override
  void onInit() async {
    isLoading.value = true;
    await getYourCommunities();
    await getTrendingCommunities();
    await getSavedCommunities();
    isLoading.value = false;
    super.onInit();
  }

  @override
  void onReady() async {
    isLoading.value = true;
    await getYourCommunities();
    // await getTrendingCommunities();
    isLoading.value = false;
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  void goToCommunityPostsPage(CommunityModel communitySelected) {
    Get.toNamed(Routes.COMMUNITY_POSTS, arguments: communitySelected)!.then((
      _,
    ) {
      getYourCommunities(); // ← your callback function
    });
  }

  Future<void> addLikeonSaved({required String id}) async {
    try {
      var response;

      final index = Get.find<CommunityController>().savedPost.value.indexWhere(
        (post) => post.sId == id,
      );
      Get.find<CommunityController>().savedPost[index!].isLiked =
          !(Get.find<CommunityController>().savedPost[index].isLiked!)!;
      if (Get.find<CommunityController>().savedPost[index!]!.isLiked!) {
        Get.find<CommunityController>().savedPost[index!].likeCount =
            Get.find<CommunityController>().savedPost[index!].likeCount! + 1;
      } else {
        Get.find<CommunityController>().savedPost[index!].likeCount =
            Get.find<CommunityController>().savedPost[index!].likeCount! - 1;
      }
      Get.find<CommunityController>().savedPost.refresh();
      update();

      response = await APIManager.addLikeToPost(id: id);

      if (response.data['data'] != null && response.data['status']) {
        // getSavedCommunities();

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

  Future<void> getYourCommunities({bool loader = false}) async {
    try {
      var response;
      yourCommunityList.value = [];
      response = await APIManager.getYourCommunities(
        limit: "100",
        page: "1",
        loader: loader,
      );
      if (response.data['data'] != null && response.data['status']) {
        yourCommunityList.value = [];
        for (Map<String, dynamic> data in response.data['data']) {
          yourCommunityList.add(CommunityModel.fromJson(data));
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

  Future<void> getTrendingCommunities() async {
    try {
      var response;
      trendingCommunityList.value = [];
      response = await APIManager.getTreandingCommunities(
        limit: "100",
        page: "1",
      );
      if (response.data['data'] != null && response.data['status']) {
        for (Map<String, dynamic> data in response.data['data']) {
          trendingCommunityList.add(CommunityModel.fromJson(data));
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

  Future<void> getSavedCommunities() async {
    try {
      var response;
      savedPost.value = [];
      response = await APIManager.getfavouriteposts();
      if (response.data['data'] != null && response.data['status']) {
        for (Map<String, dynamic> data in response.data['data']) {
          savedPost.add(Posts.fromJson(data));
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

  Future<void> getCommunitiesByCategory({
    required String id,
    required String categoryName,
    required int index,
  }) async {
    try {
      var response;
      categoryCommunityList.value = [];
      isLoading.value = true;
      selectedScreenIndex.value = index;
      response = await APIManager.getCommunitiesByCategory(
        id: id,
        limit: "10",
        page: "1",
      );
      if (response.data['data'] != null && response.data['status']) {
        for (Map<String, dynamic> data in response.data['data']) {
          categoryCommunityList.value.add(CommunityModel.fromJson(data));
        }
        categoryTitle.value = categoryName;
      } else {
        debugPrint(
          "An error occurred while getting vendor profile: ${response.data['message']}",
        );
        showMySnackbar(msg: response.data['message'] ?? "");
      }
      isLoading.value = false;
      update();
      // return;
    } on DioException catch (dioError) {
      showMySnackbar(msg: dioError.message ?? "");
      isLoading.value = false;
    } catch (e, s) {
      isLoading.value = false;
      showMySnackbar(
        // title: LocaleKeys.somethingWentWrong.tr,
        msg: e.toString(),
      );
    }
  }

  void showCommunityStatusPopup({
    required BuildContext context,
    required String image,
    required String title,
    required String desc,
    required String status,
    required String id,
    CommunityModel? communitySelected,
  }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder:
          (context) => Dialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 8.ksp),
            backgroundColor: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                color: context.white,
                borderRadius: BorderRadius.circular(20.ksp), // Rounded corners
              ),
              child: Padding(
                padding: EdgeInsets.all(12.ksp),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CommonImageView(
                      svgPath: image,
                      // ImageConstant.highfivePicture
                    ),

                    Text(
                      title,
                      style: TextStyleUtil.genSans400(
                        fontSize: 16.ksp,
                        color: context.black,
                      ),
                    ),
                    6.kheightBox,
                    Text(
                      desc,
                      // "Your request is still in the queue! We're picking out the coolest communities just for you, so hang tight! 🎉",
                      textAlign: TextAlign.center,
                    ),
                    10.kheightBox,
                    Padding(
                      padding: EdgeInsets.only(right: 10.ksp),
                      child: CustomButton.outline(
                        onTap: () async {
                          if (status == "pending") {
                            Get.back();
                          } else if (status == "rejected") {
                            Get.back();
                            getYourCommunities();
                            update();
                          } else {
                            Get.back();

                            goToCommunityPostsPage(communitySelected!);
                            var response =
                                await APIManager.markedCommunityAsOpen(id: id);

                            await getYourCommunities();

                            update();
                          }
                        },
                        height: 30.ksp,
                        title:
                            status == "pending"
                                ? "Sure thing!"
                                : status == "rejected"
                                ? "I’ll try it next time!"
                                : "Go to community ",
                      ),
                    ),
                  ],
                ),
              ),
            ), // your custom widget here
          ),
    );
  }
}
