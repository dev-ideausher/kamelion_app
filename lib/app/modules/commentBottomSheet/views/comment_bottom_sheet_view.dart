import 'package:flutter/material.dart';
import 'package:fluttermoji/fluttermojiCircleAvatar.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kamelion/app/models/comment_model.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/custom_textfield.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';

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
                          return buildComment(
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
                        controller: controller.commentController,
                        hintText: 'Type your reply',
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
}) {
  return Padding(
    padding: EdgeInsets.only(left: isReply ? 40.0 : 8.0.ksp, top: 10.ksp),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            FluttermojiCircleAvatar(
              backgroundColor: ColorUtil(context).blueBg,
              radius: 14.ksp,
            ),
            8.kwidthBox,
            Expanded(
              child: Column(
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
                    ).format(DateTime.parse(comment.userId?.createdAt ?? "")),
                    style: TextStyleUtil.genSans300(
                      fontSize: 8.ksp,
                      color: context.greyDark,
                    ),
                  ),
                ],
              ),
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
        8.kheightBox,
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
