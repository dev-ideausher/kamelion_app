import 'package:flutter/material.dart';
import 'package:fluttermoji/fluttermojiCircleAvatar.dart';
import 'package:fluttermoji/fluttermojiController.dart';
import 'package:fluttermoji/fluttermojiCustomizer.dart';
import 'package:fluttermoji/fluttermojiSaveWidget.dart';
import 'package:fluttermoji/fluttermojiThemeData.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';
import 'package:kamelion/generated/locales.g.dart';
import '../controllers/create_avatar_controller.dart';

class CreateAvatarView extends GetView<CreateAvatarController> {
  CreateAvatarView({super.key}) {
    Get.put(FluttermojiController());
  }
  @override
  Widget build(BuildContext context) {
    if (Get.arguments != null) {
      controller.fromScreen = Get.arguments["from"];
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.createAvatar.tr),
        centerTitle: true,
        actions: [
          RepaintBoundary(
            child: FluttermojiSaveWidget(
              onTap: () {
                controller.submitAvatar(context: context);
              },
              child: Text(
                LocaleKeys.done.tr,
                style: TextStyleUtil.genSans500(
                  fontSize: 12.ksp,
                  color: ColorUtil(context).brandColor1,
                ),
              ),
            ),
          ),
          20.kwidthBox,
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // 50.kheightBox,
            Spacer(),
            FluttermojiCircleAvatar(
              backgroundColor: ColorUtil(context).blueBg,
              radius: 72.ksp,
            ),
            Spacer(),
            FluttermojiCustomizer(
              theme: FluttermojiThemeData(
                labelTextStyle: TextStyleUtil.genSans400(
                  fontSize: 15.ksp,
                  color: ColorUtil(context).black,
                ),
              ),
              scaffoldHeight: context.height * 0.5,
            ), // This opens the full editor
            // 4.kheightBox,
          ],
        ),
      ),
    );
  }
}
