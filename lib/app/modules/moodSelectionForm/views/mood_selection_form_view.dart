import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kamelion/app/components/common_image_view.dart';
import 'package:kamelion/app/constants/image_constant.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/custom_button.dart';
import 'package:kamelion/app/services/custom_textfield.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';
import 'package:kamelion/generated/locales.g.dart';
import '../controllers/mood_selection_form_controller.dart';

class MoodSelectionFormView extends GetView<MoodSelectionFormController> {
  MoodSelectionFormView({super.key});
  final MoodSelectionFormController controller = Get.put(
    MoodSelectionFormController(),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil(context).scaffoldBg,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: EdgeInsets.only(left: 20.0.ksp),
            child: Icon(Icons.arrow_back_ios, size: 14.ksp),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0.ksp),
            child: Text(
              "${LocaleKeys.today.tr},"
              // "${DateFormat('HH:mm').format(DateTime.now())}",
              " ${controller.time != null ? (controller.time) : (DateFormat('HH:mm').format(DateTime.now()))}",
              style: TextStyleUtil.genSans400(
                fontSize: 10.ksp,
                color: ColorUtil(context).black,
              ),
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.ksp),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.mood.tr,
                style: TextStyleUtil.genSans400(
                  fontSize: 12.ksp,
                  color: ColorUtil(context).black,
                ),
              ),
              6.kheightBox,
              // Container(
              //   width: double.infinity,
              //   margin: EdgeInsets.all(0.ksp),
              //   padding: EdgeInsets.all(0.ksp),
              //   decoration: BoxDecoration(
              //     color: ColorUtil(context).white,
              //     borderRadius: BorderRadius.circular(6.ksp),
              //     border: Border.all(color: ColorUtil(context).grey),
              //   ),
              //   child: Column(
              //     mainAxisSize: MainAxisSize.min,
              //     children: [
              //       20.kheightBox,
              //       // Image
              //       CommonImageView(
              //         svgPath:
              //             controller.currentMoodSelected.value == "unhappy"
              //                 ? ImageConstant.unHappyMood
              //                 : controller.currentMoodSelected.value == "sad"
              //                 ? ImageConstant.sadMood
              //                 : controller.currentMoodSelected.value == "normal"
              //                 ? ImageConstant.normalMood
              //                 : controller.currentMoodSelected.value == "good"
              //                 ? ImageConstant.goodMood
              //                 : ImageConstant.happyMood,
              //         height: 50.ksp,
              //       ),
              //       5.kheightBox,
              //       Text(
              //         (controller.currentMoodSelected.value ?? "").capitalize ??
              //             "",
              //         style: TextStyleUtil.genSans500(
              //           fontSize: 12.ksp,
              //           color: ColorUtil(context).brandColor1,
              //         ),
              //       ),
              //       1.kheightBox,
              //       // Obx(
              //       //   () => SliderTheme(
              //       //     data: SliderTheme.of(context).copyWith(
              //       //       activeTrackColor:
              //       //           ColorUtil(
              //       //             context,
              //       //           ).brandColor1, // Slider active part color
              //       //       inactiveTrackColor: ColorUtil(context).grey,
              //       //       thumbColor: ColorUtil(context).white, // Tip color
              //       //       overlayColor: ColorUtil(
              //       //         context,
              //       //       ).brandColor1.withOpacity(0.2),
              //       //       trackHeight: 5.0.ksp,
              //       //       thumbShape: RoundSliderThumbShape(
              //       //         enabledThumbRadius: 8.ksp,
              //       //       ),
              //       //     ),
              //       //     child: Slider(
              //       //       value: controller.moodSliderLeval.value,
              //       //       min: 0,
              //       //       max: 100,
              //       //       divisions: 100,
              //       //       onChanged: (value) {
              //       //         controller.changeSliderValue(val: value);
              //       //       },
              //       //     ),
              //       //   ),
              //       // ),
              //     ],
              //   ),
              // ),
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
                          activeTrackColor: ColorUtil(
                            context,
                          ).brandColor1, // Slider active part color
                          inactiveTrackColor: ColorUtil(context).grey,
                          thumbColor: ColorUtil(context).white, // Tip color
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
                LocaleKeys.your_note.tr,
                style: TextStyleUtil.genSans400(
                  fontSize: 12.ksp,
                  color: ColorUtil(context).black,
                ),
              ),
              6.kheightBox,
              TextFormField(
                readOnly: !(controller.time == null),
                controller: controller.noteController,
                decoration: InputDecoration(
                  hintText: LocaleKeys.type_something.tr,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      4.ksp,
                    ), // Rounded corners
                    borderSide: BorderSide(color: ColorUtil(context).grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.ksp),
                    borderSide: BorderSide(color: ColorUtil(context).grey),
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
                      readOnly: !(controller.time == null),
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
                    if (controller.time == null)
                      Wrap(
                        spacing: 6.ksp,
                        runSpacing: 9.ksp,
                        children: controller.feelingsKeywords
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
                                        context.lighPitchBg, // background color
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
                  color: ColorUtil(context).black,
                ),
              ),
              6.kheightBox,
              CustomTextField(
                readOnly: !(controller.time == null),
                hintText: LocaleKeys.activities_question.tr,
                controller: controller.activitiesController,
              ),
              20.kheightBox,
              controller.time == null
                  ? CustomButton.outline(
                      onTap: () {
                        controller.addMood();
                      },
                      title: LocaleKeys.save_check_in.tr,
                    )
                  : Container(),
              60.kheightBox,
            ],
          ),
        ),
      ),
    );
  }
}
