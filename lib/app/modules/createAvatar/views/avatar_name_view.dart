import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttermoji/fluttermojiCircleAvatar.dart';

import 'package:get/get.dart';
import 'package:kamelion/app/components/common_image_view.dart';
import 'package:kamelion/app/modules/createAvatar/controllers/create_avatar_controller.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/custom_textfield.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';
import 'package:kamelion/generated/locales.g.dart';

class AvatarNameView extends GetView<CreateAvatarController> {
  const AvatarNameView({super.key});
  @override
  Widget build(BuildContext context) {
    print(controller.userAvatar);
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.createAvatar.tr),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              controller.submitName();
            },
            child: Text(
              LocaleKeys.done.tr,
              style: TextStyleUtil.genSans500(
                fontSize: 12.ksp,
                color: ColorUtil(context).brandColor1,
              ),
            ),
          ),
          20.kwidthBox,
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.ksp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            context.width.kwidthBox,
            50.kheightBox,
            FluttermojiCircleAvatar(
              backgroundColor: ColorUtil(context).greyBg,
              radius: 80,
            ),
            60.kheightBox,
            Row(
              children: [
                Text(
                  " " + LocaleKeys.enterNickname.tr,
                  style: TextStyleUtil.genSans500(
                    fontSize: 12.ksp,
                    color: context.greyDark,
                  ),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            10.kheightBox,
            CustomTextField(
              hintText: LocaleKeys.fullNameHint.tr,
              controller: controller.nickNameController,
            ),
          ],
        ),
      ),
    );
  }
}
