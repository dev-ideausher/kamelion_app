import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/components/common_image_view.dart';
import 'package:kamelion/app/constants/image_constant.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/custom_button.dart';
import 'package:kamelion/app/services/custom_textfield.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';
import 'package:lottie/lottie.dart';
import '../controllers/get_school_controller.dart';

class GetSchoolView extends GetView<GetSchoolController> {
  const GetSchoolView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton:
            controller.isSchoolSubmited.value
                ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.ksp),
                  child: CustomButton.outline(
                    onTap: () {
                      Get.back();
                    },
                    title: "Exit",
                    disabled: !controller.isSchoolSubmited.value,
                  ),
                )
                : Container(),
        body: SafeArea(
          child: Container(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.all(12.ksp),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:
                      controller.isSchoolSubmited.value
                          ? [
                            (context.height * 0.2).kheightBox,
                            Lottie.asset(
                              'assets/lottiefiles/school_gif.json',
                              width: 200,
                              height: 200,
                              repeat: true, // loops like a GIF
                              animate: true,
                            ),
                            40.kheightBox,
                            Text(
                              "Your response has been submitted",
                              textAlign: TextAlign.center,
                              style: TextStyleUtil.genSans500(
                                fontSize: 19.ksp,
                                height: 1.1,
                                color: ColorUtil(context).black,
                              ),
                            ),
                            20.kheightBox,
                            Text(
                              "Our team will get back to you as soon as possible.",
                              textAlign: TextAlign.center,
                              style: TextStyleUtil.genSans400(
                                fontSize: 12.ksp,
                                height: 1.2,
                                color: ColorUtil(context).black,
                              ),
                            ),
                            100.kheightBox,
                          ]
                          : [
                            40.kheightBox,
                            CommonImageView(
                              svgPath: ImageConstant.kamelionConfused,
                            ),
                            30.kheightBox,
                            Text(
                              "Thank you for your interest in Kamelion",
                              textAlign: TextAlign.center,
                              style: TextStyleUtil.genSans500(
                                fontSize: 19.ksp,
                                height: 1.1,
                                color: ColorUtil(context).black,
                              ),
                            ),
                            20.kheightBox,
                            Text(
                              "We'll get back to you soon with access details. Please provide the school name.",
                              textAlign: TextAlign.center,
                              style: TextStyleUtil.genSans400(
                                fontSize: 12.ksp,
                                height: 1.2,
                                color: ColorUtil(context).black,
                              ),
                            ),
                            180.kheightBox,
                            CustomTextField(
                              controller: controller.schoolNameController,
                              onChange: (a) => controller.checkFormValidity(),
                              prefixIconWidget: Padding(
                                padding: EdgeInsets.only(right: 0.0.ksp),
                                child: Icon(
                                  Icons.home_outlined,
                                  color: context.greyDark,
                                ),
                              ),
                              hintText: "Enter school name",
                            ),
                            12.kheightBox,
                            CustomButton.outline(
                              onTap: () => controller.submitForm(),
                              title: "Submit",
                              disabled: !controller.isNameValid.value,
                            ),
                          ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
