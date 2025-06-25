import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/components/common_image_view.dart';
import 'package:kamelion/app/constants/image_constant.dart';
import 'package:kamelion/app/routes/app_pages.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/custom_button.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';
import 'package:kamelion/generated/locales.g.dart';
import '../controllers/get_started_controller.dart';

class GetStartedView extends GetView<GetStartedController> {
  const GetStartedView({super.key});
  @override
  Widget build(BuildContext context) {
    if (!(Get.arguments is String))
      controller.isOnboardingFormSubmited = Get.arguments ?? false;
    else
      controller.isOnboardingFormSubmited = false;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.all(20.ksp),
        child: CustomButton.outline(
          onTap: () {
            controller.onButtonClick();
          },
          title:
              controller.isOnboardingFormSubmited
                  ? LocaleKeys.personaliseAvatar.tr
                  : LocaleKeys.getStarted.tr,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(30.0.ksp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpeechBubble(
              text:
                  controller.isOnboardingFormSubmited
                      ? LocaleKeys.greatJobMessage.tr
                      : LocaleKeys.welcomeMessage.tr,
              // "Hi, I am Cleo, before starting we will be asking you some questions.",
            ),
            10.kheightBox,
            Center(
              child: CommonImageView(
                svgPath:
                    controller.isOnboardingFormSubmited
                        ? ImageConstant.cleoBlinking
                        : ImageConstant.cleoSayingHi,
              ),
            ),
            30.kheightBox,
          ],
        ),
      ),
    );
  }
}

class SpeechBubble extends StatelessWidget {
  final String text;

  const SpeechBubble({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.ksp),
      decoration: ShapeDecoration(
        color: Colors.white,
        shadows: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(2, 4),
          ),
        ],
        shape: TooltipShapeBorder(arrowArc: 0.5),
      ),
      child: Text(
        text,
        style: TextStyleUtil.genSans400(
          color: ColorUtil(context).black,
          fontSize: 12.9.ksp,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

// Custom Speech Bubble Shape
class TooltipShapeBorder extends ShapeBorder {
  final double arrowArc;
  TooltipShapeBorder({this.arrowArc = 0.2});

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.only(bottom: 10);

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    double x = rect.left;
    double y = rect.top;
    double w = rect.width;
    double h = rect.height;

    final path =
        Path()
          ..moveTo(x + 20, y)
          ..lineTo(x + w - 20, y)
          ..quadraticBezierTo(x + w, y, x + w, y + 20)
          ..lineTo(x + w, y + h - 20)
          ..quadraticBezierTo(x + w, y + h, x + w - 20, y + h)
          ..lineTo(x + w / 2 + 10, y + h)
          ..lineTo(x + w / 2, y + h + 10) // arrow
          ..lineTo(x + w / 2 - 10, y + h)
          ..lineTo(x + 20, y + h)
          ..quadraticBezierTo(x, y + h, x, y + h - 20)
          ..lineTo(x, y + 20)
          ..quadraticBezierTo(x, y, x + 20, y)
          ..close();

    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) => Path();
}
