import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/models/comment_model.dart';
import 'package:kamelion/app/modules/communityPosts/controllers/community_posts_controller.dart';
import 'package:kamelion/app/services/dio/api_service.dart';
import 'package:kamelion/app/services/snackbar.dart';

class CommentBottomSheetController extends GetxController {
  //TODO: Implement CommentBottomSheetController

  final count = 0.obs;
  // final RxList<CommentModel> comments = <CommentModel>[].obs;
  final RxBool isLoadingMore = false.obs;
  final RxBool hasMore = true.obs;
  final TextEditingController commentController = TextEditingController();
  int _page = 1;
  CommentModel? replyingTo;
  RxList<CommentModel> comments = <CommentModel>[].obs;
  String? postId;

  @override
  void onInit() {
    super.onInit();
    postId = Get.arguments;
    getComments(id: postId ?? "");
    // comments.value = [
    //   CommentModel(
    //     user: "",
    //     text: "",
    //     replies: [CommentModel(user: "", text: "")],
    //   ),
    //   CommentModel(user: "", text: ""),
    //   CommentModel(user: "", text: ""),
    // ];
  }

  @override
  void onReady() {
    super.onReady();
    // comments.value = [
    //   CommentModel(
    //     user: "",
    //     text: "",
    //     replies: [CommentModel(user: "", text: "")],
    //   ),
    //   CommentModel(user: "", text: ""),
    //   CommentModel(user: "", text: ""),
    // ];
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  void loadInitialComments() {
    comments.clear();
    _page = 1;
    hasMore.value = true;
    // loadMoreComments();
  }

  // void loadMoreComments() async {
  //   if (isLoadingMore.value || !hasMore.value) return;

  //   isLoadingMore.value = true;

  //   await Future.delayed(Duration(seconds: 1)); // simulate API delay

  //   List<CommentModel> newComments = List.generate(5, (index) {
  //     final id = (_page - 1) * 5 + index + 1;
  //     return CommentModel(user: 'User $id', text: 'Comment $id');
  //   });

  //   if (newComments.isEmpty) {
  //     hasMore.value = false;
  //   } else {
  //     comments.addAll(newComments);
  //     _page++;
  //   }

  //   isLoadingMore.value = false;
  // }

  void addReply(CommentModel parent, String replyText) {
    update(); // notify GetBuilder or Obx
  }

  void addNewComment(String text) {}

  Future<void> getComments({required String id}) async {
    try {
      var response;
      comments.value = [];
      response = await APIManager.getComments(id: id);
      if (response.data['data'] != null && response.data['status']) {
        for (Map<String, dynamic> data in response.data['data']) {
          comments.add(CommentModel.fromJson(data));
        }
      } else {
        debugPrint(
          "An error occurred while getting vendor profile: ${response.data['message']}",
        );
        showMySnackbar(msg: response.data['message'] ?? "");
      }
      comments.refresh();
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

  Future<void> addComment({required String id, required String comment}) async {
    try {
      var response;

      response = await APIManager.addComment(id: id, comment: comment);

      if (response.data['data'] != null && response.data['status']) {
        getComments(id: postId ?? "");
        commentController.text = "";
        showMySnackbar(msg: response.data['message'] ?? "");
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
}
