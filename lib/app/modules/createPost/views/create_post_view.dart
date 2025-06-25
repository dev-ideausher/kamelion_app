import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kamelion/app/modules/home/controllers/home_controller.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/custom_button.dart';
import 'package:kamelion/app/services/custom_textfield.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';

import '../controllers/create_post_controller.dart';

class CreatePostView extends GetView<CreatePostController> {
  const CreatePostView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.ksp, vertical: 30.ksp),
        child: Obx(
          () => CustomButton.outline(
            disabled: !controller.enableButton.value,
            title: controller.postId == null ? "Create Post" : "Edit Post",
            onTap:
                () =>
                    controller.postId == null
                        ? controller.createPost()
                        : controller.editPost(),
            trailing: Padding(
              padding: EdgeInsets.only(left: 4.0.ksp),
              child: Icon(
                Icons.arrow_forward,
                size: 14.ksp,
                color: context.white,
              ),
            ),
          ),
        ),
      ),
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.ksp),
        child: Container(
          height: context.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${controller.postId == null ? "Create a" : "Edit"}"
                      " ",
                      style: TextStyleUtil.genSans500(
                        fontSize: 20.ksp,
                        color: ColorUtil(context).black,
                      ),
                    ),
                    Text(
                      "Post",
                      style: TextStyleUtil.genSans500(
                        fontSize: 20.ksp,
                        color: ColorUtil(context).brandColor1,
                      ),
                    ),
                  ],
                ),
                controller.postId == null ? 10.kheightBox : 0.kheightBox,
                Row(
                  children: [
                    2.5.kwidthBox,
                    Text(
                      controller.postId == null ? "Post Question" : "",
                      style: TextStyleUtil.genSans500(
                        fontSize: 12.ksp,
                        color: ColorUtil(context).black,
                      ),
                    ),
                  ],
                ),
                20.kheightBox,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 18.ksp,
                      backgroundImage: NetworkImage(
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/9/93/Kim_Jong-un_2024.jpg/250px-Kim_Jong-un_2024.jpg',
                      ), // Replace with NetworkImage if needed
                    ),
                    10.kwidthBox,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Get.find<HomeController>()
                                    .currentUser
                                    .value
                                    .nickname ??
                                "",
                            style: TextStyleUtil.genSans500(
                              fontSize: 14.ksp,
                              color: context.black,
                            ),
                          ),
                          2.kheightBox,
                          Text(
                            DateFormat('MMM d yyyy').format(DateTime.now()),
                            style: TextStyleUtil.genSans400(
                              fontSize: 10.ksp,
                              color: context.greyDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                10.kheightBox,
                TextFormField(
                  controller: controller.postContentController,
                  decoration: InputDecoration(
                    hintText: "Enter a description...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        4.ksp,
                      ), // Rounded corners
                      borderSide: BorderSide(color: ColorUtil(context).grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.ksp),
                      borderSide: BorderSide(color: ColorUtil(context).grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.ksp),
                      borderSide: BorderSide(
                        color: ColorUtil(context).brandColor1,
                      ),
                    ),
                  ),
                  maxLines: 8,
                  onChanged: (value) {
                    controller.checkFormValidity();
                  },
                ),
                // Spacer(),
                // Align(
                //   alignment: Alignment.bottomCenter,
                //   child: Obx(
                //     () => CustomButton.outline(
                //       disabled: !controller.enableButton.value,
                //       title: "Create Post",
                //       onTap: () => controller.createPost(),
                //       trailing: Padding(
                //         padding: EdgeInsets.only(left: 4.0.ksp),
                //         child: Icon(
                //           Icons.arrow_forward,
                //           size: 14.ksp,
                //           color: context.white,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                30.kheightBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
