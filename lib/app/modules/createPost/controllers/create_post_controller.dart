import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/models/community_model.dart';
import 'package:kamelion/app/modules/communityPosts/controllers/community_posts_controller.dart';
import 'package:kamelion/app/modules/home/controllers/home_controller.dart';
import 'package:kamelion/app/services/dialog_helper.dart';
import 'package:kamelion/app/services/dio/api_service.dart';
import 'package:kamelion/app/services/snackbar.dart';

class CreatePostController extends GetxController {
  //TODO: Implement CreatePostController

  final count = 0.obs;
  TextEditingController postContentController = TextEditingController();
  RxBool enableButton = false.obs;
  CommunityModel? communitySelected;
  String? postId;

  @override
  void onInit() {
    if (Get.arguments['isEdit']) {
      postContentController.text = Get.arguments['postContent'];
      postId = Get.arguments['postId'];
      communitySelected = Get.arguments['communitySelected'];
      checkFormValidity();
    } else {
      communitySelected = Get.arguments['communitySelected'];
    }
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

  void checkFormValidity() {
    print(postContentController.text != "");
    enableButton.value = (postContentController.text != "");
  }

  // void createPost() {
  //   Get.back();
  // }

  void createPost() async {
    if (enableButton.value) {
      try {
        var response;
        DialogHelper.showLoading();

        response = await APIManager.createPost(
          communityid: communitySelected?.sId ?? "",
          desc: postContentController.text,
        );

        if (response.data['data'] != null && response.data['status']) {
          await Get.find<CommunityPostsController>().getCommunityDetails(
            communitySelected?.sId ?? "",
          );
          update();
          Get.back();
          // await Get.find<CommunityPostsController>().getCommunityDetails(
          //     Get.find<CommunityPostsController>().communitySelected?.sId ??
          //         "");
          // Get.find<CommunityPostsController>().refresh();
          update();
          await Get.find<HomeController>().getUser();
          Get.find<HomeController>().currentUser.refresh();
          DialogHelper.hideDialog();

          showMySnackbar(msg: response.data['message']);
        } else {
          showMySnackbar(msg: response.data['message'] ?? "");
          DialogHelper.hideDialog();
        }
        update();

        // return;
      } on DioException catch (dioError) {
        showMySnackbar(msg: dioError.message ?? "");
        DialogHelper.hideDialog();
      } catch (e) {
        showMySnackbar(msg: e.toString());
        DialogHelper.hideDialog();
      }
    }
  }

  void editPost() async {
    if (enableButton.value) {
      try {
        var response;
        DialogHelper.showLoading();

        response = await APIManager.updatePost(
          id: postId ?? "",
          body: {"description": postContentController.text},
        );

        if (response.data['data'] != null && response.data['status']) {
          await Get.find<CommunityPostsController>().getCommunityDetails(
            communitySelected?.sId ?? "",
          );
          Get.back();
          DialogHelper.hideDialog();
          showMySnackbar(msg: response.data['message']);
        } else {
          showMySnackbar(msg: response.data['message'] ?? "");
          DialogHelper.hideDialog();
        }
        update();

        // return;
      } on DioException catch (dioError) {
        showMySnackbar(msg: dioError.message ?? "");
        DialogHelper.hideDialog();
      } catch (e) {
        showMySnackbar(msg: e.toString());
        DialogHelper.hideDialog();
      }
    }
  }
}
