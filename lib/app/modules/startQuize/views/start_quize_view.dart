import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:kamelion/app/components/common_image_view.dart';
import 'package:kamelion/app/constants/image_constant.dart';
import 'package:kamelion/app/routes/app_pages.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/custom_button.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';
import 'package:kamelion/generated/locales.g.dart';

import '../controllers/start_quize_controller.dart';

class StartQuizeView extends GetView<StartQuizeController> {
  const StartQuizeView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StartQuizeController>(builder: (controller) {
      return controller.isLoading.value
          ? Container(
              color: context.white,
              child: Center(
                child: CircularProgressIndicator(color: context.brandColor1),
              ),
            )
          : MaterialApp(builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: Scaffold(
                    backgroundColor: ColorUtil(context).completionScreenBg,
                    appBar: AppBar(
                        backgroundColor: ColorUtil(context).completionScreenBg),
                    body: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0.ksp),
                      child: Column(children: [
                        50.kheightBox,
                        Center(
                          child:
                              CommonImageView(svgPath: ImageConstant.klioBulb),
                        ),
                        30.kheightBox,
                        Text(
                          "Great job!",
                          style: TextStyleUtil.genSans500(
                            fontSize: 24.ksp,
                            color: context.black,
                          ),
                        ),
                        12.kheightBox,
                        Text(
                          "Great job finishing the workout! Now, how about a quick quiz to wrap it up?",
                          style: TextStyleUtil.genSans400(
                            fontSize: 12.5.ksp,
                            color: context.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        12.kheightBox,
                        Spacer(),
                        Card(
                          color: context.white,
                          child: Padding(
                            padding: EdgeInsets.all(8.ksp),
                            child: Text(
                              "No fail, just gains! Miss an answer? Replay the workout and flex that brain until you crush it!",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(12.0.ksp),
                          child: CustomButton.outline(
                            onTap: () {
                              Get.toNamed(
                                Routes.ONBOARDING_QUESTIONS,
                                arguments: controller.workoutId,
                              );
                            },
                            title: "Start Quiz",
                          ),
                        ),
                        30.kheightBox
                        // .kheightBox,
                      ]),
                    )),
              );
            });
    });
  }
}
