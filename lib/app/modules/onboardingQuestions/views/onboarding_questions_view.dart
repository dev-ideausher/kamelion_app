import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/components/common_image_view.dart';
import 'package:kamelion/app/constants/image_constant.dart';
import 'package:kamelion/app/routes/app_pages.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/custom_button.dart';
import 'package:kamelion/app/services/dialog_helper.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';
import 'package:kamelion/generated/locales.g.dart';
import '../controllers/onboarding_questions_controller.dart';

class OnboardingQuestionsView extends GetView<OnboardingQuestionsController> {
  const OnboardingQuestionsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, Object? result) {
          Future.delayed(Duration(milliseconds: 100), () {
            controller.goToPreviousQuestion();
          });
        },
        child: Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton:
              !(controller.currentQuetionIndex.value !=
                      (controller.onboardingQuestionsList.length - 1))
                  ? Padding(
                    padding: EdgeInsets.all(20.ksp),
                    child: CustomButton.outline(
                      onTap: () {
                        controller.submitAnswers();
                      },
                      title: LocaleKeys.submit.tr,
                    ),
                  )
                  : Padding(
                    padding: EdgeInsets.all(20.ksp),
                    child: CustomButton.outline(
                      onTap: () {
                        controller.goToNextQuestion();
                      },
                      title: "Next Question",
                    ),
                  ),
          appBar: AppBar(
            leading: InkWell(
              onTap: () => controller.goToPreviousQuestion(),
              child: Icon(Icons.arrow_back_ios, size: 14.ksp),
            ),
            titleSpacing: 0,
            title: Padding(
              padding: EdgeInsets.only(right: 15.0.ksp),
              child: LinearProgressIndicator(
                minHeight: 6.ksp,
                backgroundColor: ColorUtil(context).grey,
                color: ColorUtil(context).brandColor1,
                borderRadius: BorderRadius.circular(10.ksp),
                value:
                    ((controller.currentQuetionIndex.value + 1) /
                        (controller.onboardingQuestionsList.length + 1)),
              ),
            ),
          ),
          body:
              controller.onboardingQuestionsList.length == 0
                  ? Center(
                    child: CircularProgressIndicator(
                      color: Get.context?.brandColor1,
                    ),
                  )
                  : Padding(
                    padding: EdgeInsets.all(15.0.ksp),
                    child: SingleChildScrollView(
                      controller: controller.scrollController,
                      child: Column(
                        children: [
                          16.kheightBox,
                          Row(
                            children: [
                              CommonImageView(
                                svgPath: ImageConstant.cleoWriting,
                              ),
                              28.kwidthBox,
                              Column(
                                children: [
                                  Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Positioned(
                                        left: -15,
                                        top: 20,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(
                                                  0.2,
                                                ),
                                                blurRadius: 6.ksp,
                                                offset: Offset(2, 2),
                                              ),
                                            ],
                                          ),
                                          child: CustomPaint(
                                            painter: BubblePointerPainter(
                                              color: ColorUtil(context).white,
                                            ),
                                            size: Size(12, 12),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(12.ksp),
                                        width: context.width * 0.61,
                                        decoration: BoxDecoration(
                                          color: ColorUtil(context).white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(
                                                0.2,
                                              ),
                                              blurRadius: 6,
                                              offset: Offset(2, 2),
                                            ),
                                          ],
                                          borderRadius: BorderRadius.circular(
                                            16.ksp,
                                          ),
                                        ),
                                        child: Text(
                                          controller
                                                  .onboardingQuestionsList[controller
                                                      .currentQuetionIndex
                                                      .value]
                                                  .question ??
                                              "",
                                          style: TextStyleUtil.genSans500(
                                            color: ColorUtil(context).black,
                                            fontSize: 13.ksp,
                                            height: 1.2,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                  40.kheightBox,
                                ],
                              ),
                            ],
                          ),
                          30.kheightBox,
                          ...(controller
                                          .onboardingQuestionsList[controller
                                              .currentQuetionIndex
                                              .value]
                                          .questionType ==
                                      "MCQ") ||
                                  (controller
                                          .onboardingQuestionsList[controller
                                              .currentQuetionIndex
                                              .value]
                                          .questionType ==
                                      "MCQ Based")
                              ? controller
                                  .onboardingQuestionsList[controller
                                      .currentQuetionIndex
                                      .value]
                                  .options!
                                  .asMap()
                                  .entries
                                  .map((item) {
                                    return Padding(
                                      padding: EdgeInsets.only(bottom: 11.ksp),
                                      child: InkWell(
                                        onTap:
                                            () => controller.selectAnswer(
                                              answerIndex: controller
                                                  .onboardingQuestionsList[controller
                                                      .currentQuetionIndex
                                                      .value]
                                                  .options!
                                                  .indexOf(item.value),
                                              questionIndex:
                                                  controller
                                                      .currentQuetionIndex
                                                      .value,
                                            ),
                                        child: Container(
                                          width: context.width,
                                          padding: EdgeInsets.symmetric(
                                            vertical: 9.5.ksp,
                                            horizontal: 11.ksp,
                                          ),
                                          decoration: BoxDecoration(
                                            color: ColorUtil(context).white,
                                            borderRadius: BorderRadius.circular(
                                              30.ksp,
                                            ), // Rounded corners
                                            border: Border.all(
                                              color:
                                                  (controller
                                                              .onboardingQuestionsList[controller
                                                                  .currentQuetionIndex
                                                                  .value]
                                                              .isOptionSelected[item
                                                              .key] ==
                                                          1)
                                                      ? ColorUtil(
                                                        context,
                                                      ).brandColor1
                                                      : ColorUtil(context).grey,
                                              width:
                                                  1.5, // Optional: border thickness
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              item.value,
                                              textAlign: TextAlign.center,
                                              style: TextStyleUtil.genSans500(
                                                fontSize: 11.5.ksp,
                                                color:
                                                    (controller
                                                                .onboardingQuestionsList[controller
                                                                    .currentQuetionIndex
                                                                    .value]
                                                                .isOptionSelected[item
                                                                .key] ==
                                                            1)
                                                        ? ColorUtil(
                                                          context,
                                                        ).brandColor1
                                                        : ColorUtil(
                                                          context,
                                                        ).greyDark,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  })
                                  .toList()
                              : [
                                Center(
                                  child: SliderTheme(
                                    data: SliderTheme.of(context).copyWith(
                                      showValueIndicator:
                                          ShowValueIndicator.always,
                                      valueIndicatorShape:
                                          SquareValueIndicatorWithShadow(),
                                      valueIndicatorColor:
                                          ColorUtil(context).white,
                                      valueIndicatorTextStyle: TextStyle(
                                        color: ColorUtil(context).black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      thumbColor: ColorUtil(context).white,
                                      activeTrackColor:
                                          ColorUtil(context).brandColor1,
                                    ),
                                    child: Slider(
                                      value:
                                          (controller
                                                  .onboardingQuestionsList[controller
                                                      .currentQuetionIndex
                                                      .value]
                                                  .isOptionSelected[0])
                                              .toDouble(),
                                      min: 0,
                                      max: 10,
                                      label: (controller
                                              .onboardingQuestionsList[controller
                                                  .currentQuetionIndex
                                                  .value]
                                              .isOptionSelected[0])
                                          .toStringAsFixed(1),
                                      onChanged: (value) {
                                        controller
                                                .onboardingQuestionsList[controller
                                                    .currentQuetionIndex
                                                    .value]
                                                .isOptionSelected[0] =
                                            value.toInt();
                                      },
                                    ),
                                  ),
                                ),
                              ],
                          140.kheightBox,
                        ],
                      ),
                    ),
                  ),
        ),
      ),
    );
  }
}

class BubblePointerPainter extends CustomPainter {
  final Color color;

  BubblePointerPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path =
        Path()
          ..moveTo(0, size.height / 2)
          ..lineTo(size.width + 15, 0)
          ..lineTo(size.width, size.height)
          ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class SquareValueIndicatorWithShadow extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) => Size(50, 40);

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final canvas = context.canvas;

    final double boxWidth = labelPainter.width + 16;
    final double boxHeight = labelPainter.height + 12;

    final RRect rrect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(center.dx, center.dy + 35), // Position below thumb
        width: boxWidth,
        height: boxHeight,
      ),
      Radius.circular(8),
    );

    // Draw shadow
    canvas.drawShadow(Path()..addRRect(rrect), Colors.black54, 4, true);

    // Draw background
    final paint = Paint()..color = Colors.white;
    canvas.drawRRect(rrect, paint);

    // Draw text
    labelPainter.paint(
      canvas,
      Offset(
        center.dx - labelPainter.width / 2,
        center.dy + 35 - labelPainter.height / 2,
      ),
    );
  }
}
