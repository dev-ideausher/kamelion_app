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
      body: Column(
        children: [
          PersonalityTestAppBar(),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.ksp),
              child: GridView.builder(
                itemCount: 3,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 items per row
                  crossAxisSpacing: 10.ksp,
                  mainAxisSpacing: 10.ksp,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Get.toNamed(Routes.PERSONALITY_QUESTIONS);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: context.white,
                        border: Border.all(color: context.brandBorderColor),
                        borderRadius:
                            BorderRadius.circular(14.ksp), // Rounded corners
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // 20.kheightBox,
                          ClipOval(
                            child: Image.network(
                              'https://plus.unsplash.com/premium_photo-1714138490043-40cbd9d982dc?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8YmFkZ2V8ZW58MHx8MHx8fDA%3D',
                              width: 65.ksp,
                              height: 65.ksp,
                              fit: BoxFit.cover,
                            ),
                          ),
                          10.kheightBox,
                          Text(
                            "Self Compassion Test",
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
      ),
    );
  }
}
