import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kamelion/app/components/activities/timeline_app_bar.dart';
import 'package:kamelion/app/components/common_image_view.dart';
import 'package:kamelion/app/constants/image_constant.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/custom_button.dart';
import 'package:kamelion/app/services/custom_textfield.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';
import 'package:kamelion/generated/locales.g.dart';

import '../controllers/create_time_line_controller.dart';

class CreateTimeLineView extends GetView<CreateTimeLineController> {
  const CreateTimeLineView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil(context).scaffoldBg,
      body: SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              TimelineAppBar(title: "Add New Journal",),
              Padding(
                padding: EdgeInsets.all(16.0.ksp),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Journal Title",
                        style: TextStyleUtil.genSans400(
                          fontSize: 12.ksp,
                          color: ColorUtil(context).greyDark,
                        ),
                      ),
                      6.kheightBox,
                      CustomTextField(hintText: "Feeling happy",
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter a journal title';
                          }
                          if (value.trim().length < 3) {
                            return 'Title must be at least 3 characters long';
                          } if (value.trim().length > 100) {
                            return 'Title must be less than 100 characters';
                          }
                          return null;
                        },
                      controller: controller.titleController,),
                      20.kheightBox,
                      Text(
                        "Write Your Entry",
                        style: TextStyleUtil.genSans400(
                          fontSize: 12.ksp,
                          color: ColorUtil(context).black,
                        ),
                      ),
                      6.kheightBox,
                      TextFormField(controller: controller.entryController,
              validator: (value) {
              if (value == null || value.trim().isEmpty) {
              return 'Please enter description';
              }
              if (value.trim().length < 3) {
              return 'Description must be at least 10 characters long';
              }   return null;
              },
                        decoration: InputDecoration(
                          hintText: "Enter a description...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              4.ksp,
                            ), // Rounded corners
                            borderSide: BorderSide(
                              color: ColorUtil(context).grey,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.ksp),
                            borderSide: BorderSide(
                              color: ColorUtil(context).grey,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.ksp),
                            borderSide: BorderSide(
                              color: ColorUtil(context).brandColor1,
                            ),
                          ),
                        ),
                        maxLines: 5,
                        onChanged: (value) {},
                      ),
                      20.kheightBox,
                      Text(
                        "Emotion",
                        style: TextStyleUtil.genSans400(
                          fontSize: 12.ksp,
                          color: ColorUtil(context).black,
                        ),
                      ),
                      6.kheightBox,
                      Container(
                        margin: EdgeInsets.all(0.ksp),
                        padding: EdgeInsets.all(0.ksp),
                        decoration: BoxDecoration(
                          color: ColorUtil(context).white,
                          borderRadius: BorderRadius.circular(6.ksp),
                          border: Border.all(color: ColorUtil(context).grey),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            20.kheightBox,
                            // Image
                            Obx(
                                  () => CommonImageView(
                                svgPath: controller.currentMoodImage.value,
                                height: 50.ksp,
                              ),
                            ),
                            5.kheightBox,
                            Obx(
                                  () => Text(
                                controller.currentMoodSelected.value.capitalize ?? "",
                                style: TextStyleUtil.genSans500(
                                  fontSize: 12.ksp,
                                  color: ColorUtil(context).brandColor1,
                                ),
                              ),
                            ),
                            1.kheightBox,
                            Obx(
                              () => SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  activeTrackColor:
                                      ColorUtil(
                                        context,
                                      ).brandColor1, // Slider active part color
                                  inactiveTrackColor: ColorUtil(context).grey,
                                  thumbColor:
                                      ColorUtil(context).white, // Tip color
                                  overlayColor: ColorUtil(
                                    context,
                                  ).brandColor1.withOpacity(0.2),
                                  trackHeight: 5.0.ksp,
                                  thumbShape: RoundSliderThumbShape(
                                    enabledThumbRadius: 8.ksp,
                                  ),
                                ),
                                child: Slider(
                                  value: controller.moodSliderLeval.value,
                                  min: 0,
                                  max: 100,
                                  divisions: 4,
                                  onChanged: (value) {
                                    controller.changeSliderValue(val: value);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      20.kheightBox,
                      Text(
                        LocaleKeys.feelings.tr,
                        style: TextStyleUtil.genSans400(
                          fontSize: 12.ksp,
                          color: ColorUtil(context).black,
                        ),
                      ),
                      6.kheightBox,
                      Container(
                        // margin: const EdgeInsets.all(16),
                        padding: EdgeInsets.all(12.ksp),
                        decoration: BoxDecoration(
                          color: ColorUtil(context).white,
                          border: Border.all(color: ColorUtil(context).grey),
                          borderRadius: BorderRadius.circular(5.ksp),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please enter a feelings';
                                }
          
                                return null;
                              },
                              controller: controller.feelingsController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: LocaleKeys.feelings_question.tr,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 0.ksp,
                                  vertical: 8.ksp,
                                ),
                              ),
                              onChanged: (value) {},
                            ),
                            10.kheightBox,
                            Wrap(
                              spacing: 6.ksp,
                              runSpacing: 9.ksp,
                              children:
                                  controller.feelingsKeywords
                                      .map(
                                        (keyword) => InkWell(
                                          onTap: () {
                                            controller.onFeelingSelected(
                                              keyword: keyword,
                                            );
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 10.ksp,
                                              vertical: 3.ksp,
                                            ),
                                            decoration: BoxDecoration(
                                              color:
                                                  context
                                                      .lighPitchBg, // background color
                                              borderRadius: BorderRadius.circular(
                                                16.ksp,
                                              ), // round corners
                                            ),
                                            child: Text(
                                              keyword,
                                              style: TextStyleUtil.genSans400(
                                                fontSize: 12.ksp,
                                                color: context.darkRedText,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                            ),
                          ],
                        ),
                      ),
                      20.kheightBox,
                      Text(
                        LocaleKeys.activities.tr,
                        style: TextStyleUtil.genSans400(
                          fontSize: 12.ksp,
                          color: ColorUtil(context).greyDark,
                        ),
                      ),
                      6.kheightBox,
                      CustomTextField(controller: controller.activitiesController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter activities';
                          }
                          if (value.trim().length < 3) {
                            return 'Activity must be at least 3 characters long';
                          } if (value.trim().length > 100) {
                            return 'Activity must be less than 100 characters';
                          }
                          return null;
                        },
                        hintText: LocaleKeys.activities_question.tr,
                      ),
                      20.kheightBox,
                      Obx(() => CustomButton.outline(
                        title: controller.isLoading.value ? "Saving..." : "Add Journal",
                        onTap: controller.isLoading.value ? null : () {
                          if(controller.formKey.currentState?.validate() ?? false){
                            controller.postJournalSave();
                          }

                        },
                      )),
                      60.kheightBox,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
