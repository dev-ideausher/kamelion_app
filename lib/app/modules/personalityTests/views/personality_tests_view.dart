import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kamelion/app/components/activities/personality_test_appbar.dart';
import 'package:kamelion/app/routes/app_pages.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';

import '../controllers/personality_tests_controller.dart';

class PersonalityTestsView extends GetView<PersonalityTestsController> {
  const PersonalityTestsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<PersonalityTestsController>(builder: (controller) {
        return controller.isLoading.value
            ? Container(
                child: Center(
                  child: CircularProgressIndicator(color: context.brandColor1),
                ),
              )
            : Column(
                children: [
                  PersonalityTestAppBar(),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0.ksp),
                      child: GridView.builder(
                        itemCount:
                            controller.personalityQestionsType.value.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // 2 items per row
                          crossAxisSpacing: 10.ksp,
                          mainAxisSpacing: 10.ksp,
                          childAspectRatio: 0.8,
                        ),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Get.toNamed(Routes.PERSONALITY_QUESTIONS,
                                  arguments: controller.personalityQestionsType
                                          .value[index].sId ??
                                      "");
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: context.white,
                                border:
                                    Border.all(color: context.brandBorderColor),
                                borderRadius: BorderRadius.circular(
                                    14.ksp), // Rounded corners
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // 20.kheightBox,
                                  ClipOval(
                                    child: Image.network(
                                      controller.personalityQestionsType[index]
                                              .image ??
                                          "",
                                      width: 65.ksp,
                                      height: 65.ksp,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  10.kheightBox,
                                  Text(
                                    controller.personalityQestionsType[index]
                                            .title ??
                                        "",
                                    style: TextStyleUtil.genSans600(
                                      fontSize: 13.ksp,
                                      color: context.black,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  // 16.kheightBox,
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
      }),
    );
  }
}
