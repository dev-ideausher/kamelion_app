import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kamelion/app/components/activities/personality_test_appbar.dart';
import 'package:kamelion/app/models/personality_questions_model.dart';
import 'package:kamelion/app/routes/app_pages.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/custom_button.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';

import '../controllers/personality_questions_controller.dart';

class PersonalityQuestionsView extends GetView<PersonalityQuestionsController> {
  const PersonalityQuestionsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<PersonalityQuestionsController>(builder: (controller) {
        return controller.isLoading.value
            ? Container(
                child: Center(
                  child: CircularProgressIndicator(color: context.brandColor1),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    PersonalityTestAppBar(),
                    SafeArea(
                      top: false,
                      child: Padding(
                        padding: EdgeInsets.only(
                            right: 12.0.ksp, left: 12.0.ksp, top: 14.ksp),
                        child: Column(
                          children: [
                            ...controller
                                .personalityQestionsType.value.questions!
                                .asMap()
                                .entries
                                .map((entry) {
                              int index = entry.key;
                              Questions value = entry.value;
                              return Padding(
                                padding: EdgeInsets.only(bottom: 20.0.ksp),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${index + 1}.",
                                          style: TextStyleUtil.genNunitoSans400(
                                              fontSize: 12.ksp,
                                              color: context.black),
                                        ),
                                        6.kwidthBox,
                                        Flexible(
                                          child: Text(
                                            value.question ?? "",
                                            style:
                                                TextStyleUtil.genNunitoSans400(
                                                    fontSize: 12.ksp,
                                                    color: context.black),
                                          ),
                                        )
                                      ],
                                    ),
                                    12.kheightBox,
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        ...value.scales!
                                            .asMap()
                                            .entries
                                            .map((entry) {
                                          int index2 = entry.key;
                                          Scales value2 = entry.value;
                                          return Container(
                                            // color: context.redBg,
                                            width: context.width *
                                                (0.8 / value.scales!.length ??
                                                    0),
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  right: 0.0.ksp),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.all(0),
                                                    decoration: BoxDecoration(
                                                      color:
                                                          context.brandColor1,
                                                      borderRadius: BorderRadius
                                                          .circular(8
                                                              .ksp), // Rounded container
                                                    ),
                                                    child: StatefulBuilder(
                                                      builder:
                                                          (context, setState) {
                                                        bool isChecked = false;
                                                        return Checkbox(
                                                          // visualDensity: VisualDensity.compact,
                                                          materialTapTargetSize:
                                                              MaterialTapTargetSize
                                                                  .shrinkWrap,
                                                          fillColor:
                                                              MaterialStateProperty
                                                                  .resolveWith<
                                                                          Color>(
                                                                      (states) {
                                                            if (states.contains(
                                                                MaterialState
                                                                    .selected)) {
                                                              return context
                                                                  .brandColor1; // Checked background color
                                                            }
                                                            return context
                                                                .brandColor1; // Unchecked background color
                                                          }),
                                                          value: value2
                                                              .isSelected.value,
                                                          shape: CircleBorder(),
                                                          side: BorderSide(
                                                              color:
                                                                  context.white,
                                                              width:
                                                                  2), // Make checkbox round
                                                          onChanged: (value) {
                                                            controller
                                                                .markQuestion(
                                                                    aIndex:
                                                                        index2,
                                                                    qIndex:
                                                                        index);
                                                          },
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  6.kheightBox,
                                                  Text(
                                                    value2.value ?? "",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyleUtil
                                                        .genNunitoSans400(
                                                            fontSize: 10.ksp,
                                                            color:
                                                                context.black),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            }).toList()
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18.0),
                      child: CustomButton.outline(
                          onTap: () {
                            controller.submitAnswers();
                            // Get.toNamed(Routes.PERSONALITY_RESULTS);
                          },
                          title: 'Submit'),
                    ),
                    30.kheightBox
                  ],
                ),
              );
      }),
    );
  }
}
