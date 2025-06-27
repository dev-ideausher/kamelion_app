import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/models/comment_model.dart';
import 'package:kamelion/app/modules/communityPosts/controllers/community_posts_controller.dart';
import 'package:kamelion/app/services/colors.dart';
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
  String? replyingToCommentId;

  final commentFieldFocus = FocusNode();
  @override
  void onInit() {
    super.onInit();
    // postId = Get.arguments;
    // getComments(id: postId ?? "");
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
      postId = id;
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
      // showMySnackbar(msg: dioError.message ?? "");
    } catch (e, s) {
      showMySnackbar(
        // title: LocaleKeys.somethingWentWrong.tr,
        msg: e.toString(),
      );
    }
  }

  Future<void> addComment({required String id, String? commentId,  required String comment}) async {
    try {
      var response;

      response = await APIManager.addComment(id: id, parentCommentId: commentId??'', comment: comment);

      if (response.data['data'] != null && response.data['status']) {
        getComments(id: postId ?? "");
        replyingToCommentId = null;
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

  void startReply(String parentCommentId) {
    replyingToCommentId = parentCommentId;
    commentController.text = '';                // clear existing
    update();                                   // rebuild so UI can show “Replying to…”
    commentFieldFocus.requestFocus();           // open keyboard
  }
  RxSet<String> expandedComments = <String>{}.obs;

  /// Toggle expanded/collapsed state
  void toggleReplies(String commentId) {
    if (expandedComments.contains(commentId)) {
      expandedComments.remove(commentId);
    } else {
      expandedComments.add(commentId);
    }
    expandedComments.refresh();
  }
  void onCommentDelete({required String commentId}) async {
    try {
      final res = await APIManager.deleteComment(postId: postId??'',commentId: commentId);

      if (res.data['status'] == true) {
        // Optional: Show success snackbar/toast
        Get.back();
        Get.snackbar("Success", "Comment deleted");

        getComments(id: postId ?? "");
        update();
      } else {
        Get.snackbar("Error", res.data['message'] ?? "Failed to delete entry");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    }
  }
  void deleteCommentDialog({
    required BuildContext context,
    required String commentId,
  }) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
        title: Text('Delete Comment'),
        content: Text('Are you sure you want to delete comment?'),
        actions: [
          TextButton(
            onPressed: () async {
              onCommentDelete(commentId: commentId);
            },
            child: Text('Delete', style: TextStyle(color: context.redBg)),
          ),
        ],
      ),
    );
  }
  void reportCommentDialog({
    required BuildContext context,
    required String commentId,
  }) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
        title: Text('Report Comment'),
        content: Text('Are you sure you want to report comment?'),
        actions: [
          TextButton(
            onPressed: () async {
              try {
                var res = await APIManager.reportComment(
                  id: commentId,
                  body: {"userId":"680881358564ff9cf031b103",
                    "reason": "Inappropriate content"},

                );
                if (res.statusCode == 200) {
                  Get.back();
                  showMySnackbar(msg: 'Comment Reported');
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


  }
