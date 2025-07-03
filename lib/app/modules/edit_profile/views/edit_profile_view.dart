import 'package:flutter/material.dart';
import 'package:fluttermoji/fluttermojiCircleAvatar.dart';
import 'package:fluttermoji/fluttermojiSaveWidget.dart';

import 'package:get/get.dart';
import 'package:kamelion/app/components/avatar.dart';
import 'package:kamelion/app/components/common_image_view.dart';
import 'package:kamelion/app/constants/image_constant.dart';
import 'package:kamelion/app/routes/app_pages.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/custom_textfield.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';
import 'package:kamelion/generated/locales.g.dart';

import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.editProfile.tr),
        centerTitle: true,
        actions: [
          Obx(
            () => InkWell(
              onTap: () {
                controller.updateProfile();
              },
              child: Text(
                LocaleKeys.done.tr,
                style: TextStyleUtil.genSans500(
                  fontSize: 12.ksp,
                  color: controller.enabelLoginBotton.value
                      ? ColorUtil(context).brandColor1
                      : ColorUtil(context).grey,
                ),
              ),
            ),
          ),
          20.kwidthBox,
        ],
      ),
      body: Obx(
        () => controller.isLoading.value
            ? Container(
                child: Center(
                  child: CircularProgressIndicator(color: context.brandColor1),
                ),
              )
            : Padding(
                padding: EdgeInsets.all(16.ksp),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      context.width.kwidthBox,
                      20.kheightBox,
                      Center(
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Avatar().showAvatar(
                              avatarDetails: controller.avatarDetails.value,
                              radius: 80,
                              bgColor: ColorUtil(context).blueBg,
                            ),
                            // FluttermojiCircleAvatar(
                            //   backgroundColor: ColorUtil(context).blueBg,
                            //   radius: 80,
                            // ),
                            Positioned(
                              bottom: -15,
                              right: 0,
                              left: 0,
                              child: InkWell(
                                onTap: () {
                                  controller.checkFormValidity();
                                  Get.toNamed(
                                    Routes.CREATE_AVATAR,
                                    arguments: {"from": Routes.EDIT_PROFILE},
                                  );
                                },
                                child: CircleAvatar(
                                    backgroundColor: ColorUtil(context).greyBg,
                                    child: CommonImageView(
                                      height: 18.ksp,
                                      svgPath: ImageConstant.pencilIconEdit,
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      40.kheightBox,
                      Text(
                        " ${LocaleKeys.fullName.tr}",
                        style: TextStyleUtil.genSans600(
                          fontSize: 12.ksp,
                          color: context.black,
                        ),
                      ),
                      3.kheightBox,
                      CustomTextField(
                        hintText: LocaleKeys.fullNameHint.tr,
                        controller: controller.fullNameController,
                        onChange: (val) => controller.checkFormValidity(),
                      ),
                      10.kheightBox,
                      Text(
                        " ${LocaleKeys.enterNickname.tr}",
                        style: TextStyleUtil.genSans600(
                          fontSize: 12.ksp,
                          color: context.black,
                        ),
                      ),
                      3.kheightBox,
                      CustomTextField(
                        hintText: LocaleKeys.enterNickname.tr,
                        controller: controller.nicknameController,
                        onChange: (val) => controller.checkFormValidity(),
                      ),
                      10.kheightBox,
                      Text(
                        " ${LocaleKeys.email.tr}",
                        style: TextStyleUtil.genSans600(
                          fontSize: 12.ksp,
                          color: context.black,
                        ),
                      ),
                      3.kheightBox,
                      CustomTextField(
                        readOnly: true,
                        hintText: LocaleKeys.emailHint.tr,
                        controller: controller.emailController,
                        onChange: (val) => controller.checkFormValidity(),
                      ),
                      10.kheightBox,
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
