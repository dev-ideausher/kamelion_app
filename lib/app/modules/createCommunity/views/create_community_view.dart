import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kamelion/app/components/common_image_view.dart';
import 'package:kamelion/app/constants/image_constant.dart';
import 'package:kamelion/app/models/mental_gym_category_model.dart';
import 'package:kamelion/app/models/mental_gyms_details_model.dart';
import 'package:kamelion/app/modules/mentalGym/controllers/mental_gym_controller.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/custom_button.dart';
import 'package:kamelion/app/services/custom_textfield.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';
import 'package:kamelion/generated/locales.g.dart';
import '../controllers/create_community_controller.dart';

class CreateCommunityView extends GetView<CreateCommunityController> {
  const CreateCommunityView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0.ksp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Create a" + " ",
                  style: TextStyleUtil.genSans500(
                    fontSize: 20.ksp,
                    color: ColorUtil(context).black,
                  ),
                ),
                Text(
                  "Community",
                  style: TextStyleUtil.genSans500(
                    fontSize: 20.ksp,
                    color: ColorUtil(context).brandColor1,
                  ),
                ),
              ],
            ),
            4.kheightBox,
            Row(
              children: [
                Text(
                  " " + LocaleKeys.signupSubtitle.tr,
                  // 'The Feel-Good Wellbeing Platform You Deserve ',
                  style: TextStyleUtil.genSans300(
                    fontSize: 12.ksp,
                    color: ColorUtil(context).black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            30.kheightBox,
            Text(
              " Name of the community",
              style: TextStyleUtil.genSans300(
                fontSize: 12.ksp,
                color: context.black,
              ),
            ),
            6.kheightBox,
            CustomTextField(
              hintText: LocaleKeys.fullNameHint.tr,
              controller: controller.nameController,
              onChange: (val) => controller.checkFormValidity(),
            ),
            10.kheightBox,
            Text(
              " Category",
              style: TextStyleUtil.genSans300(
                fontSize: 12.ksp,
                color: context.black,
              ),
            ),
            6.kheightBox,
            DropdownSearch<MentalGymCategoryModel>(
              items:
                  (filter, infiniteScrollProps) =>
                      Get.find<MentalGymController>().mentalGymCategoryList,
              compareFn: (a, b) => a.sId == b.sId,
              decoratorProps: DropDownDecoratorProps(
                baseStyle: TextStyleUtil.genSans400(
                  fontSize: 12.ksp,
                  color: context.black,
                ),
                decoration: InputDecoration(
                  hintText: "  Select category",
                  hintStyle: TextStyleUtil.genSans400(
                    fontSize: 12.ksp,
                    color: context.greyDark,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.ksp),
                    borderSide: BorderSide(color: ColorUtil(context).grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: context.brandColor1, // 🔵 ACTIVE BORDER COLOR
                      width: 1,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: context.grey),
                  ),
                ),
              ),
              popupProps: PopupProps.menu(
                showSearchBox: true,
                searchFieldProps: TextFieldProps(
                  decoration: InputDecoration(
                    hintText: "Enter category",
                    hintStyle: TextStyleUtil.genSans400(
                      fontSize: 12.ksp,
                      color: context.grey,
                    ),
                  ),
                ),
              ),
              selectedItem: controller.selectedCategory,
              onChanged: (value) {
                controller.selectedCategory = value;
                controller.checkFormValidity();
              },
            ),
            10.kheightBox,
            Text(
              " Community profile image",
              style: TextStyleUtil.genSans300(
                fontSize: 12.ksp,
                color: context.black,
              ),
            ),
            6.kheightBox,
            Obx(() {
              var imageFile = controller.croppedCommunityImage.value;
              return GestureDetector(
                onTap: () {
                  controller.pickAndCropImage();
                },
                child:
                    imageFile.path == ""
                        ? DottedBorderContainer(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.cloud_upload_outlined,
                                size: 30.ksp,
                                color: context.grey,
                              ),
                              10.kheightBox,
                              Text(
                                "Browse and choose the files you want to upload from your computer",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: context.greyDark),
                              ),
                              14.kheightBox,
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6.ksp),
                                  color: context.brandColor1,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(4.0.ksp),
                                  child: Icon(
                                    Icons.add,
                                    size: 20.ksp,
                                    color: context.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                        : InkWell(
                          child: CommonImageView(
                            file: File(
                              controller.croppedCommunityImage.value.path,
                            ),
                          ),
                        ),
              );
            }),
            Spacer(),
            Obx(
              () => CustomButton.outline(
                onTap: () {
                  controller.createCommunity();
                },
                disabled: !controller.enabelCreateBotton.value,
                title: 'Create with 300',
                trailing: CommonImageView(
                  svgPath:
                      // controller.enabelCreateBotton.value
                      // ?
                      ImageConstant.coinIcon,
                  // : ImageConstant.coinStackIconWhite,
                ),
              ),
            ),
            40.kheightBox,
          ],
        ),
      ),
    );
  }
}

class DottedBorderContainer extends StatelessWidget {
  final Widget child;

  const DottedBorderContainer({Key? key, required this.child})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.ksp),
      decoration: BoxDecoration(
        border: Border.all(
          color: context.grey,
          style: BorderStyle.solid,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(4.ksp),
      ),
      child: child,
    );
  }
}
