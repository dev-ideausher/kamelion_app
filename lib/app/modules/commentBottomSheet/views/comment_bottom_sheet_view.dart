import 'package:flutter/material.dart';
import 'package:fluttermoji/fluttermojiCircleAvatar.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kamelion/app/models/comment_model.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/custom_textfield.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';

import '../../../components/avatar.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/comment_bottom_sheet_controller.dart';

class CommentBottomSheetView extends GetView<CommentBottomSheetController> {
  CommentBottomSheetView({super.key});

  // {
  //   _scrollController.addListener(() {
  //     if (_scrollController.position.pixels >=
  //         _scrollController.position.maxScrollExtent - 100) {
  //       controller.loadMoreComments();
  //     }
  //   });
  // }

  final controller = Get.put(CommentBottomSheetController());
  // final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CommentBottomSheetController>(
      builder: (controller) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            padding: EdgeInsets.all(16.ksp),
            height: MediaQuery.of(context).size.height * 0.75,
            child: Column(
              children: [
                Text(
                  'Comments',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: Obx(
                    () => ListView.builder(
                      // controller: _scrollController,
                      itemCount: controller.comments.length + 1,
                      itemBuilder: (context, index) {
                        if (index < controller.comments.length) {
                          return buildComment(controller: controller,
                            comment: controller.comments[index],
                            context: context,
                          );
                        } else if (controller.isLoadingMore.value) {
                          return Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: CircularProgressIndicator(),
                            ),
                          );
                        } else {
                          return SizedBox.shrink();
                        }
                      },
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        focusNode: controller.commentFieldFocus,
                        controller: controller.commentController,
                        hintText:  controller.replyingToCommentId != null
                            ? 'Replying…'
                            : 'Add a comment',
                      ),
                    ),
                    8.kwidthBox,
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: context.brandColor1,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.arrow_upward, color: context.white),
                        onPressed: () {
                          controller.addComment(
                            commentId: controller.replyingToCommentId,
                            comment: controller.commentController.text,
                            id: controller.postId ?? "",
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget buildComment({
  required CommentModel comment,
  bool isReply = false,
  required BuildContext context,
  required CommentBottomSheetController controller
}) {
  return Padding(
    padding: EdgeInsets.only(left: isReply ? 40.0 : 8.0.ksp, top: 10.ksp),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [


            Row(
              children: [
                Avatar().showAvatar(
                  avatarDetails: comment.userId?.avatardetails??'',
                  bgColor: context.blueBg,
                  context: context,
                  radius: 20.ksp,
                ),
                8.kwidthBox,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      comment.userId?.nickname ?? "",
                      style: TextStyleUtil.genSans500(
                        fontSize: 12.ksp,
                        color: context.black,
                      ),
                    ),
                    Text(
                      DateFormat(
                        "h:mma, d MMMM, yyyy",
                      ).format(  DateTime.parse(comment.createdAt ?? "").toLocal(),),
                      style: TextStyleUtil.genSans300(
                        fontSize: 8.ksp,
                        color: context.greyDark,
                      ),
                    ),

                  ],
                ),
              ],
            ),
            PopupMenuButton<String>(
              color: context.white,
              icon: Icon(Icons.more_vert), // The 3-dot icon
              onSelected: (value) {
                if (value == 'Report') {
                  controller.reportCommentDialog(commentId: comment.sId??'', context: context);

                } else if (value == 'delete') {
controller.deleteCommentDialog(commentId: comment.sId??'', context: context);
                }
              },
              itemBuilder:
                  (BuildContext context) =>
                comment.userId?.sId ==
                      Get.find<HomeController>().currentUser.value.sId
                  ? [
                  PopupMenuItem(
                    value: 'Report',
                    child: Row(
                      children: [
                        Icon(Icons.flag_outlined),
                        10.kwidthBox,
                        Text('Report Comment'),
                      ],
                    ),
                  ),
                PopupMenuItem(

                  value: 'delete',

                  child: Row(
                    children: [
                      Icon(Icons.delete_outline),
                      10.kwidthBox,
                      Text('Delete Comment'),
                    ],
                  ),
                ),
              ]
                  : [

                PopupMenuItem(
                  value: 'Report',
                  child: Row(
                    children: [
                      Icon(Icons.flag_outlined),
                      10.kwidthBox,
                      Text('Report Comment'),
                    ],
                  ),
                ),
              ],
            ),
            // Icon(Icons.more_vert, size: 14.ksp),
          ],
        ),
        8.kheightBox,
        Text(
          comment.text ?? "",
          // "Just checked out the new UI mockup for Freud's mental health app, and I'm impressed! The design is sleek and intuitive, making it easy to navigate.",
          style: TextStyleUtil.genSans300(
            fontSize: 9.ksp,
            color: context.black,
          ),
        ),
        10.kheightBox,
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => controller.startReply(comment.sId!),
              child: Text(
                "Reply",
                style: TextStyleUtil.genSans500(
                  fontSize: 9.ksp,
                  color: context.brandColor1,
                  height: 1.43,

                ),
              ),
            )
            ,  if (comment.replies?.isNotEmpty??false) GestureDetector(
              onTap: () => controller.toggleReplies(comment.sId!),
              child:Obx((){
                final expanded = controller.expandedComments.contains(comment.sId);
                return Text(
                  expanded
                      ? "hide replies"
                      : "view all ${comment.replies?.length} replies",
                style: TextStyleUtil.genSans500(
                  fontSize: 9.ksp,
                  color: context.brandColor1,
                  height: 1.43,

                ),
              );}),
            )
          ],
        ).paddingSymmetric(vertical: 8),
        // ─── nested replies ───────────────────────────────────────────────
        Obx(() {
          if (!controller.expandedComments.contains(comment.sId)) {
            return SizedBox.shrink();
          }
          return Column(
            children: comment.replies!.map((reply) {
              return buildReplyComment(
                comment: reply,
                isReply: true,
                context: context, controller: controller,
              );
            }).toList(),
          );
        }),
        // Text(
        //   "Reply",
        //   style: TextStyleUtil.genSans500(
        //     fontSize: 9.ksp,
        //     color: context.brandColor1,
        //   ),
        // ),
        // for (final reply in comment.replies)
        //   buildComment(reply, isReply: true, context: context),
      ],
    ),
  );
}


