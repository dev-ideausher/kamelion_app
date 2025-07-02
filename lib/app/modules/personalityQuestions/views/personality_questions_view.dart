import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kamelion/app/components/activities/personality_test_appbar.dart';
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
      body: SingleChildScrollView(
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
                    ...["", "", "", "", ""]
                        .map(
                          (e) => Padding(
                            padding: EdgeInsets.only(bottom: 20.0.ksp),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "1.",
                                      style: TextStyleUtil.genNunitoSans400(
                                          fontSize: 12.ksp,
                                          color: context.black),
                                    ),
                                    6.kwidthBox,
                                    Flexible(
                                      child: Text(
                                        "Rank these superpowers: invisibility, flight, super strength, telepathy. Share your top choice and why it fits your personality.",
                                        style: TextStyleUtil.genNunitoSans400(
                                            fontSize: 12.ksp,
                                            color: context.black),
                                      ),
                                    )
                                  ],
                                ),
                                12.kheightBox,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ...["", "", "", ""].map(
                                      (e) => Padding(
                                        padding:
                                            EdgeInsets.only(right: 0.0.ksp),
                                        child: Column(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(0),
                                              decoration: BoxDecoration(
                                                color: context.brandColor1,
                                                borderRadius:
                                                    BorderRadius.circular(8
                                                        .ksp), // Rounded container
                                              ),
                                              child: StatefulBuilder(
                                                builder: (context, setState) {
                                                  bool isChecked = false;
                                                  return Checkbox(
                                                    // visualDensity: VisualDensity.compact,
                                                    materialTapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                    hoverColor: context.white,
                                                    value: true,
                                                    shape: CircleBorder(),
                                                    side: BorderSide(
                                                        color: context.white,
                                                        width:
                                                            2), // Make checkbox round
                                                    onChanged: (value) {
                                                      // setState(() {
                                                      //   isChecked = value!;
                                                      // });
                                                    },
                                                    activeColor: context.white,
                                                    checkColor: Colors.white,
                                                  );
                                                },
                                              ),
                                            ),
                                            6.kheightBox,
                                            Text(
                                              "Option A",
                                              style: TextStyleUtil
                                                  .genNunitoSans400(
                                                      fontSize: 12.ksp,
                                                      color: context.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                        .toList()
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.0),
              child: CustomButton.outline(
                  onTap: () {
                    Get.toNamed(Routes.PERSONALITY_RESULTS);
                  },
                  title: 'Submit'),
            ),
            30.kheightBox
          ],
        ),
      ),
    );
  }
}
