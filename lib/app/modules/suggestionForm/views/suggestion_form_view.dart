import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kamelion/app/modules/settings/views/settings_view.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/custom_button.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';

import '../controllers/suggestion_form_controller.dart';

class SuggestionFormView extends GetView<SuggestionFormController> {
  const SuggestionFormView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Obx(
        () => Padding(
          padding: EdgeInsets.all(12.ksp),
          child: CustomButton.outline(
              onTap: () {
                controller.createPost();
              },
              disabled: !controller.enableButton.value,
              title: 'Submit'),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SettingAppBar(title: 'Make a suggestion'),
            Padding(
              padding: EdgeInsets.all(12.ksp),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Where do you want to suggest?",
                        style: TextStyleUtil.genNunitoSans500(
                          fontSize: 14.ksp,
                          color: context.black,
                        ),
                      ),
                    ],
                  ),
                  10.kheightBox,
                  DropdownSearch<String>(
                    items: (filter, infiniteScrollProps) =>
                        ["Feature", "Brand", "Content"],
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
                          borderSide:
                              BorderSide(color: ColorUtil(context).grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color:
                                context.brandColor1, // 🔵 ACTIVE BORDER COLOR
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
                  20.kheightBox,
                  Row(
                    children: [
                      Text(
                        "Where do you want to suggest?",
                        style: TextStyleUtil.genNunitoSans500(
                          fontSize: 14.ksp,
                          color: context.black,
                        ),
                      ),
                    ],
                  ),

                  // 10.kheightBox,
                  10.kheightBox,
                  TextFormField(
                    controller: controller.postContentController,
                    decoration: InputDecoration(
                      hintText: "Enter a description...",
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
                    maxLines: 8,
                    onChanged: (value) {
                      controller.checkFormValidity();
                    },
                  ),
                  16.kheightBox,
                  Card(
                    color: context.white,
                    elevation: 4,
                    child: Padding(
                      padding: EdgeInsets.all(8.0.ksp),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyleUtil.genNunitoSans500(
                            fontSize: 11.ksp,
                            color: context.black,
                          ),
                          children: [
                            const TextSpan(
                              text:
                                  "Write your suggestions and we will get back to you asap.",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