Widget buildReplyComment({
  required CommentModel comment,
  bool isReply = false,
  required BuildContext context,
  required CommentBottomSheetController controller
}) {
  return Padding(
    padding: EdgeInsets.only(left: isReply ? 40.0 : 8.0.ksp, top: 10.ksp),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                // FluttermojiCircleAvatar(
                //   backgroundColor: ColorUtil(context).blueBg,
                //   radius: 14.ksp,
                // ),
                Avatar().showAvatar(
                  avatarDetails: comment.userId?.avatardetails??'',
                  bgColor: context.blueBg,
                  context: context,
                  radius: 20.ksp,
                ),
                8.kwidthBox,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      comment.userId?.nickname ?? "",
                      style: TextStyleUtil.genSans500(
                        fontSize: 12.ksp,
                        color: context.black,
                      ),
                    ),
                    Text(
                      DateFormat(
                        "h:mma, d MMMM, yyyy",
                      ).format(  DateTime.parse(comment.createdAt ?? "").toLocal(),),
                      style: TextStyleUtil.genSans300(
                        fontSize: 8.ksp,
                        color: context.greyDark,
                      ),
                    ),

                  ],
                ),
                // Icon(Icons.more_vert, size: 14.ksp),
              ],
            ),
            PopupMenuButton<String>(
              color: context.white,
              icon: Icon(Icons.more_vert), // The 3-dot icon
              onSelected: (value) {
                if (value == 'Report') {
                  controller.reportCommentDialog(commentId: comment.sId??'', context: context);

                } else if (value == 'delete') {
                  controller.deleteCommentDialog(commentId: comment.sId??'', context: context);

                }
              },
              itemBuilder:
                  (BuildContext context) =>
              comment.userId?.sId ==
                  Get.find<HomeController>().currentUser.value.sId
                  ? [
                PopupMenuItem(
                  value: 'Report',
                  child: Row(
                    children: [
                      Icon(Icons.flag_outlined),
                      10.kwidthBox,
                      Text('Report Comment'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete_outline),
                      10.kwidthBox,
                      Text('Delete Comment'),
                    ],
                  ),
                ),
              ]
                  : [

                PopupMenuItem(
                  value: 'Report',
                  child: Row(
                    children: [
                      Icon(Icons.flag_outlined),
                      10.kwidthBox,
                      Text('Report Comment'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        8.kheightBox,
        Text(
          comment.text ?? "",
          // "Just checked out the new UI mockup for Freud's mental health app, and I'm impressed! The design is sleek and intuitive, making it easy to navigate.",
          style: TextStyleUtil.genSans300(
            fontSize: 9.ksp,
            color: context.black,
          ),
        ),
        10.kheightBox,

        // ─── nested replies ───────────────────────────────────────────────
       
        // Text(
        //   "Reply",
        //   style: TextStyleUtil.genSans500(
        //     fontSize: 9.ksp,
        //     color: context.brandColor1,
        //   ),
        // ),
        // for (final reply in comment.replies)
        //   buildComment(reply, isReply: true, context: context),
      ],
    ),
  );
}