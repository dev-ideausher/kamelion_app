import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kamelion/app/components/common_image_view.dart';
import 'package:kamelion/app/constants/image_constant.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    controller.directBasedOnLoginStatus();
    return Scaffold(
      // backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          SizedBox.expand(
            child: CommonImageView(imagePath: ImageConstant.splashScreenBg),
          ),
          Center(child: CommonImageView(svgPath: ImageConstant.logoWithText)),
        ],
      ),
    );
  }
}
