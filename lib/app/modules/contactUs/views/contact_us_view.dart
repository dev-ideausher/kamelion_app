import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kamelion/app/modules/settings/views/settings_view.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/custom_button.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';

import '../controllers/contact_us_controller.dart';

class ContactUsView extends GetView<ContactUsController> {
  const ContactUsView({super.key});
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
      body: Column(
        children: [
          SettingAppBar(title: 'Contact Us'),
          Padding(
            padding: EdgeInsets.all(12.ksp),
            child: Column(
              children: [
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
                    child: Text(
                      "Write your suggestions and we will get back to you asap.",
                      textAlign: TextAlign.center,
                      style: TextStyleUtil.genNunitoSans500(
                          fontSize: 10.ksp, color: context.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
